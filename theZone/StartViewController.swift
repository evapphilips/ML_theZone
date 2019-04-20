//
//  ViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/20/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // connect start button
    @IBOutlet weak var startButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // format start button appearance
        startButton.layer.cornerRadius = 30;
    }


}

