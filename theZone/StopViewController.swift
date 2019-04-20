//
//  StopViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/20/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class StopViewController: UIViewController {
    
    // connect stop button
    @IBOutlet weak var stopButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // format start button appearance
        stopButton.layer.cornerRadius = 30;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
