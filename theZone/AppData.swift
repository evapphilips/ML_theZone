//
//  AppData.swift
//  theZone
//
//  Created by Eva Philips on 4/27/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//

import Foundation

class AppData{
    // share app data with other view controllers
    static let shared = AppData()
    
    private init() {}
    
    // set api key for weather data
    var apiKey:String = "ADD_YOUR_API_KEY_HERE" // ADD_YOUR_API_KEY_HERE
    
    // set app variables
    var project:String = ""
    var task:String = ""
    var place:String = ""
    var goal:String = ""
    
    var location:[Double] = []
    var weather:[String] = []
    var sound:String = ""
    
    var timeStart:NSDate!
    var goalCompletion:String = ""
    var excitement:String = ""
    var tags:[String] = []
    var timeEnd:NSDate!
    
//    struct workData{
//        var project:String = ""
//        var task:String = ""
//        var place:String = ""
//        var goal:String = ""
//        var timeStart:NSDate!
//        var goalCompletion:String = ""
//        var excitement:String = ""
//        var tags:[String] = []
//        var timeEnd:NSDate!
//
//    }
    
}
