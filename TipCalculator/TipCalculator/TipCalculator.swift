//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Tyler Timms on 11/13/18.
//  Copyright © 2018 Tyler Timms. All rights reserved.
//

import UIKit

class TipCalculator: UIViewController {
    @IBOutlet weak var billInput: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercent: UILabel!
    @IBOutlet weak var peopleStepper: UIStepper!
    @IBOutlet weak var numPeople: UILabel!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var transactionText: UITextField!
    
    // Decimal place values for the input bill amount
    private var thousandPlace = 0
    private var hundredPlace = 0
    private var tenPlace = 0
    private var onePlace = 0
    private var tenthPlace : Double = 0
    private var hundredthPlace : Double = 0
    
    // billing info object to save state of information
    let Bill = BillingInfo()
    
    // reference to app delegate
    var delegate : AppDelegate?
    
    // Reference to config view to do initial theme setup
    var Config: ConfigView?
    
    // reference to history view to refresh information
    var HistView: HistoryView?
    
    // dict containing file save state info
    var savedState: NSDictionary?
    
    // variable to control rounding
    // 0 == no rounding
    // 1 == rounding tip
    // 2 == rounding total
    var decRounding : Int = 0
    
    var theme : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = UIApplication.shared.delegate as? AppDelegate
        
        // Do the initial theme setup
        let tabBarControllerArray = self.tabBarController!.viewControllers
        let viewController1 = tabBarControllerArray?[1]
        let viewController2 = tabBarControllerArray?[2]
        Config = viewController1 as? ConfigView
        Config?.viewDidLoad()
        
        HistView = viewController2 as? HistoryView
        
        // load previously saved state info
        savedState = loadStateInfo()
        
        // set values from saved state
        theme = savedState?.value(forKey: "theme") as! Int
        Config?.ThemeSetup(theme: theme)
        Config?.themeControl.selectedSegmentIndex = theme
        delegate?.theme = theme
        
        decRounding = savedState?.value(forKey: "rounding") as! Int
        Config?.roundingControl.selectedSegmentIndex = decRounding
        delegate?.rounding = decRounding
        
        let savedTipPercent = (savedState?.value(forKey: "tipPercent") as! Double)
        
