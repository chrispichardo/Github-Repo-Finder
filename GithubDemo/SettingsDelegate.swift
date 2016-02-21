//
//  SettingsDelegate.swift
//  GithubDemo
//
//  Created by christian pichardo on 2/18/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation

protocol SettingsDelegate: class {
    
    func settings( settings: SettingsViewController, didChangeMinimumStars minimunStars: Int?)
    
    
}