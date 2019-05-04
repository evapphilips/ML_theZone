//
//  PreWorkCollectionViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/21/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class PreWorkCollectionViewController: UICollectionViewController, AVAudioRecorderDelegate, UITextFieldDelegate {
    
    // connect app data to this view controller
    let myAppData = AppData.shared
    
    // reference flow layout for collection view pages
    let flowLayout = ZoomAndSnapUICollectionViewFlowLayout()
    
    // connect cancel button
    var cancelButton: UIButton!
    
    // setup cancel alert
    var cancelAlert: UIAlertController!
    
    // setup location
    let locationManager = CLLocationManager()
    
    // setup sound level
    var timer: Timer?
    var recorder: AVAudioRecorder!
    
    // setup saved alert
    var savedAlert: UIAlertController!
    
    // setup next button
    var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHideKeyboardOnTap()
        
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
        
        ////
        //self.collectionView.isPagingEnabled = true
        
        ////
        
        
        // collect background data
        // time/date start data
        myAppData.timeStart = NSDate()
        // location coordinates
        locationManager.requestAlwaysAuthorization()
        var currentLocation: CLLocation!
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locationManager.location
            myAppData.location = [currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]
        }else{
            print("Location not authorized")
            myAppData.location = []
        }
        // sound level
        self.requestSoundAuthorization()
        if self.recorder != nil {
            return
        }
        let soundUrl: NSURL = NSURL(fileURLWithPath: "/dev/null")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            self.recorder = try AVAudioRecorder(url: soundUrl as URL, settings: settings )
            self.recorder.delegate = self
            self.recorder.isMeteringEnabled = true

            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.record)))
            
            self.recorder.record()
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getSoundLevel(_:)), userInfo: nil, repeats: true)
        } catch {
            print("Fail to record.")
            myAppData.sound = ""
        }
        
        // weather data
        if(myAppData.location != []){
            print(myAppData.location)
            let baseWeatherUrl = "https://api.darksky.net/forecast/"
            let weatherAPIKey = myAppData.apiKey
            //let lat = myAppData.location[0]
            //let long = myAppData.location[1]
            
            let loc = String("\(myAppData.location[0])" + "," + "\(myAppData.location[0])")
            let weatherUrl = baseWeatherUrl + weatherAPIKey + "/" + loc
            //print(weatherUrl)
            
            Alamofire.request(weatherUrl, method: .get).responseJSON{
                response in
                if response.result.isSuccess{
                    //print("Everything is fine")
                    let weatherJSON: JSON = JSON(response.result.value!)
                    let weatherTemp = String("\(weatherJSON["currently"]["temperature"])")
                    let weatherSummary = String("\(weatherJSON["currently"]["summary"])")
                    let weatherPercipType = String("\(weatherJSON["currently"]["percipType"])")
                    self.myAppData.weather.append(weatherTemp)
                    self.myAppData.weather.append(weatherSummary)
                    self.myAppData.weather.append(weatherPercipType)
                    
                    //self.myAppData.weather = [weatherTemp, weatherSummary, weatherPercipType]
                    print("weather: ", self.myAppData.weather)
                }else{
                print("Error \(String(describing: response.result.error))")
                }
            }
        }else{
            myAppData.weather = []
        }
        
        // setup next button
        nextButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50, y:self.view.frame.height/2 + 200 , width: 100, height: 36))
        nextButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        nextButton.setTitle("next", for: .normal)
        nextButton.setTitleColor(UIColor(red:0.32, green:0.28, blue:0.28, alpha:1.0), for: .normal)
        nextButton.backgroundColor = .white
        nextButton.layer.cornerRadius = 18
        // add target when next button is pressed
        nextButton.addTarget(self, action: #selector(nextButtonClicked(_:)), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
    }
    
    // when cancel button is pressed go back to start view controller
    @objc func cancelButtonClicked(_ sender: UIButton){
        // show cancel alert
        displayCancelAlert()
    }
    
    // when next button is pressed go to next cell
    @objc func nextButtonClicked(_ sender: UIButton){
        print("next")
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
        // show login alert
        self.present(cancelAlert, animated: true)
    }
    
    func requestSoundAuthorization(){
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            print("Permission granted")
        case AVAudioSessionRecordPermission.denied:
            print("Pemission denied")
        case AVAudioSessionRecordPermission.undetermined:
            print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                // Handle granted
                print("granted")
            })
        }
    }
    
    // get the sound level and save it to the app data
    @objc internal func getSoundLevel(_: Timer) {
        recorder.updateMeters()
        
        // set level to app data
        myAppData.sound = String(recorder.averagePower(forChannel: 0))
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
//            cell.layer.borderColor = UIColor.white.cgColor
//            cell.layer.borderWidth = 1
//            cell.layer.shadowColor = UIColor.darkGray.cgColor
//            cell.layer.shadowRadius = 4
//            cell.layer.shadowOpacity = 0.5
//            cell.layer.masksToBounds = false
//            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.layer.cornerRadius).cgPath
            cell.backgroundColor = .white
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // add action to project text field
            cell.projectTextField.addTarget(self, action: #selector(projectTextFieldDidChange(_:)), for: .editingChanged)
            // add delegate for text field return button
            cell.projectTextField.delegate = self
            return cell
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as! TaskCollectionViewCell
            cell.layer.cornerRadius = 10
            //            cell.layer.borderColor = UIColor.white.cgColor
            //            cell.layer.borderWidth = 1
//            cell.layer.shadowColor = UIColor.darkGray.cgColor
//            cell.layer.shadowRadius = 4
//            cell.layer.shadowOpacity = 0.5
//            cell.layer.masksToBounds = false
//            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.layer.cornerRadius).cgPath
            cell.backgroundColor = .white
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // add action to task text field
            cell.taskTextField.addTarget(self, action: #selector(taskTextFieldDidChange(_:)), for: .editingChanged)
            // add delegate for text field return button
            cell.taskTextField.delegate = self
            return cell
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCollectionViewCell
            cell.layer.cornerRadius = 10
            //            cell.layer.borderColor = UIColor.white.cgColor
            //            cell.layer.borderWidth = 1
//            cell.layer.shadowColor = UIColor.darkGray.cgColor
//            cell.layer.shadowRadius = 4
//            cell.layer.shadowOpacity = 0.5
//            cell.layer.masksToBounds = false
//            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.layer.cornerRadius).cgPath
            cell.backgroundColor = .white
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // set button radius
            cell.workButton.layer.cornerRadius = 15;
            cell.workButton.layer.borderColor = UIColor.gray.cgColor;
            cell.workButton.layer.borderWidth = 1;
            cell.coffeeButton.layer.cornerRadius = 15;
            cell.coffeeButton.layer.borderColor = UIColor.gray.cgColor;
            cell.coffeeButton.layer.borderWidth = 1;
            cell.homeButton.layer.cornerRadius = 15;
            cell.homeButton.layer.borderColor = UIColor.gray.cgColor;
            cell.homeButton.layer.borderWidth = 1;
            cell.otherButton.layer.cornerRadius = 15;
            cell.otherButton.layer.borderColor = UIColor.gray.cgColor;
            cell.otherButton.layer.borderWidth = 1;
            // add button actions
            cell.workButton.addTarget(self, action: #selector(placeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.coffeeButton.addTarget(self, action: #selector(placeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.homeButton.addTarget(self, action: #selector(placeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            cell.otherButton.addTarget(self, action: #selector(placeIsPressed(_:)), for: UIControl.Event.touchUpInside)
            return cell
        }
        else if indexPath.row == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalCell", for: indexPath) as! GoalCollectionViewCell
            cell.layer.cornerRadius = 10
            //            cell.layer.borderColor = UIColor.white.cgColor
            //            cell.layer.borderWidth = 1
//            cell.layer.shadowColor = UIColor.darkGray.cgColor
//            cell.layer.shadowRadius = 4
//            cell.layer.shadowOpacity = 0.5
//            cell.layer.masksToBounds = false
//            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.layer.cornerRadius).cgPath
            cell.backgroundColor = .white
            cell.preQuestionLabel.text = preQuestions[indexPath.row]
            // add goal to project text field
            cell.goalTextField.addTarget(self, action: #selector(goalTextFieldDidChange(_:)), for: .editingChanged)
            // add delegate for text field return button
            cell.goalTextField.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreSubmitCell", for: indexPath) as! PreSubmitCollectionViewCell
            // format submit button
            cell.preSubmitButton.layer.cornerRadius = 25
            cell.preSubmitButton.layer.shadowColor = UIColor.darkGray.cgColor
            cell.preSubmitButton.layer.shadowRadius = 4
            cell.preSubmitButton.layer.shadowOpacity = 0.5
            // call the change view method when submit is pressed
            cell.preSubmitButton.addTarget(self, action: #selector(preSubmitClicked(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    // when pre submit button is pressed
    @objc func preSubmitClicked(_ sender: UIButton){
        // create save alert
        savedAlert = UIAlertController(title: nil, message: "Your pre work session has been saved! Have a productive work session and come back to reflect when you are done!", preferredStyle: .alert)
        // create ok action
        let okayAction = UIAlertAction(title: "OK", style: .default){ (_) in
            //reference storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // reference the next view controller (ie. stop view controller)
            let vc = storyboard.instantiateViewController(withIdentifier: "StopViewController") as! StopViewController
            self.present(vc, animated: false, completion: nil)
        }
        // show action
        savedAlert.addAction(okayAction)
        // show save alert
        self.present(savedAlert, animated: true)
        
        
    }
    
    // when project text field is changed, update the data app project
    @objc func projectTextFieldDidChange(_ textField: UITextField) {
        myAppData.project = textField.text ?? ""
    }
    
    // when task text field is changed, update the data app task
    @objc func taskTextFieldDidChange(_ textField: UITextField) {
        myAppData.task = textField.text ?? ""
    }
    
    // when place is pressed, update the data app place
    @objc func placeIsPressed(_ button: UIButton) {
        button.backgroundColor = .gray
        myAppData.place = button.titleLabel?.text ?? ""
    }
    
    // when goal text field is changed, update the data app goal
    @objc func goalTextFieldDidChange(_ textField: UITextField) {
        myAppData.goal = textField.text ?? ""
    }
    
    // when return is pressed, dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}



extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
