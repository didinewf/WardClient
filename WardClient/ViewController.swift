//
//  ViewController.swift
//  WardClient
//
//  Created by Haida on 3/18/18.
//  Copyright © 2018 ELSC. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        /* Functions*/
        func load_data(file_name:String)->[String]{
            // load the .csv file for the data
            
            let fileURLProject = Bundle.main.path(forResource: file_name ,ofType: "csv")
            var readStringProject = ""
            do{
                readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
            } catch let error as NSError{
                print ("Failed to read from project")
                print (error)
            }
            let lines : [String] = readStringProject.components(separatedBy:"\n")
            return lines
        }
    

        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // Experiment structure
        struct Tasks{
            var task1: String
            var task2: String
        }
        
        var Task_order = [Tasks]()
        
        
        
        /*SenteneVerification Task*/
        // load data from .csv
        let data_SV = load_data (file_name:"SentenceVerification")
        
        // manual key in the number of conditions
        let num_of_conditions_SV = 4  //total number of different conditions in the experiment
        let num_of_blocks_SV = 5     // how many blocks are the experiment questions separated to? Should be factor of the number of questions in each condition
        let numofexamples_SV = (data_SV.count - 1)/num_of_conditions_SV  // how many questions are there in each condition?
        let que_per_block_SV = (data_SV.count - 1)/num_of_blocks_SV      // how many quesitons are there in each block?
        
        
        // build up struct variable
        struct SentenceVerification {
            var condition: String
            var sentence: String
            var audio: String
            var pic: String
            var answer: String
        }
        
        var structured_data_SV = [SentenceVerification]()
        
        // convert the raw data to struct
        for row in data_SV {
            let elementsinrow = row.components(separatedBy: ",")
            structured_data_SV.append(SentenceVerification(condition: elementsinrow[0], sentence: elementsinrow[1], audio: elementsinrow[2], pic: elementsinrow[3], answer: elementsinrow[4]))
        }
        
        // create arrays for different conditions
        var cond1_SV = [SentenceVerification]()
        var cond2_SV = [SentenceVerification]()
        var cond3_SV = [SentenceVerification]()
        var cond4_SV = [SentenceVerification]()
        
        // sort the structured data by conditions
        for row in structured_data_SV{
            if row.condition == "1"{
                cond1_SV.append(row)
            }
            if row.condition == "2"{
                cond2_SV.append(row)
            }
            if row.condition == "3"{
                cond3_SV.append(row)
            }
            if row.condition == "4"{
                cond4_SV.append(row)
            }
        }
        
        
        // 2D array to save all the questions in all the conditions
        let conditions_SV :[[SentenceVerification]] = [cond1_SV,cond2_SV,cond3_SV,cond4_SV]
        
        
        // shuffle questions within each condition
        
        var shuffled_SV = Array(repeating: Array(repeating: SentenceVerification(condition:"",sentence:"", audio:"", pic:"", answer:""), count: numofexamples_SV), count: num_of_conditions_SV)
        for (index,cond) in conditions_SV.enumerated(){
            
            shuffled_SV[index] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in:cond) as! [SentenceVerification]
            
            for item in shuffled_SV[index].enumerated(){
                print (item)
            }
        }
        
        // distribute questions from each condition to different blocks
        var block_SV = Array (repeating: Array(repeating:SentenceVerification(condition:"",sentence:"", audio:"", pic:"", answer:""), count:que_per_block_SV), count: num_of_blocks_SV)
        var m = 0
        var n = 0
        for item in shuffled_SV{
            m = 0
            for example in item{
                if m<num_of_blocks_SV{
                    block_SV[m][n] = example
                } else{
                    block_SV[m%num_of_blocks_SV][n+m/num_of_blocks_SV]=example
                }
                m += 1
            }
            n += m/num_of_blocks_SV
        }
        
        /*print ("Question sets before randomization:\r\n" )
         for item in block.enumerated(){
         print (item,"\n")
         }
         */
        // shuffle within each block
        var final_order_SV = Array (repeating: Array(repeating:SentenceVerification(condition:"",sentence:"", audio:"", pic:"", answer:""), count:que_per_block_SV), count: num_of_blocks_SV)
        print ("Question sets after randomization:\r\n" )
        for (index,questions) in block_SV.enumerated() {
            final_order_SV[index] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in:questions) as! [SentenceVerification]
            print ("block\(index+1)")
            for item in final_order_SV[index].enumerated(){
                print (item)
            }
        }
        
        /* PictureMatching Task*/
        //sort the text file to rows
        let data_PM = load_data(file_name:"testdata")
        
        // manual key in the number of conditions
        let num_of_conditions = 4  //total number of different conditions in the experiment
        let num_of_blocks = 10      // how many blocks are the experiment questions separated to? Should be factor of the number of questions in each condition
        let numofexamples = (data_PM.count - 1)/num_of_conditions  // how many questions are there in each condition?
        let que_per_block = (data_PM.count - 1)/num_of_blocks      // how many quesitons are there in each block?
        
        // build up struct variable
        struct PictureMatching {
            var condition: String
            var sentence: String
            var audio: String
            var pic1: String
            var pic2: String
        }
        
        var structured_data = [PictureMatching] ()
        
        // convert the raw data to struct
        for row in data_PM {
            let elementsinrow = row.components(separatedBy: ",")
            structured_data.append(PictureMatching(condition: elementsinrow[0], sentence: elementsinrow[1], audio: elementsinrow[2], pic1: elementsinrow[3], pic2: elementsinrow[4]))
        }

        // create arrays for different conditions
        var cond1 = [PictureMatching]()
        var cond2 = [PictureMatching]()
        var cond3 = [PictureMatching]()
        var cond4 = [PictureMatching]()
        
        // sort the structured data by conditions
        for row in structured_data{
            if row.condition == "1"{
                cond1.append(row)
            }
            if row.condition == "2"{
                cond2.append(row)
            }
            if row.condition == "3"{
                cond3.append(row)
            }
            if row.condition == "4"{
                cond4.append(row)
            }
        }
    

        // 2D array to save all the questions in all the conditions
        let conditions :[[PictureMatching]] = [cond1,cond2,cond3,cond4]
        
 
        // shuffle questions within each condition
    
        var shuffled = Array(repeating: Array(repeating: PictureMatching(condition:"",sentence:"", audio:"", pic1:"", pic2:""), count: numofexamples), count: num_of_conditions)
        for (index,cond) in conditions.enumerated(){
           
            shuffled[index] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in:cond) as! [PictureMatching]
           
        for item in shuffled[index].enumerated(){
        print (item)
        }
        }
        
        // distribute questions from each condition to different blocks
        var block = Array (repeating: Array(repeating:PictureMatching(condition:"",sentence:"", audio:"", pic1:"", pic2:""), count:que_per_block), count: num_of_blocks)
        var j = 0
        var k = 0
        for item in shuffled{
            j = 0
            for example in item{
                if j<num_of_blocks{
                block[j][k] = example
                } else{
                block[j%num_of_blocks][k+j/num_of_blocks]=example
                }
                j += 1
            }
            k += j/num_of_blocks
        }
        
        /*print ("Question sets before randomization:\r\n" )
        for item in block.enumerated(){
            print (item,"\n")
        }
        */
        // shuffle within each block
        var final_order = Array (repeating: Array(repeating:PictureMatching(condition:"",sentence:"", audio:"", pic1:"", pic2:""), count:que_per_block), count: num_of_blocks)
        print ("Question sets after randomization:\r\n" )
        for (index,questions) in block.enumerated() {
            final_order[index] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in:questions) as! [PictureMatching]
             print ("block\(index+1)")
            for item in final_order[index].enumerated(){
                print (item)
            }
        }

        
      print (final_order[4])
      print (final_order.last!.last!.sentence)
       
    }
}
