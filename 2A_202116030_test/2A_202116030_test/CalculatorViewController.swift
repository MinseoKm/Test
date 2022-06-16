//
//  ViewController.swift
//  2A_202116030_test
//
//  Created by 203a10 on 2022/06/16.
//

import UIKit

enum Operation {

    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class CalculatorViewController: UIViewController {

    @IBOutlet weak var lblNumberOutput: UILabel!

    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapBtnNumber(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else {return}
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.lblNumberOutput.text = self.displayNumber
        }
    }
    
    @IBAction func tapBtnClear(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.lblNumberOutput.text = "0"
    }
    
    @IBAction func tapBtnDot(_ sender: UIButton) {
   
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.lblNumberOutput.text = self.displayNumber
        }
    }
    
    @IBAction func tapBtnDivide(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func tapBtnMultiply(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func tapBtnSubtract(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapBtnAdd(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapBtnEqual(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {

        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
  
                guard let firstOperand = Double(self.firstOperand)
                else {
                    return
                }
                guard let secondOperand = Double(self.secondOperand) else {
                    return
                    
                }
                
  
                switch currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                default:
                    break
                }
                
        
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result
                self.lblNumberOutput.text = self.result
            }
            self.currentOperation = operation
            
        } else{
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
}

