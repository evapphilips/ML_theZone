//
//  PreInputFieldCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/23/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    
    // connect question label
    @IBOutlet weak var preQuestionLabel: UILabel!
    
    
    
    // connect project text field
    @IBOutlet weak var projectTextField: UITextField!
    
    override func awakeFromNib() {
        // format cell
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
    }
    
    
    
    
}
