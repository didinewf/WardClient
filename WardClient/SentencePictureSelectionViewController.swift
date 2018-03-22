//
//  SentencePictureSelectionViewController.swift
//  WardClient
//
//  Created by Haida on 3/22/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class SentencePictureSelectionViewController: ViewControllerWithSound {

    // MARK: Properties
    
    @IBOutlet weak var textStimulus: UILabel!
        
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

    // MARK: Actions
    
    @IBAction func playAudioStimulus(_ sender: UIButton) {
        
        playSound()
        
    }
    
    @IBAction func responseButton1(_ sender: UIButton) {
        
        DispatchQueue.main.async() {
            [unowned self] in
            self.performSegue(withIdentifier: "FromSelectionToMatching", sender: self)
        }
        
    }
    
    @IBAction func responseButton2(_ sender: UIButton) {
        
        textStimulus.text = NSLocalizedString("Response to Button 2", comment: "Localization test for Button 2")
        
    }
    
    
}
