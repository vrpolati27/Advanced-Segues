//
//  BackToBach.swift
//  Advanced Segues
//
//  Created by Vinay Reddy Polati on 9/18/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import AVFoundation;

class BackToBach: UIViewController {
    @IBOutlet weak var volumeSilder: UISlider!
    @IBOutlet weak var songTrackingSlider: UISlider! 
    var player = AVAudioPlayer();
    var audioFilePaths:[String] = [];
    var currentSong:Int = 0;
    
    @IBAction func volumeControlAction(_ sender: Any) {
        player.volume = volumeSilder.value;
    }
    
    
    @IBAction func songControlAction(_ sender: Any) {
        print("duration: \(player.duration), currentTime: \(player.currentTime)");
        player.currentTime = player.duration * Double(songTrackingSlider.value) ;
    }
    @IBAction func pauseMusicAction(_ sender: Any) {
        player.pause();
    }
    
    @IBAction func playMusicAction(_ sender: Any) {
        player.play();
    }
    
    func addSongs(){
        let songs:[String] = ["song2", "song1", "song3", "song4",];
        for c1 in 0..<songs.count {
            audioFilePaths.append(Bundle.main.path(  forResource: songs[c1], ofType: "mp3" )!);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        /* add all songs */
        
        addSongs();
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFilePaths[0]));
            player.play();
        } catch {
            print("ERROR: error playing audio. ");
        }
        
        // swipe right.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)));
        swipeRight.direction = UISwipeGestureRecognizerDirection.right;
        self.view.addGestureRecognizer(swipeRight);
        // swipe left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)));
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left;
        self.view.addGestureRecognizer(swipeLeft);
        
        // swipe up
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)));
        swipeUP.direction = UISwipeGestureRecognizerDirection.up;
        self.view.addGestureRecognizer(swipeUP);
        
        // swipe down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)));
        swipeDown.direction = UISwipeGestureRecognizerDirection.down;
        self.view.addGestureRecognizer(swipeDown);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* chnages the volume. */
    func changeVolume(by level:Int) {
        var volume = player.volume;
        volume += level == 1 ? 0.2 : -0.2;
        if volume > 1 {
            volume = 1;
        } else if(volume < 0){
            volume = 0;
        }
        player.volume = volume;
        volumeSilder.value = player.volume;
    }
    
    /* changes the song. */
    func changeSong(by margin:Int) {
        currentSong += margin;
        if currentSong == audioFilePaths.count   {
            currentSong = 0;
        } else if (currentSong == -1 ) {
            currentSong = audioFilePaths.count-1;
            
        }
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFilePaths[currentSong]));
            player.play()
        } catch {
            print("ERROR: error playing audio. ");
        }
    }
    
    @objc func swiped(gesture:UIGestureRecognizer) {
        if let _gesture = gesture as? UISwipeGestureRecognizer {
            switch _gesture.direction {
                case UISwipeGestureRecognizerDirection.left:
                                                        print("swiped left");
                                                        changeSong(by:-1);
                case UISwipeGestureRecognizerDirection.right:
                                                        print("swiped right");
                                                        changeSong(by: 1);
                case UISwipeGestureRecognizerDirection.up:
                                                         print("swiped up");
                                                        changeVolume(by: 1)
                case UISwipeGestureRecognizerDirection.down:
                                                        print("swiped down");
                                                        changeVolume(by: -1)
            default:
                break;
            }
        }
    }
    
    /* Detect shake Event. */
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            if player.isPlaying {
                print("phone shaken, Pausing Music");
                player.pause();
            } else {
                print("phone shaken, playing Music");
                player.play();
            }
            print(" Your iPhone shaken.");
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
