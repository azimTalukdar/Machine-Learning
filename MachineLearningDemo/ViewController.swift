//
//  ViewController.swift
//  MachineLearningDemo
//
//  Created by GENEXT-PC on 12/08/18.
//  Copyright © 2018 Azim. All rights reserved.
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

    @IBAction func AppleModelPressed(_ sender: Any) {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "LearningViewController") as! LearningViewController
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    @IBAction func IBM_WatsonPressd(_ sender: Any) {
    }
    
    
    @IBAction func PreTrainedPressed(_ sender: Any) {
    }
    
}

