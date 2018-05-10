//
//  RegisterAndMoveOnButton.swift
//  WardClientTests
//
//  Created by Haida on 3/26/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class RegisterAndMoveOnButton: UIButton {

    func registerMoveOn(response: String, evaluation: String, sender: ViewControllerWithSound) {
        
        var currentTask: [String]
        var currentTaskType: String
        var nextTaskType: String
        
        currentTaskType = current.run.getTaskType()
        currentTask = current.run.toDo.first!
        currentTask.append(response)
        currentTask.append(evaluation)
        current.run.done.append(currentTask)
        current.run.toDo = Array(current.run.toDo.dropFirst())
        
        if current.run.toDo.isEmpty == false {
            nextTaskType = current.run.getTaskType()
        } else {
            nextTaskType = "Posttask"
        }
        
        if currentTaskType == nextTaskType {
            
            sender.buildScreen()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                sender.playSound(sound: current.run.getSound())
            })
            
        } else {
            
            sender.jumpOff(fromScreen: sender.tellName())
            
        }
        
    }
    
    func moveOn(response: String, sender: ViewControllerWithSound) {
        
        var evaluation: String
        var correctResponse: String
        //var alertMessage: String = ""

        evaluation = current.run.evaluateResponse(response: response)
        correctResponse = current.run.getCorrectResponse()
        
        //if evaluation == "correct" {
        //
        //    alertMessage = "✔"
        //
        //} else {
        //
        //    alertMessage = "X"
        //
        //}
        
        if current.run.getTaskCharacter() == "Practice" {
            
            if evaluation == "correct" {
                if correctResponse == "Button1" || correctResponse == "Positive" {
                    sender.setButton1Image(image: UIImage(named: "Green Tick")!)
                } else {
                    sender.setButton2Image(image: UIImage(named: "Green Tick")!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
                    self.registerMoveOn(response: response, evaluation: evaluation, sender: sender)
                })
            } else {
                if correctResponse == "Button2" || correctResponse == "Negative" {
                        sender.setButton1Image(image: UIImage(named: "Red X")!)
                    } else {
                        sender.setButton2Image(image: UIImage(named: "Red X")!)
                    }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
                    sender.buildScreen()
                    sender.playSound(sound: current.run.getSound())
                })
            }
        
            //let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            //
            //let titleFont = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
            //let messageFont = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 35)]
            //
            //let responseDescription = current.run.getResponseDescription(response: response)
            //
            //let titleAttrString = NSMutableAttributedString(string: NSLocalizedString(responseDescription, comment: "All possible strings must be localized"), attributes: titleFont)
            //let messageAttrString = NSMutableAttributedString(string: alertMessage, attributes: messageFont)
            //alert.setValue(titleAttrString, forKey: "attributedTitle")
            //alert.setValue(messageAttrString, forKey: "attributedMessage")
            
            if evaluation == "wrong" {
                //alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: "Repeat button"), style: .default, handler: {(_ UIAlertAction) in sender.playSound(sound: current.run.getSound())}))
                //alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: "Repeat button"), style: .cancel, handler: {(_ UIAlertAction) in sender.playSound(sound: current.run.getSound())}))
                //}  else {
                //alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Move on button"), style: .default, handler: {(_ UIAlertAction) in self.registerMoveOn(response: response, evaluation: evaluation, sender: sender)}))
                //alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Move on button"), style: .cancel, handler: {(_ UIAlertAction) in self.registerMoveOn(response: response, evaluation: evaluation, sender: sender)}))
                }
            
            //let popover = alert.popoverPresentationController
            //popover?.sourceView = sender.view
            //popover?.sourceRect = CGRect(x: sender.view.bounds.midX - (alert.view.bounds.width * 0.5), y: sender.view.bounds.midY - 90, width: alert.view.bounds.width, height: 0)
            //popover?.permittedArrowDirections = UIPopoverArrowDirection.any
            
            //sender.present(alert, animated: true, completion: nil)
            
        } else {
            registerMoveOn(response: response, evaluation: evaluation, sender: sender)
        }
        
    }

}
