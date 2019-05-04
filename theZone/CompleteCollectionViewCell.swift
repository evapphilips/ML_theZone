//
//  PostWorkCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/21/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class CompleteCollectionViewCell: UICollectionViewCell {
    
    // connect post question label
    @IBOutlet weak var postQuestionLabel: UILabel!
    
    // connect yes button
    @IBOutlet weak var yesButton: UIButton!
    
    // connect no button
    @IBOutlet weak var noButton: UIButton!
    
    // connect mostly button
    @IBOutlet weak var mostlyButton: UIButton!
    
    override func awakeFromNib() {
        // format cell appearance
        self.layer.cornerRadius = 10
        backgroundColor = .white
        yesButton.layer.cornerRadius = 15
        yesButton.layer.borderColor = UIColor.gray.cgColor;
        yesButton.layer.borderWidth = 1;
        noButton.layer.cornerRadius = 15
        noButton.layer.borderColor = UIColor.gray.cgColor;
        noButton.layer.borderWidth = 1;
        mostlyButton.layer.cornerRadius = 15
        mostlyButton.layer.borderColor = UIColor.gray.cgColor;
        mostlyButton.layer.borderWidth = 1;
    }
    
    
    // reset buttons
    @IBAction func yesPressed(_ sender: Any) {
        noButton.backgroundColor = .white
        mostlyButton.backgroundColor = .white
    }
    @IBAction func noPressed(_ sender: Any) {
        yesButton.backgroundColor = .white
        mostlyButton.backgroundColor = .white
    }
    @IBAction func mostlyPressed(_ sender: Any) {
        yesButton.backgroundColor = .white
        noButton.backgroundColor = .white
    }
    
    
    
    
    
    
}
