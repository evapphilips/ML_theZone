//
//  PreWorkCollectionViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/21/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PreWorkCollectionViewController: UICollectionViewController {
    
    // connect app data to this view controller
    let myAppData = AppData.shared
    
    // reference flow layout for collection view pages
    let flowLayout = ZoomAndSnapUICollectionViewFlowLayout()
    
    // connect cancel button
    var cancelButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up collection view
        guard let collectionView = collectionView else { fatalError() }
        collectionView.collectionViewLayout = flowLayout
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // show cancel button
        cancelButton = UIButton(frame: CGRect(x: 20, y: 44, width: 59, height: 36))
        cancelButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(red:0.32, green:0.28, blue:0.28, alpha:1.0), for: .normal)
        // add target when cancel button is pressed
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked(_:)), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        // collect background data
        // time/date start data
        myAppData.timeStart = NSDate()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        

        // Do any additional setup after loading the view.
    }
    
    // when cancel button is pressed go back to start view controller
    @objc func cancelButtonClicked(_ sender: UIButton){
        
        // clear the app Data
        myAppData.project = ""
        myAppData.task = ""
        myAppData.place = ""
        myAppData.goal = ""
        myAppData.timeStart = nil
        //print("project: ", myAppData.project, "task: ", myAppData.task, "place: ", myAppData.place, "goal: ", myAppData.goal )
        
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // initilize cell instance
        //let cell: UICollectionViewCell!
        
        // set pre work questions
        let preQuestions = ["What project are you working on?", "What task are you working on?", "Where are you working?", "What is your goal for this work session?"]
        
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // add action to project text field
            cell.projectTextField.addTarget(self, action: #selector(projectTextFieldDidChange(_:)), for: .editingChanged)
            return cell
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as! TaskCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // add action to task text field
            cell.taskTextField.addTarget(self, action: #selector(taskTextFieldDidChange(_:)), for: .editingChanged)
            return cell
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // set button radius
            cell.workButton.layer.cornerRadius = 15;
            cell.coffeeButton.layer.cornerRadius = 15;
            cell.homeButton.layer.cornerRadius = 15;
            cell.otherButton.layer.cornerRadius = 15;
            // add button actions
            cell.workButton.addTarget(self, action: #selector(workIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.coffeeButton.addTarget(self, action: #selector(coffeeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.homeButton.addTarget(self, action: #selector(homeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.otherButton.addTarget(self, action: #selector(otherIsPressed(_:)), for: UIControl.Event.touchUpInside)
            
            return cell
        }
        else if indexPath.row == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalCell", for: indexPath) as! GoalCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // add goal to project text field
            cell.goalTextField.addTarget(self, action: #selector(goalTextFieldDidChange(_:)), for: .editingChanged)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreSubmitCell", for: indexPath) as! PreSubmitCollectionViewCell
            // format submit button
            cell.preSubmitButton.layer.cornerRadius = 25
            // call the change view method when submit is pressed
            cell.preSubmitButton.addTarget(self, action: #selector(preSubmitClicked(_:)), for: .touchUpInside)
            return cell
        }
        

//        // Configure the cell's background and questions
//        cell.layer.cornerRadius = 10
//        cell.layer.borderColor = UIColor.white.cgColor
//        if(indexPath.row<4){ // for the first 4 rows
//            // show border
//            cell.layer.borderWidth = 1
//            // hide submit button
//            cell.preSubmitButton.isHidden = true
//            //set question label
//            cell.questionLabel.text = preQuestions[indexPath.row]
//        }else{
//            // hide border
//            cell.layer.borderWidth = 0
//            // show sumbit button
//            cell.preSubmitButton.layer.cornerRadius = 25;
//            cell.preSubmitButton.isHidden = false
//            // hide question
//            cell.questionLabel.isHidden = true
//        }
        
        //return cell
    }
    
    // when pre submit button is pressed
    @objc func preSubmitClicked(_ sender: UIButton){
        //reference storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // reference the next view controller (ie. stop view controller)
        let vc = storyboard.instantiateViewController(withIdentifier: "StopViewController") as! StopViewController
        self.present(vc, animated: false, completion: nil)
        
        // print the data
        print("project: ", myAppData.project)
        print("task: ", myAppData.task)
        print("place: ", myAppData.place)
        print("goal: ", myAppData.goal)
        print("timeStart: ", myAppData.timeStart ?? "")
    }
    
    // when project text field is changed, update the data app project
    @objc func projectTextFieldDidChange(_ textField: UITextField) {
        myAppData.project = textField.text ?? ""
    }
    
    // when task text field is changed, update the data app task
    @objc func taskTextFieldDidChange(_ textField: UITextField) {
        myAppData.task = textField.text ?? ""
    }
    
    // when work is pressed, update the data app place
    @objc func workIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.place = "work"
    }
    // when coffee is pressed, update the data app place
    @objc func coffeeIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.place = "coffee shop"
    }
    // when home is pressed, update the data app place
    @objc func homeIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.place = "home"
    }
    // when other is pressed, update the data app place
    @objc func otherIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.place = "other"
    }
    
    // when goal text field is changed, update the data app goal
    @objc func goalTextFieldDidChange(_ textField: UITextField) {
        myAppData.goal = textField.text ?? ""
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


