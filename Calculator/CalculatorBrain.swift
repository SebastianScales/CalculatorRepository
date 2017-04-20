//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Madison Heck on 3/10/17.
//  Copyright © 2017 SebastianScales. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    
    var resultIsPending = false
    
    fileprivate var accumulator: Double?
    
    //dictionary of operations
    fileprivate var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(M_PI), // M_PI
        "e" : Operation.constant(M_E), // M_E
        "√" : Operation.unaryOperation(sqrt), //sqrt
        "cos" : Operation.unaryOperation(cos), //cos
        "sin" : Operation.unaryOperation(sin), //sin
        "tan" : Operation.unaryOperation(tan), //tam
        "log" : Operation.unaryOperation(log2), //log
        "±"   : Operation.unaryOperation({-$0}), //sign change
        "+" : Operation.binaryOperation({$0 + $1}), //add
        "-" : Operation.binaryOperation({$0 - $1}),//subtract
        "✕" : Operation.binaryOperation({$0 * $1}), //multiply
        "÷" : Operation.binaryOperation({$0 / $1}), //divide
        "EXP" : Operation.binaryOperation({pow(Double($0),Double( $1))}), //exponent
        "=" : Operation.equals
        
    ]
    
    //specifies possible operations and respective types
    fileprivate enum Operation{
        case constant (Double)
        case unaryOperation ((Double)->Double)
        case binaryOperation ((Double, Double) -> Double)
        case equals
    }
    
    //string used to keep track of operations
    var descript = ""
    
    //performs selected operation specified in the operations dictionary
    mutating  func performOperation (_ symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let constantValue):
                accumulator = constantValue
                descript = descript + String(accumulator!) + String(symbol)
            case .unaryOperation(let f):
                if accumulator != nil {
                    accumulator = f(accumulator!)
                    descript = descript + String(accumulator!) + String(symbol)
                }
            case .binaryOperation(let f):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: f, firstOperand: accumulator!)
                    descript = descript + String(accumulator!) + String(symbol)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                descript = ""
                
            }
        }
        
    }
    
    //struct with internal call of function that executes binary operations
    struct PendingBinaryOperation{
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    fileprivate var pendingBinaryOperation: PendingBinaryOperation?
    
    //function that executes binary operations
    mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand:Double){
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    
    }
    
}
