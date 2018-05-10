//
//  ExitViewController.swift
//  WardClient
//
//  Created by Haida on 3/26/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class ExitViewController: SwitchViewController {

    @IBOutlet weak var proceedButton: UIButton!
    
    @IBOutlet weak var postTaskMessage: UILabel!
    
    
    override func buildScreen() {
        
        if current.run.toDo.isEmpty {
            
            postTaskMessage.text = NSLocalizedString("Both tasks complete", comment: "Preliminary")
            
            proceedButton.setTitle(NSLocalizedString("Close application", comment: "Preliminary arrangement; should not be visible to the patient"), for: .normal)
            
        } else {
            
            postTaskMessage.text = NSLocalizedString("First task complete", comment: "Preliminary")
            
            proceedButton.setTitle(NSLocalizedString("Proceed to next task", comment: "Preliminary arrangement; should not be visible to the patient"), for: .normal)
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildScreen()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    
    @IBAction func proceedOrExit(_ sender: Any) {
    
        var firstRow: Bool = true
        var firstColumn: Bool = true
        var outputString: String = ""
        
        if current.run.toDo.isEmpty {
            
            let fileManager = FileManager.default
            do {
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                let fileURL = documentDirectory.appendingPathComponent(current.run.patientRecord.id + ".csv")
                print(fileURL)
                for row in current.run.done {
                    if firstRow == false {
                        outputString.append("\n")
                    }
                    firstRow = false
                    firstColumn = true
                    for column in row {
                        if firstColumn == false {
                            outputString.append(",")
                        }
                        outputString.append(column)
                        firstColumn = false
                    }
                }
                try outputString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print(error)
            }
            
            exit(0)   // not in compliance with iOS Human Interface Guidelines
                      // but in our case admissible
        
        } else {
            
            jumpOff(fromScreen: "Posttask")
            
        }
    }
    
}
