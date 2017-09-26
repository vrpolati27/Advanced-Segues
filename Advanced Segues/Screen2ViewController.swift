//
//  Screen2ViewController.swift
//  Advanced Segues
//
//  Created by Vinay Reddy Polati on 9/17/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit

class Screen2ViewController: UIViewController {
    var address:String = "United States of America (USA)";
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressLabel.text = address;
        // Do any additional setup after loading the view.
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
