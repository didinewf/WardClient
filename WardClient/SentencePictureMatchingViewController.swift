//
//  SentencePictureMatchingViewController.swift
//  WardClient
//
//  Created by Haida on 3/20/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

class SentencePictureMatchingViewController: ViewControllerWithSound {

    @IBOutlet weak var textStimulus: UILabel!
    @IBOutlet weak var pictureStimulus: UIImageView!
    
    @IBOutlet weak var positiveButton: RegisterAndMoveOnButton!
    
    @IBOutlet weak var negativeButton: RegisterAndMoveOnButton!
    
    override func setButton1Image(image: UIImage) {
        positiveButton.setImage(image, for: .normal)
    }
    
    override func setButton2Image(image: UIImage) {
        negativeButton.setImage(image, for: .normal)
    }
    
    override func tellName() -> String {
        return "Matching"
    }
    
    override func buildScreen() {
        textStimulus.text = current.run.getStimulusSentence()
        pictureStimulus.image = current.run.getImage()
        positiveButton.setImage(UIImage(named: "Smile"), for: .normal)
        negativeButton.setImage(UIImage(named: "Sad"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func SoundButton(_ sender: Any) {
        
        playSound(sound: current.run.getSound())
        
    }
    
    @IBAction func PositiveResponse(_ sender: RegisterAndMoveOnButton) {
        
        sender.moveOn(response: "Positive" ,sender: self)
        
    }
    
    @IBAction func NegativeResponse(_ sender: RegisterAndMoveOnButton) {
        
        sender.moveOn(response: "Negative" ,sender: self)

    }
    
}
