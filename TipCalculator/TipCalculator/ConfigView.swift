//
//  ConfigView.swift
//  TipCalculator
//
//  Created by Tyler Timms on 11/13/18.
//  Copyright © 2018 Tyler Timms. All rights reserved.
//

import UIKit

class ConfigView: UIViewController {
    
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var roundingControl: UISegmentedControl!
    
    // reference to tip calculator scene.
    var TipCalc: TipCalculator?
    
    // reference to history scene
    var History: HistoryView?
    
    // reference to tab bar
    var TabBar: UITabBarController?
    
    // refence to app delegate
    var delegate : AppDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabBar = self.tabBarController
        
        // setting references to the other two scenes
        let tabBarControllerArray = self.tabBarController!.viewControllers
        let viewController0 = tabBarControllerArray?[0]
        let viewController2 = tabBarControllerArray?[2]
        TipCalc = viewController0 as? TipCalculator
        History = viewController2 as? HistoryView
        
        delegate = TipCalc?.delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ChangeTheme(_ sender: UISegmentedControl) {
        ThemeSetup(theme: sender.selectedSegmentIndex)
        TipCalc?.theme = sender.selectedSegmentIndex
        delegate?.theme = sender.selectedSegmentIndex
    }
    
    func ThemeSetup(theme:Int){
        
        if(theme == 0){
            // main views background colors
            TipCalc?.view.backgroundColor = UIColor(red: 220/255, green: 237/255, blue: 255/255, alpha: 1.0)
            
            self.view.backgroundColor = UIColor(red: 220/255, green: 237/255, blue: 255/255, alpha: 1.0)
            
            History?.view.backgroundColor = UIColor(red: 220/255, green: 237/255, blue: 255/255, alpha: 1.0)
            
            // tab bar color
            TabBar?.tabBar.barTintColor = UIColor(red: 148/255, green: 176/255, blue: 218/255, alpha: 1.0)
            
            // tab bar selected text color
            TabBar?.tabBar.tintColor = UIColor(red: 52/255, green: 63/255, blue: 62/255, alpha: 1.0)
            
            // calculator button colors
            for button in (TipCalc?.view.subviews)!{
                if(button is UIButton){
                    button.backgroundColor = UIColor(red: 148/255, green: 176/255, blue: 218/255, alpha: 1.0)
                }
            }
            
            // Control colors
            themeControl.tintColor = UIColor(red: 148/255, green: 176/255, blue: 255/255, alpha: 1.0)
            
            roundingControl.tintColor = UIColor(red: 148/255, green: 176/255, blue: 255/255, alpha: 1.0)
            
            TipCalc?.peopleStepper.tintColor = UIColor(red: 148/255, green: 176/255, blue: 255/255, alpha: 1.0)
            
            TipCalc?.tipSlider.tintColor = UIColor(red: 148/255, green: 176/255, blue: 255/255, alpha: 1.0)
        }
        
        if(theme == 1){
            // main views background colors
            TipCalc?.view.backgroundColor = UIColor(red: 253/255, green: 236/255, blue: 239/255, alpha: 1.0)
            
            self.view.backgroundColor = UIColor(red: 253/255, green: 236/255, blue: 239/255, alpha: 1.0)
            
            History?.view.backgroundColor = UIColor(red: 253/255, green: 236/255, blue: 239/255, alpha: 1.0)
            
            // tab bar color
            TabBar?.tabBar.barTintColor = UIColor(red: 52/255, green: 63/255, blue: 62/255, alpha: 0.7)
            
            // tab bar selected text color
            TabBar?.tabBar.tintColor = UIColor(red: 15/255, green: 17/255, blue: 12/255, alpha: 1.0)
            
            // calculator button colors
            for button in (TipCalc?.view.subviews)!{
                if(button is UIButton){
                    button.backgroundColor = UIColor(red: 157/255, green: 99/255, blue: 129/255, alpha: 1.0)
                }
            }
            
            // Control colors
            themeControl.tintColor = UIColor(red: 157/255, green: 99/255, blue: 129/255, alpha: 1.0)
            
            roundingControl.tintColor = UIColor(red: 157/255, green: 99/255, blue: 129/255, alpha: 1.0)
            
            TipCalc?.peopleStepper.tintColor = UIColor(red: 157/255, green: 99/255, blue: 129/255, alpha: 1.0)
            
            TipCalc?.tipSlider.tintColor = UIColor(red: 157/255, green: 99/255, blue: 129/255, alpha: 1.0)
        }
        
        if(theme == 2){
            // main views background colors
            TipCalc?.view.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 240/255, alpha: 1.0)
            
            self.view.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 240/255, alpha: 1.0)
            
