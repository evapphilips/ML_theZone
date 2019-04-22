//
//  PostWorkCollectionViewController.swift
//  theZone
//
//  Created by Eva Philips on 4/21/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PostWorkCollectionViewController: UICollectionViewController {
    
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


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
    }
    
    // when cancel button is pressed go back to start view controller
    @objc func cancelButtonClicked(_ sender: UIButton){
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
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostWorkCollectionViewCell
        
        // set pre work questions
        let postQuestions = ["Did you complete your goal for this work session?", "Are you excited/content with the work you completed this work session?", "Add some tags to this work session..."]
    
        // Configure the cell
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.white.cgColor
        if(indexPath.row<3){ // for the first 4 rows
            // show border
            cell.layer.borderWidth = 1
            // hide submit button
            cell.postSubmitButton.isHidden = true;
            // set question label
            cell.questionLabel.text = postQuestions[indexPath.row]
            
        }else{
            // hide border
            cell.layer.borderWidth = 0
            // show sumbit button
            cell.postSubmitButton.layer.cornerRadius = 25;
            cell.postSubmitButton.isHidden = false
            // hide question
            cell.questionLabel.isHidden = true
        }
        
        // call the change view method when submit is pressed
        cell.postSubmitButton.addTarget(self, action: #selector(postSubmitClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // when post submit button is pressed
    @objc func postSubmitClicked(_ sender: UIButton){
        //reference storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // reference the next view controller (ie. stop view controller)
        let vc = storyboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        self.present(vc, animated: false, completion: nil)
        
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
