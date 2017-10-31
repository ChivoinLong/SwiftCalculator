//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    var firstValue: Double? = 0.0
    var secondValue: Double? = 0.0
    var operation: String?
    var isCalculated: Bool = false
    
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    @IBAction func numberButtonsClicked(_ sender: customButton) {
//        print(sender.currentTitle!)
        
        let number: String = screenLabel.text!
        
        if number.characters.count >= 10 {
            return
        }
        
        if number == "0" || isCalculated {
            screenLabel.text = ""
        }
        screenLabel.text! += sender.currentTitle!
        
    }
    
    @IBAction func zeroButtonClicked(_ sender: customButton) {
        let number: String = screenLabel.text!
        
        if number == "0" || isCalculated {
            return
        }
        screenLabel.text! += sender.currentTitle!
    }
    
    @IBAction func dotButtonClicked(_ sender: customButton) {
        let isDotted: Bool = screenLabel.text!.index(of: ".") != nil ? true : false
        
        if isDotted {
            return
        }
        screenLabel.text! += "."
    }
    
    @IBAction func clearButtonClicked(_ sender: customButton) {
        screenLabel.text = "0"
        overviewLabel.text = ""
        firstValue = 0
        secondValue = 0
        operation = nil
        isCalculated = false
    }
    
    @IBAction func unaryMinusButtonClicked(_ sender: customButton) {
        let number: Double! =  Double (screenLabel.text!)
        
        if number == 0 {
            return
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        screenLabel.text = formatter.string(from: -number as NSNumber)
    }
    
    @IBAction func operatorButtonsClick(_ sender: customButton) {
        firstValue = Double (screenLabel.text!)
        operation = sender.currentTitle!
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let firstVal: String! = formatter.string(from: firstValue! as NSNumber)
        screenLabel.text = "0"
        overviewLabel.text = "\(firstVal!) \(operation!) "
    }
    
    @IBAction func equalButtonClicked(_ sender: customButton) {
        secondValue = Double (screenLabel.text!)
        isCalculated = true
        let result = doTheMath(firstVal: firstValue!, secondVal:secondValue!, sign: operation!)
        
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        screenLabel.text = formatter.string(from: result as NSNumber)
        overviewLabel.text! += "\((formatter.string(from: secondValue! as NSNumber))!) ="
    }
    
    func doTheMath(firstVal:Double, secondVal:Double, sign:String) -> Double {
        switch sign {
        case "+":
            return (firstValue! + secondValue!)
        case "-":
            return (firstValue! - secondValue!)
        case "×":
            return (firstValue! * secondValue!)
        case "÷":
            return (firstValue! / secondValue!)
        case "%":
            return (firstValue!.truncatingRemainder(dividingBy: secondValue!))
        default:
            return 0
        }
    }
    
}

@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