            History?.view.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 240/255, alpha: 1.0)
            
            // tab bar color
            TabBar?.tabBar.barTintColor = UIColor(red: 52/255, green: 63/255, blue: 62/255, alpha: 1.0)
            
            // tab bar selected text color
            TabBar?.tabBar.tintColor = UIColor(red: 233/255, green: 138/255, blue: 21/255, alpha: 1.0)
            
            // calculator button colors
            for button in (TipCalc?.view.subviews)!{
                if(button is UIButton){
                    button.backgroundColor = UIColor(red: 0/255, green: 59/255, blue: 54/255, alpha: 0.4)
                }
            }
            
            // Control colors
            themeControl.tintColor = UIColor(red: 233/255, green: 138/255, blue: 21/255, alpha: 1.0)
            
            roundingControl.tintColor = UIColor(red: 233/255, green: 138/255, blue: 21/255, alpha: 1.0)
            
            TipCalc?.peopleStepper.tintColor = UIColor(red: 233/255, green: 138/255, blue: 21/255, alpha: 1.0)
            
            TipCalc?.tipSlider.tintColor = UIColor(red: 233/255, green: 138/255, blue: 21/255, alpha: 1.0)
        }
        
        if(theme == 3){
            // main views background colors
            TipCalc?.view.backgroundColor = UIColor(red: 255/255, green: 185/255, blue: 151/255, alpha: 1.0)
            
            self.view.backgroundColor = UIColor(red: 255/255, green: 185/255, blue: 151/255, alpha: 1.0)
            
            History?.view.backgroundColor = UIColor(red: 255/255, green: 185/255, blue: 151/255, alpha: 1.0)
            
            // tab bar color
            TabBar?.tabBar.barTintColor = UIColor(red: 124/255, green: 59/255, blue: 54/255, alpha: 1.0)
            
            // tab bar selected text color
            TabBar?.tabBar.tintColor = UIColor(red: 11/255, green: 3/255, blue: 45/255, alpha: 1.0)
            
            // calculator button colors
            for button in (TipCalc?.view.subviews)!{
                if(button is UIButton){
                    button.backgroundColor = UIColor(red: 246/255, green: 126/255, blue: 125/255, alpha: 1.0)
                }
            }
            
            // Control colors
            themeControl.tintColor = UIColor(red: 11/255, green: 3/255, blue: 45/255, alpha: 1.0)
            
            roundingControl.tintColor = UIColor(red: 11/255, green: 3/255, blue: 45/255, alpha: 1.0)
            
            TipCalc?.peopleStepper.tintColor = UIColor(red: 11/255, green: 3/255, blue: 45/255, alpha: 1.0)
            
            TipCalc?.tipSlider.tintColor = UIColor(red: 11/255, green: 3/255, blue: 45/255, alpha: 1.0)
        }
    }
    
    // Rounding option controls
    @IBAction func SetRoundingOption(_ sender: UISegmentedControl) {
        TipCalc?.decRounding = sender.selectedSegmentIndex
        delegate?.rounding = sender.selectedSegmentIndex
        TipCalc?.CalculateTipAndTotal()
        TipCalc?.UpdateBillingInfo()
    }
    
}
