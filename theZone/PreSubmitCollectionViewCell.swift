//
//  PreSubmitCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/23/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class PreSubmitCollectionViewCell: UICollectionViewCell {
    
    // connect submit button
    @IBOutlet weak var preSubmitButton: UIButton!
    
    override func awakeFromNib() {
        // format cell appearance
        preSubmitButton.layer.cornerRadius = 25
        preSubmitButton.layer.shadowColor = UIColor.darkGray.cgColor
        preSubmitButton.layer.shadowRadius = 4
        preSubmitButton.layer.shadowOpacity = 0.5
        
    }
    
}
