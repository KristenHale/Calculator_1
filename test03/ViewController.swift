//
//  ViewController.swift
//  test03
//
//  Created by Mac on 16/7/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appenDigt(sender: UIButton) {
        let digt = sender.currentTitle!
        if(userIsInTheMiddleOfTypingANumber){
            display.text = display.text! + digt
        }else{
             display.text = digt
            userIsInTheMiddleOfTypingANumber = true

        }
                //print("digt = \(digt)")
    }
    
    //
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×": performOperation({(op1,op2) in return op2*op1}); break  //在swift中类型是强制转换的，所以不需在参数中定义类型
            case "÷": performOperation({$1 / $0}) ; break //若return中只执行一条表达式,可将return 去掉，且无需定义参数名，swift自动默认以$0,$1,$2...为参数名
            case "+": performOperation{$1 + $0} ;break //若operation为最后一个参数，可将{$0 * $1}放到()后面，若只有一个参数，可将()去掉
            case "−": performOperation({(op1:Double,op2:Double) -> Double  in return op2-op1}) ; break
            case "√": performOperation_sqrt{sqrt($0)} ;break
            case "%": performOperation_sqrt{$0*0.01} ;break
            case "log": performOperation_sqrt{log($0)} ;break
            case "∜": performOperation_sqrt{sqrt(sqrt($0))} ;break
            default:break
        }
    }

    func  performOperation(operation: (Double,Double) -> Double){
        if(operandStack.count >= 2){
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func  performOperation_sqrt(operation: Double -> Double){
        if(operandStack.count >= 1){
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
//    func multiply(op1: Double,op2: Double) -> Double {
//        return op1*op2;
//    }
//    
//    func division(op1: Double,op2: Double) -> Double {
//        return op1/op2;
//    }
//    
//    func plus(op1: Double,op2: Double) -> Double {
//        return op1+op2;
//    }
//    
//    func minus(op1: Double,op2: Double) -> Double {
//        return op1-op2;
//    }
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue:Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            
        }
    }
   
    
    
}

