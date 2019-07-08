//
//  HistoryView.swift
//  TipCalculator
//
//  Created by Tyler Timms on 11/13/18.
//  Copyright © 2018 Tyler Timms. All rights reserved.
//

import UIKit

class HistoryView: UIViewController {
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var bill1: UILabel!
    @IBOutlet weak var tip1: UILabel!
    @IBOutlet weak var total1: UILabel!
    @IBOutlet weak var bill2: UILabel!
    @IBOutlet weak var tip2: UILabel!
    @IBOutlet weak var total2: UILabel!
    @IBOutlet weak var bill3: UILabel!
    @IBOutlet weak var tip3: UILabel!
    @IBOutlet weak var total3: UILabel!
    
    // dict containing file save state info
    var savedHistory: NSDictionary?
    
    // refence to tab bar
    var TabBar: UITabBarController?
    
    // refence to tipcalc screen to retrieve history object
    var TipCalc: TipCalculator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Refresh()
    }

    func loadHistoryInfo() -> NSDictionary? {
        // Use an NS function, it returns an array
        let pathsForFile = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true)
        
        // Get the last (or first)
        let documentDirectory = pathsForFile.last
        
        // Get Documents directory
        let path = documentDirectory! + "/saveHistory.txt"
        
        let readDict: NSDictionary? = NSDictionary(contentsOfFile: path)
        
        return readDict
    }
    
    func Refresh(){
        savedHistory = loadHistoryInfo()
        
        TabBar = self.tabBarController
        
        // setting references to the other two scenes
        let tabBarControllerArray = self.tabBarController!.viewControllers
        let viewController0 = tabBarControllerArray?[0]
        TipCalc = viewController0 as? TipCalculator
        
        name1.text = savedHistory?.value(forKey: "name1") as? String
        bill1.text = (savedHistory?.value(forKey: "bill1") as? String)!
        tip1.text = (savedHistory?.value(forKey: "tip1") as? String)!
        total1.text = (savedHistory?.value(forKey: "total1") as? String)!
        
        name2.text = savedHistory?.value(forKey: "name2") as? String
        bill2.text = (savedHistory?.value(forKey: "bill2") as? String)!
        tip2.text = (savedHistory?.value(forKey: "tip2") as? String)!
        total2.text = (savedHistory?.value(forKey: "total2") as? String)!
        
        name3.text = savedHistory?.value(forKey: "name3") as? String
        bill3.text = (savedHistory?.value(forKey: "bill3") as? String)!
        tip3.text = (savedHistory?.value(forKey: "tip3") as? String)!
        total3.text = (savedHistory?.value(forKey: "total3") as? String)!
    }
}
