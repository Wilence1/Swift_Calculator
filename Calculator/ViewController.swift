//
//  ViewController.swift
//  Calculator
//
//  Created by Irina Korneeva on 03/12/15.
//  Copyright (c) 2015 Irina Korneeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping: Bool = false
   
    var brain = CalculatorBrain()
    
    @IBAction func appenDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        print("digit = \(digit)")
        if (userIsTyping) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
        
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
    @IBAction func enter() {
        userIsTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsTyping {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation){
               displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
}

