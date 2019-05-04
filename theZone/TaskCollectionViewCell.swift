//
//  TaskCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/27/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    
    // connection question label
    @IBOutlet weak var preQuestionLabel: UILabel!
    
    // connect task text field
    @IBOutlet weak var taskTextField: UITextField!
    
    override func awakeFromNib() {
        // format cell
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
    
    
}
