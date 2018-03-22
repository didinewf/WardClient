//
//  SentencePictureMatchingViewController.swift
//  WardClient
//
//  Created by Haida on 3/20/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class SentencePictureMatchingViewController: ViewControllerWithSound {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        playSound()
    
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

    
    @IBAction func SoundButton(_ sender: Any) {
        
        playSound()
        
    }
    
    
}
