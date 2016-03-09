//
//  ViewController.swift
//  myCalculator
//
//  Created by Michelle Lee on 3/8/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String {
        case Divide = "/"
        case Multiple = "X"
        case Add = "+"
        case Substract = "-"
        case Percent = "%"
        case Empty = "Empty"
    }


    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var ACbtnLabel: UIButton!
    @IBOutlet weak var cBtnLabel: UIButton!


    var btnSound: AVAudioPlayer!
    var result = ""
    var currentRunningNum = ""
    var rightSideNum = ""
    var leftSideNum = ""
    var currentOperation: Operation = Operation.Empty

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ACbtnLabel.hidden = false
        cBtnLabel.hidden = true

        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
                btnSound.prepareToPlay()
            
        }catch let err as NSError{
            print(err.debugDescription)
            
        }
        
        
    }
    @IBAction func btns(btn: UIButton){
        playSound()
        currentRunningNum += "\(btn.tag)"
        resultLabel.text = currentRunningNum
//        ACbtnLabel.hidden = true
//        cBtnLabel.hidden = false
    }

    @IBAction func onPressMultipleBtn(sender: UIButton) {
        currentOperationResult(Operation.Multiple)
    }
   
    @IBAction func onPressDivBtn(sender: UIButton) {
        currentOperationResult(Operation.Divide)
    }
    
    @IBAction func onPressMinusBtn(sender: UIButton) {
        currentOperationResult(Operation.Substract)
    }
    
    @IBAction func onPressAddBtn(sender: UIButton){
        currentOperationResult(Operation.Add)
    
    }
    
    @IBAction func onPressPercentBtn(sender: UIButton){
        currentOperationResult(Operation.Percent)
    }
    
    
//    @IBAction func onPressCBtn(sender: UIButton){
//        ACbtnLabel.hidden = false
//        cBtnLabel.hidden = true
//        clearAll()
//        playSound()
//    }
    @IBAction func onPressACBtn(sender: UIButton){
        currentOperation = Operation.Empty
        clearAll()
        playSound()
    }
    
    @IBAction func onPressEqualBtn(sender: UIButton){
        currentOperationResult(currentOperation)
        
    }

    func clearAll(){
        resultLabel.text = "0"
        currentRunningNum = ""

    }
    
    func playSound(){
        if btnSound.playing{
        btnSound.stop()
        }
    btnSound.play()
    }
    
    func currentOperationResult(op: Operation){
        // run math here
        
        playSound()
        
        if currentOperation != Operation.Empty{
        
        if currentRunningNum != "" {
            rightSideNum = currentRunningNum
            currentRunningNum = ""
            
            if currentOperation == Operation.Multiple{
                result = "\(Double(leftSideNum)! * Double(rightSideNum)!)"
                
            }else if currentOperation == Operation.Divide{
                result = "\(Double(leftSideNum)! / Double(rightSideNum)!)"
            
            }else if currentOperation == Operation.Add{
                result = "\(Double(leftSideNum)! + Double(rightSideNum)!)"
            
            }else if currentOperation == Operation.Substract{
                result = "\(Double(leftSideNum)! - Double(rightSideNum)!)"
            
            }else if currentOperation == Operation.Percent{
                
                result = "\(Double(leftSideNum)! % Double(rightSideNum)!)"
            }
            
            leftSideNum = result
            resultLabel.text = result
            }
            currentOperation = op
            
        }else{
            //this is the first time an perator has been pressed
            leftSideNum = currentRunningNum
            currentRunningNum = ""
            currentOperation = op
        }
        
}

}
