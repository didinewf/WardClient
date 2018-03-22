//
//  ViewControllerWithSound.swift
//  WardClient
//
//  Created by Haida on 3/22/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerWithSound: UIViewController {

    var player: AVAudioPlayer?

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

}
