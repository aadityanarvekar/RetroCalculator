//
//  ViewController.swift
//  Retro Calculator
//
//  Created by AADITYA NARVEKAR on 5/12/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var selectedOperationLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    enum availableOperations {
        case none
        case division
        case multiplication
        case subtraction
        case addition
    }
    
    private var number1: Double = 0.0
    private var number2: Double = 0.0
    
    private var operationSelected = availableOperations.none
    
    private var btnTappedSound = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        if let filePath = path {
            let BtnTappedSoundUrl = URL(fileURLWithPath: filePath)
            
            do {
                try btnTappedSound = AVAudioPlayer(contentsOf: BtnTappedSoundUrl)
                btnTappedSound.prepareToPlay()
            } catch let err as NSError {
                print(err.description)
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberBtnTapped(_ sender: Any) {
        if let numberBtn = sender as? UIButton {
            print(numberBtn.tag)
            btnTappedSound.play()
            
            if operationSelected == availableOperations.none {
                number1 = 10 * number1 + Double(numberBtn.tag)
                resultLbl.text = "\(number1)"
                print(number1)
            } else {
                number2 = 10 * number2 + Double(numberBtn.tag)
                resultLbl.text = "\(number2)"
                print(number2)
            }
        }
        
    }
    
    func performOperation() {
        guard operationSelected != availableOperations.none else {
            return
        }
        
        switch operationSelected {
        case .addition:
            print("Addition")
            number1 = number1 + number2
            
        case .subtraction:
            print("subtraction")
            number1 = number1 - number2
            
        case .multiplication:
            print("Multiplication")
            number1 = number1 * number2
            
        case .division:
            print("Division")
            number1 = number1 / number2
            
        default:
            print("Default")
        }
        
        resultLbl.text = "\(number1)"
        
        number2 = 0.0
        operationSelected = availableOperations.none
        selectedOperationLbl.text = ""
        selectedOperationLbl.isHidden = true
    }

    @IBAction func divideBtnTapped(_ sender: Any) {
        handleOperationBtnTapped(selectedOperation: .division)
    }

    @IBAction func multiplyBtnTapped(_ sender: Any) {
        handleOperationBtnTapped(selectedOperation: .multiplication)
    }
    
    @IBAction func minusBtnTapped(_ sender: Any) {
        handleOperationBtnTapped(selectedOperation: .subtraction)
    }
    
    @IBAction func plutBtnTapped(_ sender: Any) {
        handleOperationBtnTapped(selectedOperation: .addition)
    }
    
    @IBAction func equalToBtnTapped(_ sender: Any) {
        btnTappedSound.play()
        performOperation()
    }
    
    func handleOperationBtnTapped(selectedOperation: availableOperations) {
        btnTappedSound.play()
        selectedOperationLbl.isHidden = false
        
        switch selectedOperation {
        case .addition:
            performOperation()
            operationSelected = availableOperations.addition
            selectedOperationLbl.isHidden = false
            selectedOperationLbl.text = " + "
            
        case .subtraction:
            performOperation()
            operationSelected = availableOperations.subtraction
            selectedOperationLbl.isHidden = false
            selectedOperationLbl.text = " - "
            
        case .division:
            performOperation()
            operationSelected = availableOperations.division
            selectedOperationLbl.isHidden = false
            selectedOperationLbl.text = " / "
            
        case .multiplication:
            performOperation()
            operationSelected = availableOperations.multiplication
            selectedOperationLbl.isHidden = false
            selectedOperationLbl.text = " * "
            
        default:
            print("Default: Incorrect parameter passed to this function!")

        }
        

    }
    
}

