//
//  TagCollectionViewCell.swift
//  theZone
//
//  Created by Eva Philips on 4/27/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    // connect app data to this cell
    let myAppData = AppData.shared
    
    // connect question
    @IBOutlet weak var postQuestionLabel: UILabel!
    
    // connect tired
    @IBOutlet weak var tiredButton: UIButton!
    
    // connect distracted
    @IBOutlet weak var distractedButton: UIButton!
    
    // connect no coffee
    @IBOutlet weak var noCoffeeButton: UIButton!
    
    // connect hungry
    @IBOutlet weak var hungryButton: UIButton!
    
    // connect sick
    @IBOutlet weak var sickButton: UIButton!
    
    // connect screen based
    @IBOutlet weak var screenButton: UIButton!
    
    // connect other
    @IBOutlet weak var otherButton: UIButton!
    
    override func awakeFromNib() {
        // formal cell appearance
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        tiredButton.layer.cornerRadius = 15
        tiredButton.layer.borderColor = UIColor.gray.cgColor;
        tiredButton.layer.borderWidth = 1;
        distractedButton.layer.cornerRadius = 15
        distractedButton.layer.borderColor = UIColor.gray.cgColor;
        distractedButton.layer.borderWidth = 1;
        noCoffeeButton.layer.cornerRadius = 15
        noCoffeeButton.layer.borderColor = UIColor.gray.cgColor;
        noCoffeeButton.layer.borderWidth = 1;
        hungryButton.layer.cornerRadius = 15
        hungryButton.layer.borderColor = UIColor.gray.cgColor;
        hungryButton.layer.borderWidth = 1;
        sickButton.layer.cornerRadius = 15
        sickButton.layer.borderColor = UIColor.gray.cgColor;
        sickButton.layer.borderWidth = 1;
        screenButton.layer.cornerRadius = 15
        screenButton.layer.borderColor = UIColor.gray.cgColor;
        screenButton.layer.borderWidth = 1;
        otherButton.layer.cornerRadius = 15
        otherButton.layer.borderColor = UIColor.gray.cgColor;
        otherButton.layer.borderWidth = 1;
    }
    
    // if other is pressed
    @IBAction func otherPressed(_ sender: Any) {
        for tag in myAppData.tags {
            if(tag != "tired" || tag != "distracted" || tag != "no coffee" || tag != "hungry" || tag != "sick" || tag != "screen based" ){
                otherButton.backgroundColor = .gray
            }else{
                otherButton.backgroundColor = .white
            }
        }
    }
    
    
    
    
}
