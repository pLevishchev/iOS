//
//  ViewController.swift
//  example
//
//  Created by Павел Левищев on 14.06.2018.
//  Copyright © 2018 Павел Левищев. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlace: Bool = false

    var stillTyping: Bool = false
    var currentInput: Double {
        get {
            return Double(result.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0"{
                result.text = "\(valueArray[0])"
            } else {
                result.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
        
    @IBOutlet weak var result: UILabel!
    
    @IBAction func digits(_ sender: UIButton) {
        if result.text == "0"{
            result.text = ""
        }
        if stillTyping{
            if (result.text?.count)! < 20 {
                result.text = result.text! + sender.currentTitle!
                    }
        } else {
            result.text = sender.currentTitle
            stillTyping = true
        }
    }
    
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlace = false
    }
    
    func setColorForOrangebutton(_ sender: UIButton){
        sender.backgroundColor = UIColor(red: 250.0/255.0, green: 171.0/255.0, blue: 92.0/255.0, alpha: 1.0)
    }
    func setDefaultColor(_ sender: UIButton){
        sender.backgroundColor = UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        
        if stillTyping{
            secondOperand = currentInput
        }
        
        dotIsPlace = false
        
        switch operationSign {
        case "÷":
            setColorForOrangebutton(sender)
            operateWithTwoOperands{$0 / $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "+":
            operateWithTwoOperands{$0 + $1}
        default:
            break
        }
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        result.text! = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlace = false
    }
    
    @IBAction func revertSign(_ sender: UIButton) {
        if currentInput != 0{
            currentInput = -currentInput
        }
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        if firstOperand == 0{
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func floatPointButton(_ sender: UIButton) {
        if stillTyping && !dotIsPlace{
            result.text = result.text! + "."
            dotIsPlace = true
        } else if !stillTyping && !dotIsPlace{
            result.text = "0."
        }
    }
    @IBAction func sqrt(_ sender: UIButton) {
        currentInput = Darwin.sqrt(currentInput)
    }
    
}









