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
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
