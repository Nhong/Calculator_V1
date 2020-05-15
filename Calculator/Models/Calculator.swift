//
//  Calculator.swift
//  Calculator
//
//  Created by Kittinun Chobtham on 15/5/2563 BE.
//  Copyright © 2563 Kittinun Chobtham. All rights reserved.
//

import Foundation

enum Operator {
    case Add
    case Minus
    case Multiply
    case Divide
}
final class Calculator {
    
    var number: String = "0"
    var previousNumber: String = "0"
    var currentOperator: Operator?
    var previousOperator: Operator?
    
    func inputNumber(number: Int) {
        if isCannotInputNumber(inputNumber: number) { return }
        
        updatePreviousOperator()
        updateNumber(inputNumber: number)
    }
    
    func updatePreviousOperator() {
        if let currentOperator = self.currentOperator {
            previousOperator = currentOperator
        }
    }
    
    func inputDot() {
        if isContainDot(number: number) { return }
        
        number += "."
    }
    
    func toggleOperator() {
        if isUnsigned() {
            toggleToMinus()
        } else {
            toggleToUnSigned()
        }
    }
    
    func summaryWhenTapOperation() {
        if (isContainDot(number: number) || isContainDot(number: previousNumber)) {
            summaryWhenNumberIsFloating()
        } else {
            summaryWhenNumberIsInteger()
        }
    }
    
    func summary() {
        if (isContainDot(number: number) || isContainDot(number: previousNumber)) {
            summaryWhenNumberIsFloating()
        } else {
            summaryWhenNumberIsInteger()
        }
        
        clearCurrentOperator()
        clearPreviousOperator()
    }
    
    func summaryWhenNumberIsInteger() {
        guard let previousOperator = self.previousOperator else { return }
        
        switch previousOperator {
        case .Add:
            number = String(Int(previousNumber)! + Int(number)!)
        case .Minus:
            number = String(Int(previousNumber)! - Int(number)!)
        case .Multiply:
            number = String(Int(previousNumber)! * Int(number)!)
        case .Divide:
            let newNumber = Float(previousNumber)! / Float(number)!
            updateNumber(newNumber: newNumber)
        }
    }
    
    func summaryWhenNumberIsFloating() {
        guard let previousOperator = self.previousOperator else { return }
        
        var newNumber: Float = 0.0
        
        switch previousOperator {
        case .Add:
            newNumber = Float(previousNumber)! + Float(number)!
        case .Minus:
            newNumber = Float(previousNumber)! - Float(number)!
        case .Multiply:
            newNumber = Float(previousNumber)! * Float(number)!
        case .Divide:
            newNumber = Float(previousNumber)! / Float(number)!
        }
        
        updateNumber(newNumber: newNumber)
    }
        
    func convertToPercent() {
        let newNumber = Float(number)! / 100.0
        
        updateNumber(newNumber: newNumber)
    }
    
    func updateNumber(newNumber: Float) {
        if isInt(number: newNumber) {
            number = String(Int(newNumber))
        } else {
            number = String(newNumber)
        }
    }
    
    func updateCurrentOperator(inputOperator: Operator) {
        self.currentOperator = inputOperator
        self.previousNumber = number
    }
    
    func toggleToMinus() {
        number = "-" + number
    }
    
    func toggleToUnSigned() {
        number = number.components(separatedBy: "-").last!
    }
    
    func isInt(number: Float) -> Bool {
        return number.truncatingRemainder(dividingBy: 1.0) == 0.0
    }
    
    func isUnsigned() -> Bool {
        if number == "-0" {
            return false
        }
        
        if isInt(number: Float(number)!) {
            return Int(number)! >= 0
        }
        
        return Float(number)! >= 0.0
    }
    
    func isCannotInputNumber(inputNumber: Int) -> Bool {
        return self.number == "0" && inputNumber == 0
    }
    
    func isClearNumbers() -> Bool {
        return self.number == "0"
    }
    
    func isContainDot(number: String) -> Bool {
        return number.contains(".")
    }
    
    func isInputAfterTapOperatorAction() -> Bool {
        return previousOperator != nil && currentOperator != nil
    }
    
    func updateNumber(inputNumber: Int) {
        if let _ = self.previousOperator {
            updateNumberWhenHasOperator(inputNumber: inputNumber)
            
            return
        }
        
        updateNumberWhenNotHasOperator(inputNumber: inputNumber)
    }
    
    func updateNumberWhenHasOperator(inputNumber: Int) {
        if isInputAfterTapOperatorAction() {
            clearNumbers()
        }
        
        if isContainDot(number: number) {
            updateNumberWhenNumberIsFloat(inputNumber: inputNumber)
        } else {
            updateNumberWhenNumberIsInteger(inputNumber: inputNumber)
        }
        
        clearCurrentOperator()
    }
    
    func updateNumberWhenNotHasOperator(inputNumber: Int) {
        if number == "0" {
            number = String(inputNumber)
            
            return
        }
        
        if isContainDot(number: number) {
            updateNumberWhenNumberIsFloat(inputNumber: inputNumber)
        } else {
            updateNumberWhenNumberIsInteger(inputNumber: inputNumber)
        }
    }
    
    func updateNumberWhenNumberIsInteger(inputNumber: Int) {
        let optionalNewNumber = Int(String(number) + "\(inputNumber)")
        
        if let newNumber = optionalNewNumber {
            self.number = "\(newNumber)"
        }
    }
    
    func updateNumberWhenNumberIsFloat(inputNumber: Int) {
        let optionalNewNumber = Float(String(number) + "\(inputNumber)")
        
        if let newNumber = optionalNewNumber {
            self.number = "\(newNumber)"
        }
    }
    
    func clearNumbers() {
        number = "0"
    }
    
    func clearCurrentOperator() {
        currentOperator = nil
    }
    
    func clearPreviousOperator() {
        previousOperator = nil
    }
    
}
