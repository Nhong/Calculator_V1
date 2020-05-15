//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Kittinun Chobtham on 15/5/2563 BE.
//  Copyright © 2563 Kittinun Chobtham. All rights reserved.
//

import UIKit

typealias OperatorColor = (textColor: UIColor, backgroundColor: UIColor)

final class CalculatorViewController: UIViewController {

    let calculator = Calculator()
    let activeOperatorButton: OperatorColor
        = (textColor: .systemOrange,
           backgroundColor: .white)
    let disActiveOperatorButton: OperatorColor
        = (textColor: .white,
           backgroundColor: .systemOrange)
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var multiplyButton: UIButton!
    @IBOutlet private weak var divideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        updateNumberLabel()
    }

    // MARK - Action Numbers
    
    @IBAction func number0(sender: Any?) {
        inputNumber(number: 0)
    }
    
    @IBAction func number1(sender: Any?) {
        inputNumber(number: 1)
    }
    
    @IBAction func number2(sender: Any?) {
        inputNumber(number: 2)
    }
    
    @IBAction func number3(sender: Any?) {
        inputNumber(number: 3)
    }
    
    @IBAction func number4(sender: Any?) {
        inputNumber(number: 4)
    }
    
    @IBAction func number5(sender: Any?) {
        inputNumber(number: 5)
    }
    
    @IBAction func number6(sender: Any?) {
        inputNumber(number: 6)
    }
    
    @IBAction func number7(sender: Any?) {
        inputNumber(number: 7)
    }
    
    @IBAction func number8(sender: Any?) {
        inputNumber(number: 8)
    }
    
    @IBAction func number9(sender: Any?) {
        inputNumber(number: 9)
    }
    
    // MARK: - Operator Action
    
    @IBAction func addAction(sender: Any?) {
        summaryActionWhenTapOperation()
        updateOperatorButtons(inputOperator: .Add)
    }
    
    @IBAction func minusAction(sender: Any?) {
        summaryActionWhenTapOperation()
        updateOperatorButtons(inputOperator: .Minus)
    }
    
    @IBAction func multiplyAction(sender: Any?) {
        summaryActionWhenTapOperation()
        updateOperatorButtons(inputOperator: .Multiply)
    }
    
    @IBAction func divideAction(sender: Any?) {
        updateOperatorButtons(inputOperator: .Divide)
    }
    
    // MARK: - Other Actions
    
    @IBAction func clearButton(sender: Any?) {
        clearNumbers()
    }
    
    @IBAction func dotAction(sender: Any?) {
        addDotToLabel()
    }
    
    @IBAction func toggleOperatorAction(sender: Any?) {
        toggleOperator()
    }
    
    @IBAction func percentAction(sender: Any?) {
        convertToPercent()
    }
    
    @IBAction func summaryAction(sender: Any?) {
        summaryAction()
    }
    
    // MARK: - Update UI
    
    private func updateOperatorButtons(inputOperator: Operator) {
        calculator.updateCurrentOperator(inputOperator: inputOperator)
        
        switch inputOperator {
        case .Add:
            updateOperatorButtonsColor(addButtonColor: activeOperatorButton,
                                       minusButtonColor: disActiveOperatorButton,
                                       divideButtonColor: disActiveOperatorButton,
                                       multiplyButtonColor: disActiveOperatorButton)
        case .Minus:
            updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                       minusButtonColor: activeOperatorButton,
                                       divideButtonColor: disActiveOperatorButton,
                                       multiplyButtonColor: disActiveOperatorButton)
        case .Divide:
            updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                       minusButtonColor: disActiveOperatorButton,
                                       divideButtonColor: activeOperatorButton,
                                       multiplyButtonColor: disActiveOperatorButton)
        case .Multiply:
            updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                       minusButtonColor: disActiveOperatorButton,
                                       divideButtonColor: disActiveOperatorButton,
                                       multiplyButtonColor: activeOperatorButton)
        }
    }
    
    private func updateOperatorButtonsColor(addButtonColor: OperatorColor,
                                            minusButtonColor: OperatorColor,
                                            divideButtonColor: OperatorColor,
                                            multiplyButtonColor: OperatorColor) {
        updateAddButtonColor(addButtonColor: addButtonColor)
        updateMinusButtonColor(minusButtonColor: minusButtonColor)
        updateMultiplyButtonColor(multiplyButtonColor: multiplyButtonColor)
        updateDivideButtonColor(divideButtonColor: divideButtonColor)
    }
    
    private func updateAddButtonColor(addButtonColor: OperatorColor) {
        addButton.setTitleColor(addButtonColor.textColor,
                                for: .normal)
        addButton.backgroundColor = addButtonColor.backgroundColor        
    }
    
    private func updateMinusButtonColor(minusButtonColor: OperatorColor) {
        minusButton.setTitleColor(minusButtonColor.textColor,
                                for: .normal)
        minusButton.backgroundColor = minusButtonColor.backgroundColor
    }
    
    private func updateMultiplyButtonColor(multiplyButtonColor: OperatorColor) {
        multiplyButton.setTitleColor(multiplyButtonColor.textColor,
                                     for: .normal)
        multiplyButton.backgroundColor = multiplyButtonColor.backgroundColor
    }
    
    private func updateDivideButtonColor(divideButtonColor: OperatorColor) {
        divideButton.setTitleColor(divideButtonColor.textColor,
                                   for: .normal)
        divideButton.backgroundColor = divideButtonColor.backgroundColor
    }
    
    private func convertToPercent() {
        calculator.convertToPercent()
        updateNumberLabel()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
    }
    
    private func toggleOperator() {
        calculator.toggleOperator()
        updateNumberLabel()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
    }
    
    private func addDotToLabel() {
        calculator.inputDot()
        updateNumberLabel()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
    }
    
    private func clearNumbers() {
        calculator.clearNumbers()
        updateNumberLabel()
        updateClearButton()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
    }
    
    private func summaryAction() {
        calculator.summary()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
        updateNumberLabel()
    }
    
    private func summaryActionWhenTapOperation() {
        calculator.summaryWhenTapOperation()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
        updateNumberLabel()
    }
    
    private func updateNumberLabel() {
        numberLabel.text = calculator.number
    }
    
    private func inputNumber(number: Int) {
        calculator.inputNumber(number: number)
        updateNumberLabel()
        updateClearButton()
        updateOperatorButtonsColor(addButtonColor: disActiveOperatorButton,
                                   minusButtonColor: disActiveOperatorButton,
                                   divideButtonColor: disActiveOperatorButton,
                                   multiplyButtonColor: disActiveOperatorButton)
    }
    
    private func updateClearButton() {
        if calculator.isClearNumbers() {
            clearButton.setTitle("AC",
                                 for: .normal)
            
            return
        }
        
        clearButton.setTitle("C",
                             for: .normal)
    }
    
}
