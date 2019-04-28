//
//  StopViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/20/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class StopViewController: UIViewController {
    
    // connect app data to this view controller
    let myAppData = AppData.shared
    
    // connect stop button
    @IBOutlet weak var stopButton: UIButton!
    
    // connect cancel button
    @IBOutlet weak var cancelButton: UIButton!
    
    // setup cancel alert
    var cancelAlert: UIAlertController!
    
    // connect proect label
    @IBOutlet weak var projectLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // format start button appearance
        stopButton.layer.cornerRadius = 30;
        
        // change project label to current project
        if(myAppData.project != ""){
        projectLabel.text = myAppData.project
        }else{
             projectLabel.text = ""
        }
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
        // show cancel alert
        displayCancelAlert()
        
//        //reference storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        // reference the next view controller (ie. stop view controller)
//        let vc = storyboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
//        self.present(vc, animated: false, completion: nil)
    }
    
    // made cancel alert
    func displayCancelAlert(){
        // create cancel alert
        cancelAlert = UIAlertController(title: nil, message: "Are you sure you want to delete this work session?", preferredStyle: .alert)
        // create cancel action
        let yesAction = UIAlertAction(title: "Yes", style: .default){ (_) in
            // clear all the data variables
            self.myAppData.project = ""
            self.myAppData.task = ""
            self.myAppData.place = ""
            self.myAppData.goal = ""
            self.myAppData.location = []
            self.myAppData.sound = ""
            self.myAppData.timeStart = nil
            self.myAppData.goalCompletion = ""
            self.myAppData.excitement = ""
            self.myAppData.tags = []
            self.myAppData.timeEnd = nil
            
            //reference storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // reference the next view controller (ie. stop view controller)
            let vc = storyboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
            self.present(vc, animated: false, completion: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel)
        cancelAlert.addAction(yesAction)
        cancelAlert.addAction(noAction)
        // show login alert
        self.present(cancelAlert, animated: true)
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
