//
//  ViewController.swift
//  WardClient
//
//  Created by Haida on 3/18/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        var instructions: [String]?
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        print("I'm here")
        do {
            if let path = Bundle.main.path(forResource: "Script", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                instructions = data.components(separatedBy: "\n")
                print(instructions ?? "")
                print("gaga")
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func StartExperiment(_ sender: Any) {
        
        DispatchQueue.main.async() {
            [unowned self] in
            self.performSegue(withIdentifier: "FromOperatorToSelection", sender: self)
        }
        
    }
    

}
