//
//  SentencePictureSelectionViewController.swift
//  WardClient
//
//  Created by Haida on 3/22/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class SentencePictureSelectionViewController: ViewControllerWithSound {

    @IBOutlet weak var textStimulus: UILabel!    
    @IBOutlet weak var button1: RegisterAndMoveOnButton!
    @IBOutlet weak var button2: RegisterAndMoveOnButton!
    
    override func setButton1Image(image: UIImage) {
        button1.setImage(image, for: .normal)
    }
    
    override func setButton2Image(image: UIImage) {
        button2.setImage(image, for: .normal)
    }
    
    override func tellName() -> String {
        return "Selection"
    }
    
    override func buildScreen() {
        
        textStimulus.text = current.run.getStimulusSentence()
        button1.setImage(current.run.getImage(index: 1), for: .normal)
        button2.setImage(current.run.getImage(index: 2), for: .normal)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buildScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                       self.playSound(sound: current.run.getSound())
        })

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
        
        playSound(sound: current.run.getSound())
        
    }
   
    
    @IBAction func responseButton1(_ sender: RegisterAndMoveOnButton) {
        
        sender.moveOn(response: "Button1" ,sender: self)
        
    }
    
    @IBAction func responseButton2(_ sender: RegisterAndMoveOnButton) {
        
        sender.moveOn(response: "Button2" ,sender: self)
        
    }
    
    
}
