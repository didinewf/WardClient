//
//  ViewController.swift
//  WardClient
//
//  Created by Haida on 3/18/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var textStimulus: UILabel!
   
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func playSound() {
        guard let asset = NSDataAsset(name:"Audio1") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
  
    // MARK: Actions
    
    @IBAction func playAudioStimulus(_ sender: UIButton) {
        
        playSound()
        
    }
    
    @IBAction func responseButton1(_ sender: UIButton) {
        
        DispatchQueue.main.async() {
            [unowned self] in
            self.performSegue(withIdentifier: "OtherTask", sender: self)
        }
        
    }

    @IBAction func responseButton2(_ sender: UIButton) {
        
        textStimulus.text = NSLocalizedString("Response to Button 2", comment: "Localization test for Button 2")
    
    }
    
    
}
