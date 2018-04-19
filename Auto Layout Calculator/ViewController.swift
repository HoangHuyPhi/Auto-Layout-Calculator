//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Phi Hoang Huy on 3/24/18.
//  Copyright © 2018 Phi Hoang Huy. All rights reserved.
//

import UIKit
enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Devide = "/"
    case Multiply = "*"
    case NULL = "Null"
    case Percentage = "Percentage"
}
class ViewController: UIViewController {
    var countNumberOfDots = 0
    var hadFirstNumber = false
    var runningOutPut : String = "";
    var firstValue = ""
    var secondValue = ""
    var currentOperation: Operation = .NULL
    var result = ""
    @IBOutlet weak var outputLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func negativePressed(_ sender: Any) {
        runningOutPut = "-" + runningOutPut
        printOutPut()
    }
    @IBAction func numberPressed(_ sender: AnyObject) {
        runningOutPut += "\(sender.tag!)"
        hadFirstNumber = true
        printOutPut()
    }
    @IBAction func clearNumber(_ sender: Any) {
        runningOutPut = "";
        firstValue = "";
        secondValue = "";
        result = "";
        currentOperation = .NULL
        outputLabel.text = "0"
        hadFirstNumber = false
        printOutPut()
    }
    @IBAction func operationPressed(_ sender: UIButton) {
        if sender.tag == 13 && hadFirstNumber == true
        {
            operation(operation: .Devide)
        } else if  sender.tag == 14 && hadFirstNumber == true{
              operation(operation: .Multiply)
        } else if sender.tag == 15 && hadFirstNumber == true{
              operation(operation: .Subtract)
        } else if sender.tag == 16 && hadFirstNumber == true {
              operation(operation: .Add)
        } else if sender.tag == 17 && hadFirstNumber == true {
              operation(operation: currentOperation)
        } else if sender.tag == 12 && hadFirstNumber == true {
            if runningOutPut != "" {
            firstValue = "\(Double(runningOutPut)! / 100)"
            } else {
                    firstValue = "\(Double(firstValue)! / 100)"
            }
            outputLabel.text = firstValue
            operation(operation: .Percentage)
        }
    }
    @IBAction func dotPressed(_ sender: Any) {
        if runningOutPut != "" // check to make sure the dot can't be in the first position
        {
        checkNumberOfDots()
        if countNumberOfDots == 0
        {
        runningOutPut += ".";
        printOutPut()
        }
        }
    }
    func printOutPut()
    {
        outputLabel.adjustsFontSizeToFitWidth = true
             outputLabel.text = runningOutPut
    }
    func operation(operation: Operation)
    {
        if currentOperation != .NULL
        {
            if runningOutPut != ""
            {
                secondValue = runningOutPut
                runningOutPut = ""
                if currentOperation == .Add {
                    result = "\(Double(firstValue)!  + Double(secondValue)!)"
                } else if currentOperation == .Subtract {
                       result = "\(Double(firstValue)!  - Double(secondValue)!)"
                } else if currentOperation == .Multiply {
                         result = "\(Double(firstValue)!  * Double(secondValue)!)"
                } else if currentOperation == .Devide {
                  result = "\(Double(firstValue)!  / Double(secondValue)!)"
                }
                firstValue = result
                outputLabel.text = result
            }
            currentOperation = operation
        }
            else if operation == .Percentage
        {
            runningOutPut = ""
            currentOperation = operation
        }
        else {
            firstValue = runningOutPut
            runningOutPut = ""
            currentOperation = operation
        }
    }
    func checkNumberOfDots() // check for the number of dots appears
    {
        countNumberOfDots = 0
        for char in outputLabel.text! {
            if char == "."
            {
                countNumberOfDots += 1
            }
        }
    }
}

