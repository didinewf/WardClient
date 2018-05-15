//
//  OperatorViewController.swift
//  WardClient
//
//  Created by Haida on 3/18/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

struct current {
    static var run = ExperimentRun()
}
    
class OperatorViewController: SwitchViewController {
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func StartExperiment(_ sender: Any) {
        
        current.run.patientRecord.id = "Patient0"
        current.run.patientRecord.language = "Hebrew"
        current.run.setOrientation()
        current.run.generateScript(by: current.run.experiment.spec)
        
        jumpOff(fromScreen: "Operator")
        
    }
    
}
