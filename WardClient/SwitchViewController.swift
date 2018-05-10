//
//  SwitchViewController.swift
//  WardClient
//
//  Created by Haida on 3/18/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {
    
    func tellName() -> String {
        return ""
    }
    
    func buildScreen() {
    
    }
    
    func setButton1Image(image: UIImage) {
        
    }
    
    func setButton2Image(image: UIImage) {
        
    }
    
    func isTaskScreen(screenName: String) -> Bool {
        
        return screenName == "Selection" || screenName == "Matching"
        
    }
    
    func jumpOff(fromScreen: String) {
        
        var toScreen: String = ""
        
        if isTaskScreen(screenName: fromScreen) {
            
            toScreen = "Posttask"
        
        } else if current.run.toDo.isEmpty == false {
            
            toScreen = getSegueTarget()
        
        }
            
        let identifier = "From" + fromScreen + "To" + toScreen
        
        DispatchQueue.main.async() {
            [unowned self] in
            self.performSegue(withIdentifier: identifier, sender: self)
                
        }
        
    }
    
    func getSegueTarget() -> String {
        
        var segueTarget: String = ""
        var nextTask: String
        
        nextTask = current.run.getTaskType()
        
        if nextTask == "PictureMatching" {
            segueTarget = "Matching"
        } else if nextTask == "PictureSelection" {
            segueTarget = "Selection"
        }
        
        return segueTarget
    
    }
    
    // func nextStep
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      //  var toViewController: SwitchViewController?
        
      //  if ((segue.identifier?.range(of: "ToMatching")) != nil) {
      //      toViewController = (segue.destination as? SentencePictureMatchingViewController)!
      //  } else if ((segue.identifier?.range(of: "ToSelection")) != nil) {
      //      toViewController = (segue.destination as? SentencePictureSelectionViewController)!
      //  } else if ((segue.identifier?.range(of: "ToExit")) != nil) {
      //      toViewController = (segue.destination as? ExitViewController)!
      //  }
        
        //if toViewController != nil {
        //    if ((segue.identifier?.range(of: "FromOperator")) != nil) {
        //        toViewController?.done = current.run.done
        //        toViewController?.toDo = current.run.toDo
        //    } else {
        //        toViewController?.done = current.run.done + [current.run.toDo[0] + [response]]
        //        toViewController?.toDo = Array(current.run.toDo.dropFirst())
        //    }
        //}
    //}
    
}
