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
    
    // when start button is pressed, switch to PreWork View
    @IBAction func startButtonClicked(_ sender: Any) {
        // reference storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // reference the next view controller (ie. pre work collection view controller)
        let vc = storyboard.instantiateViewController(withIdentifier: "PreWorkCollectionViewController") as! PreWorkCollectionViewController
        self.present(vc, animated: false, completion: nil)
    }
   

    


}

