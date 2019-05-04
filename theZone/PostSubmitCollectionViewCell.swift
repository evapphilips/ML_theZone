//
//  PostSubmitCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/27/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class PostSubmitCollectionViewCell: UICollectionViewCell {
    
    // connect submit button
    @IBOutlet weak var postSubmitButton: UIButton!
    
    override func awakeFromNib() {
        // format cell appearance
        postSubmitButton.layer.cornerRadius = 25;
        postSubmitButton.layer.shadowColor = UIColor.darkGray.cgColor
        postSubmitButton.layer.shadowRadius = 4
        postSubmitButton.layer.shadowOpacity = 0.5
    }
    
    
}
