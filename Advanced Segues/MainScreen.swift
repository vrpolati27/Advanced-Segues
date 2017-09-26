//
//  MainScreen.swift
//  Advanced Segues
//
//  Created by Vinay Reddy Polati on 9/18/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import AVFoundation;

class MainScreen: UIViewController {

    var player = AVAudioPlayer();
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBAction func playMusic(_ sender: Any) {
        player.play();
    }
    
    @IBAction func pauseMusic(_ sender: Any) {
        player.pause();
    }
    
    
    
    @IBAction func controlVolumeAction(_ sender: Any) {
        player.volume = volumeSlider.value;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let audioPath = Bundle.main.path(forResource: "song1", ofType: "mp3");
        /*print("Audio File path \(audioPath)");*/
        do{
            if let audioLocation = audioPath {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioLocation));
                /*player.play();*/
            }
        } catch {
            // process any Errors.
            print("Error occured. ");
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
