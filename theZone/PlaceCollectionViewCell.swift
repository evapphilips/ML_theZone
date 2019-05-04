//
//  PreButtonCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/23/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    // connect question label
    @IBOutlet weak var preQuestionLabel: UILabel!
    
    
    // connect home button
    @IBOutlet weak var homeButton: UIButton!
    // connect other button
    @IBOutlet weak var otherButton: UIButton!
    // connect coffee shop button
    @IBOutlet weak var coffeeButton: UIButton!
    // connect work button
    @IBOutlet weak var workButton: UIButton!
    
    override func awakeFromNib() {
        // format cell
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        workButton.layer.cornerRadius = 15;
        workButton.layer.borderColor = UIColor.gray.cgColor;
        workButton.layer.borderWidth = 1;
        coffeeButton.layer.cornerRadius = 15;
        coffeeButton.layer.borderColor = UIColor.gray.cgColor;
        coffeeButton.layer.borderWidth = 1;
        homeButton.layer.cornerRadius = 15;
        homeButton.layer.borderColor = UIColor.gray.cgColor;
        homeButton.layer.borderWidth = 1;
        otherButton.layer.cornerRadius = 15;
        otherButton.layer.borderColor = UIColor.gray.cgColor;
        otherButton.layer.borderWidth = 1;
    }
    
    // reset buttons
    @IBAction func workPressed(_ sender: Any) {
        coffeeButton.backgroundColor = .white
        homeButton.backgroundColor = .white
        otherButton.backgroundColor = .white
    }
    @IBAction func coffeePressed(_ sender: Any) {
        workButton.backgroundColor = .white
        homeButton.backgroundColor = .white
        otherButton.backgroundColor = .white
    }
    @IBAction func homePressed(_ sender: Any) {
        workButton.backgroundColor = .white
        coffeeButton.backgroundColor = .white
        otherButton.backgroundColor = .white
    }
    @IBAction func otherPressed(_ sender: Any) {
        workButton.backgroundColor = .white
        coffeeButton.backgroundColor = .white
        homeButton.backgroundColor = .white
    }
    
    
    
    
}
