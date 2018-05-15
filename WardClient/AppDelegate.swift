//
//  AppDelegate.swift
//  WardClient
//
//  Created by Haida on 3/18/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit

struct AppPersona {
    static let name = "WardClient"
    static let version = "0.5"
}

struct PatientRecord {
    var id = ""
    var language = ""
}

class Experiment {
    var version: String = ""
    var spec: [[String]] = []
    
    init() {
            if let asset = NSDataAsset(name: "ExperimentSpec") {
                let lines = String(data:asset.data, encoding: String.Encoding.utf8)?.components(separatedBy: .newlines)
                version = (lines?.first!)!
                for instr in (lines?.dropFirst())! {
                    spec.append(instr.components(separatedBy: ","))
                }
            }
    }
}

class ExperimentRun {
    static let delegate = AppPersona.name
    static let appVersion = AppPersona.version
    var interfaceOrientation: String = ""
    var experiment: Experiment
    var patientRecord = PatientRecord()
    var toDo: [[String]] = []
    var done: [[String]] = []
    
    init() {
            experiment = Experiment()
    }
    
    func getTaskCharacter() -> String {
        return toDo[0][0]
    }
    
    func getTaskType() -> String {
        return toDo[0][1]
    }
    
    func getStimulusSentence() -> String {
        return toDo[0][2]
    }

    func getImage(index: Int = 1) -> UIImage {
        return UIImage(named: toDo[0][3 + index])!
    }

    func getSound() -> NSDataAsset? {
        return NSDataAsset(name: toDo[0][3])
    }
    
    func getCorrectResponse() -> String {
        
        var taskType: String
        var correctResponse: String = ""
        
        taskType = getTaskType()
        
        if taskType == "PictureSelection" {
            correctResponse = toDo[0][6]
        } else if taskType == "PictureMatching" {
            correctResponse = toDo[0][5]
        }
        
        return correctResponse
    }
    
    func getWritingSystem(language: String) -> String {
        
        var writingSystem: String = ""
        
        if language == "Hebrew" || language == "Arabic" {
            writingSystem = "RightLeft"
        } else {
            writingSystem = "LeftRight"
        }
        
        return writingSystem
    }
    
    func setOrientation() {
        self.interfaceOrientation = getWritingSystem(language: patientRecord.language)
    }
    
    func evaluateResponse(response: String) -> String {
        
        var correctResponse: String
        var evaluation: String = ""
        
        correctResponse = getCorrectResponse()
        
        if response == correctResponse {
            evaluation = "correct"
        } else {
            evaluation = "wrong"
        }
        
        return evaluation
    }
    
    func getResponseDescription(response: String) -> String {
        
        var taskType: String
        var whichOne: String = ""
        var responseDescription: String = ""
        
        taskType = getTaskType()
        
        if taskType == "PictureSelection" {
            if response == "Button1" {
                if self.interfaceOrientation == "RightLeft" {
                    whichOne = "right hand"
                } else {
                    whichOne = "left hand"
                }
            } else {
                if self.interfaceOrientation == "RightLeft" {
                    whichOne = "left hand"
                } else {
                    whichOne = "right hand"
                }
            }
            responseDescription = "You selected the " + whichOne + " image"
            
        } else if taskType == "PictureMatching" {
            if response == "Positive" {
                responseDescription = "You clicked the smiling face"
            } else {
                responseDescription = "You clicked the frowning face"
            }
        }
            
        return responseDescription
    }
    
    func generateSoundassetName(stimulusSentence: String) -> String {
        return stimulusSentence + " (" + patientRecord.language + ")"
    }
    
    func generateScript(by spec: [[String]]) {
        var task: [String]
        
        for line in spec {
            task = []
            task.append(line[0])
            task.append(line[1])
            task.append(NSLocalizedString(line[2], comment: "localized stimulus sentence"))
            task.append(generateSoundassetName(stimulusSentence: line[2]))
            if line[1] == "PictureSelection" {
                task.append(line[3])
                task.append(line[4])
                if line[5] == "First" {
                    task.append("Button1")
                } else {
                    task.append("Button2")
                }
            } else if line[1] == "PictureMatching" {
                task.append(line[3])
                task.append(line[4])
            }
            toDo.append(task)
        }
    
    }

}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

