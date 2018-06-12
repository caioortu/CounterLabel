//
//  ViewController.swift
//  CounterLabel
//
//  Created by Caio Ortu on 6/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: CountingLabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        counterLabel.count(from: 2000.0, to: 100.0)
    }

}

