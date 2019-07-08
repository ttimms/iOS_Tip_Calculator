//
//  BillingInfo.swift
//  TipCalculator
//
//  Created by Tyler Timms on 11/13/18.
//  Copyright © 2018 Tyler Timms. All rights reserved.
//
//  Used to save billing information

import Foundation

class BillingInfo : NSObject{
    var billAmount : Double = 0
    var tipPercent : Double = 0.15
    var numPeople : Int = 1
    var tipAmount : Double = 0
    var totalAmount : Double = 0
}
