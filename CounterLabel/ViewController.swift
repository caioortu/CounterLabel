//
//  ViewController.swift
//  CounterLabel
//
//  Created by Caio Ortu on 6/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: CounterLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.startValue = 2000.0
        counterLabel.finalValue = 100.0
        counterLabel.counterTime = 1.5
        counterLabel.startCounter()
    }


}

