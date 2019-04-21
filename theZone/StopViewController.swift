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
    
    // connect cancel button
    @IBOutlet weak var cancelButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // format start button appearance
        stopButton.layer.cornerRadius = 30;
    }
    
    // when stop button is pressed, switch to PostWork View
    @IBAction func stopButtonClicked(_ sender: Any) {
        //reference storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // reference the next view controller (ie. pre work collection view controller)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostWorkCollectionViewController") as! PostWorkCollectionViewController
        self.present(vc, animated: false, completion: nil)
    }
    
    // when cancel button is pressed go back to start view controller
    @IBAction func cancelButtonClicked(_ sender: Any) {
        //reference storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // reference the next view controller (ie. stop view controller)
        let vc = storyboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        self.present(vc, animated: false, completion: nil)
        
        
        
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
