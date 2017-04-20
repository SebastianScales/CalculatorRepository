//
//  ViewController.swift
//  Calculator
//
//  Created by Madison Heck on 3/9/17.
//  Copyright © 2017 SebastianScales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    //keeps track of whether or not the user is typing
    var userTyping = false
    
    //display basic digits
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userTyping{
            
            let displayText = display.text!
            
            display.text = displayText + digit
        }
        else {
            display.text = digit
            userTyping = true
        }
        
    }
    
    //clear button
    @IBAction func clearAll(_ sender: UIButton) {
        display.text = String(0)
        computationDisplay.text = String(0)
        totalOperation = ""
        result = ""
        tempTotalOperation = ""
        symbolButton = false
    }
    
    //true iff a symbol button has been pressed prior to the equals sign
    var symbolButton = false
    @IBAction func mathSymbolButton(_ sender: UIButton) {
        symbolButton = true
    }
    
    //operations displayer
    @IBOutlet weak var computationDisplay: UILabel!
    
    var lastButton = ""
    var totalOperation = ""
    var tempTotalOperation = ""
    var result = ""
    var Github: String = ""
    
    @IBAction func result(_ sender: UIButton) {
        result = display.text!
        print(result)
    }
    
    
    @IBAction func compute(_ sender: UIButton){
        
        if lastButton == "=" && symbolButton == true {
            computationDisplay.text = (tempTotalOperation) + " " + result + " " + sender.currentTitle!
            print("working")
            totalOperation = computationDisplay.text!
            print(totalOperation)
            tempTotalOperation = ""
            symbolButton = false
            lastButton = ""
        }
        else if sender.currentTitle! == "=" {
            totalOperation = totalOperation + " " + sender.currentTitle!
            computationDisplay.text = (totalOperation)
            tempTotalOperation = totalOperation
            print(tempTotalOperation)
            totalOperation = ""
            lastButton = "="
        }
        else if sender.currentTitle! == "." {
            totalOperation = totalOperation + sender.currentTitle!
            computationDisplay.text = totalOperation
            lastButton = "."
        }
        else if lastButton == "." {
            totalOperation = totalOperation + sender.currentTitle!
            computationDisplay.text = totalOperation
            lastButton = ""
        }
        else {
            totalOperation = totalOperation + " " + sender.currentTitle!
            computationDisplay.text = totalOperation
            lastButton = ""
        }
    }


   @IBAction func description(_ sender: UIButton) {
        var descript = ""
        if sender.currentTitle! != "=" {
                descript = descript + sender.currentTitle!
        }
        
    }
    
    //value displayed in top UI Label
    var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    //reference to the model struct
    fileprivate var brain = CalculatorBrain()
    
    //accounts for all mathematical symbol calls
    @IBAction func piButton(_ sender: UIButton) {
            if userTyping{
                brain.setOperand(displayValue)
                userTyping = false
            }
            if let mathematicalSymbol = sender.currentTitle{
                brain.performOperation(mathematicalSymbol)
            }
            if let result = brain.result{
                displayValue = result
            }
    }
}



