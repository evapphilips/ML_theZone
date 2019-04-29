//
//  PostWorkCollectionViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/21/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class PostWorkCollectionViewController: UICollectionViewController {
    
    // connect app data to this view controller
    let myAppData = AppData.shared
    
    // reference flow layout for collection view pages
    let flowLayout = ZoomAndSnapUICollectionViewFlowLayout()
    
    // connect cancel button
    var cancelButton: UIButton!
    
    // setup cancel alert
    var cancelAlert: UIAlertController!
    
    // setup saved alert
    var savedAlert: UIAlertController!
    var failedAlert: UIAlertController!

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
        // time/date end data
        myAppData.timeEnd = NSDate()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
    }
    
    // when cancel button is pressed go back to start view controller
    @objc func cancelButtonClicked(_ sender: UIButton){
        // show cancel alert
        displayCancelAlert()
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
            self.myAppData.weather = []
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
        // show cancel alert
        self.present(cancelAlert, animated: true)
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
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostWorkCollectionViewCell
        
        // set pre work questions
        let postQuestions = ["Did you complete your goal for this work session?", "Are you excited about the work you completed?", "Add some tags to this work session..."]
        
        if indexPath.row == 0{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompleteCell", for: indexPath) as! CompleteCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.postQuestionLabel.text = postQuestions[indexPath.row]
            cell.yesButton.layer.cornerRadius = 15
            cell.noButton.layer.cornerRadius = 15
            cell.mostlyButton.layer.cornerRadius = 15
            // add button actions
            cell.yesButton.addTarget(self, action: #selector(completeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.noButton.addTarget(self, action: #selector(completeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.mostlyButton.addTarget(self, action: #selector(completeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            return cell
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExciteCell", for: indexPath) as! ExciteCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.postQuestionLabel.text = postQuestions[indexPath.row]
            cell.yesButton.layer.cornerRadius = 15
            cell.noButton.layer.cornerRadius = 15
            cell.mostlyButton.layer.cornerRadius = 15
            // add button actions
            cell.yesButton.addTarget(self, action: #selector(excitementIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.noButton.addTarget(self, action: #selector(excitementIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.mostlyButton.addTarget(self, action: #selector(excitementIsPressed(_:)), for: UIControl.Event.touchUpInside)
            return cell
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.postQuestionLabel.text = postQuestions[indexPath.row]
            cell.tiredButton.layer.cornerRadius = 15
            cell.distractedButton.layer.cornerRadius = 15
            cell.noCoffeeButton.layer.cornerRadius = 15
            cell.hungryButton.layer.cornerRadius = 15
            cell.sickButton.layer.cornerRadius = 15
            cell.screenButton.layer.cornerRadius = 15
            cell.otherButton.layer.cornerRadius = 15
            // add button actions
            cell.tiredButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.distractedButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.noCoffeeButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.hungryButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.sickButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.screenButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.otherButton.addTarget(self, action: #selector(tagIsPressed(_:)), for: UIControl.Event.touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostSubmitCell", for: indexPath) as! PostSubmitCollectionViewCell
            cell.postSubmitButton.layer.cornerRadius = 25;
            cell.postSubmitButton.addTarget(self, action: #selector(postSubmitClicked(_:)), for: .touchUpInside)
           return cell
        }
        
    }
    
    // when post submit button is pressed
    @objc func postSubmitClicked(_ sender: UIButton){
        // when submit is pressed, send the work session data to the api
        postData(project: myAppData.project, task: myAppData.task, place: myAppData.place, goal: myAppData.goal, location: myAppData.location, weather: myAppData.weather, sound: myAppData.sound, timeStart: myAppData.timeStart, goalCompletion: myAppData.goalCompletion, excitement: myAppData.excitement, tags: myAppData.tags, timeEnd: myAppData.timeEnd)

        
        
    }
    
    // when complete is pressed, update the data app complete
    @objc func completeIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.goalCompletion = button.titleLabel?.text ?? ""
    }
    
    // when excitement is pressed, update the data app excitement
    @objc func excitementIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.excitement = button.titleLabel?.text ?? ""
    }
    
    // when tag is pressed, update the data app tags
    @objc func tagIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.tags.append(button.titleLabel?.text ?? "")
    }
    
    // make a POST request to the api when post submit is pressed
    func postData(project: String, task: String, place: String, goal: String, location: [Double], weather: [String], sound: String, timeStart: NSDate, goalCompletion: String, excitement: String, tags: [String], timeEnd: NSDate){
        // set username and password from defaults
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""
        // set up api request credentials
        let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        // Make POST request
        Alamofire.request("https://the-zone-api.herokuapp.com/api",
                          method: .post,
                          parameters: ["project":project, "task":task, "place":place, "goal":goal, "location":location, "weather":weather, "sound": sound, "timeStart":timeStart, "goalCompletion":goalCompletion, "excitement":excitement, "tags":tags, "timeEnd":timeEnd],
                          encoding: URLEncoding.default,
                          headers:headers)
            .validate()
            .responseJSON { response in
                if response.result.value != nil{
                    //print(response) // print the json data
                    // show saved alert
                    self.displaySavedAlert()
                    
                }else {
                    //print("post failed")
                    self.displayFailedAlert()
                }
        }
    }
    
    // make save alert
    func displaySavedAlert(){
        // create save alert
        savedAlert = UIAlertController(title: nil, message: "your work session has been saved", preferredStyle: .alert)
        // create ok action
        let okayAction = UIAlertAction(title: "OK", style: .default){ (_) in
            // clear all the data variables
            self.myAppData.project = ""
            self.myAppData.task = ""
            self.myAppData.place = ""
            self.myAppData.goal = ""
            self.myAppData.location = []
            self.myAppData.weather = []
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
        // show action
        savedAlert.addAction(okayAction)
        // show save alert
        self.present(savedAlert, animated: true)
    }
    
    // make failed alert
    func displayFailedAlert(){
        // create fail alert
        failedAlert = UIAlertController(title: nil, message: "something went wrong, your work session was not saved", preferredStyle: .alert)
        // create ok action
        let okayAction = UIAlertAction(title: "OK", style: .cancel)
        // show action
        failedAlert.addAction(okayAction)
        // show failed alert
        self.present(failedAlert, animated: true)
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
