//
//  GoalCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/27/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    
    // connect question label
    @IBOutlet weak var preQuestionLabel: UILabel!
    
    
    // connect goal textfield
    @IBOutlet weak var goalTextField: UITextField!
    
    override func awakeFromNib() {
        // format cell appearance
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
    
}