        Bill.tipPercent = savedTipPercent / 100
        tipSlider.setValue(Float(savedTipPercent), animated: true)
        tipPercent.text = String(Int(savedTipPercent)) + "%"
        delegate?.tipPercent = Int(savedTipPercent)
    }
    
    @IBAction func InputBillAmount(_ sender: UIButton) {
        // Move input to bill over one digit if thousandPlace not filled
        // Max input of 9999.99
        if(thousandPlace == 0){
            thousandPlace = hundredPlace
            hundredPlace = tenPlace
            tenPlace = onePlace
            onePlace = Int(tenthPlace)
            tenthPlace = hundredthPlace
            hundredthPlace = Double(sender.currentTitle!)!
            
            // Updates thebillAmount in the BillingInfo object
            UpdateBillingInfo()
            
            billInput.text = "$\(Bill.billAmount)"
        }
        
    }
    
    @IBAction func ClearAllInput(_ sender: UIButton) {
        hundredthPlace = 0
        tenthPlace = 0
        onePlace = 0
        tenPlace = 0
        hundredPlace = 0
        thousandPlace = 0
        
        UpdateBillingInfo()
        billInput.text = "$0.00"
        
        transactionText.text = ""
    }
    
    @IBAction func BackSpace(_ sender: UIButton) {
        hundredthPlace = tenthPlace
        tenthPlace = Double(onePlace)
        onePlace = tenPlace
        tenPlace = hundredPlace
        hundredPlace = thousandPlace
        thousandPlace = 0
        
        UpdateBillingInfo()
        
        // print two zeros after decimal if all are zero
        if(AllEqualZero()){
            billInput.text = "$0.00"
        }
        else{ // else print using billAmount
            billInput.text = "$\(Bill.billAmount)"
        }
    }
    
    func UpdateBillingInfo(){
        // update bill amount
        let thousand = Double(thousandPlace*1000)
        let hundred = Double(hundredPlace*100)
        let ten = Double(tenPlace * 10)
        let tenth = (tenthPlace*0.1)
        let hundredth = (hundredthPlace*0.01)
        Bill.billAmount = (thousand + hundred + ten + Double(onePlace) + tenth + hundredth)
        
        // update tip amount
        CalculateTipAndTotal()
    }
    
    func CalculateTipAndTotal(){
        var tip = Bill.billAmount * Bill.tipPercent / Double(Bill.numPeople)
        
        
        if(decRounding == 1){
            // round the tip to nearest dollar amount
            let decimalPart = tip - Double(Int(tip))
            tip = decimalPart > 0.5 ? Double(Int(tip)) + 1 : Double(Int(tip))
        }
        else{
            // Rounding tip to two decimal places
            tip = Double(round(100*tip)/100)
        }
        
        // update the tipAmount in the BillingInfo object
        Bill.tipAmount = tip
        if(AllEqualZero()){
            tipAmount.text = "$0.00"
        }
        else{
            tipAmount.text = "$\(Bill.tipAmount)"
        }
        
        var total = (Bill.billAmount / Double(Bill.numPeople)) + Bill.tipAmount
        
        if(decRounding == 2){
            // round the total to nearest dollar amount
            let decimalPart = total - Double(Int(total))
            total = decimalPart > 0.5 ? Double(Int(total)) + 1 : Double(Int(total))
        }
        
        // update totalAmount in BillingInfo object
        Bill.totalAmount = Double(round(100*total)/100)
        if(AllEqualZero()){
            totalAmount.text = "$0.00"
        }
        else{
            totalAmount.text = "$\(Bill.totalAmount)"
        }
    }
    
    // Returns true if all digits in bill amount are zero
    // else returns false
    func AllEqualZero() -> Bool {
        return thousandPlace == 0 && hundredPlace == 0 && tenPlace == 0 && onePlace == 0 && tenthPlace == 0 && hundredthPlace == 0
    }
    
    @IBAction func SetNewTipPercent(_ sender: UISlider) {
        let IntTip = Int(sender.value)
        let tip = Double(IntTip)*0.01
        Bill.tipPercent = tip
        delegate?.tipPercent = IntTip
        tipPercent.text = "\(IntTip)%"
        UpdateBillingInfo()
    }
    
    @IBAction func SetNumberPeople(_ sender: UIStepper) {
        let number = Int(sender.value)
        Bill.numPeople = number
        numPeople.text = "\(number)"
        UpdateBillingInfo()
    }
    @IBAction func SaveToHistory(_ sender: UIButton) {
        delegate?.name3 = delegate?.name2
        delegate?.bill3 = delegate?.bill2
        delegate?.tip3 = delegate?.tip2
        delegate?.total3 = delegate?.total2
        
        delegate?.name2 = delegate?.name1
        delegate?.bill2 = delegate?.bill1
        delegate?.tip2 = delegate?.tip1
        delegate?.total2 = delegate?.total1
        
        delegate?.name1 = transactionText.text!
        delegate?.bill1 = "$" + String(Bill.billAmount)
        delegate?.tip1 = "$" + String(Bill.tipAmount)
        delegate?.total1 = "$" + String(Bill.totalAmount)
        
        delegate?.SaveHistory()
        HistView?.Refresh()
    }
    
    func loadStateInfo() -> NSDictionary? {
        // Use an NS function, it returns an array
        let pathsForFile = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true)
        
        // Get the last (or first)
        let documentDirectory = pathsForFile.last
        
        // Get Documents directory
        let path = documentDirectory! + "/saveState.txt"
        
        let readDict: NSDictionary? = NSDictionary(contentsOfFile: path)
        
        return readDict
    }
}
