//
//  CounterLabel.swift
//  CounterLabel
//
//  Created by Caio Ortu on 6/11/18.
//  Copyright © 2018 Caio Ortu. All rights reserved.
//

import UIKit

class CounterLabel: UILabel {
    
    fileprivate let increase = 0.1
    fileprivate let defaultTime = 1.5
    
    fileprivate var isCounting = false
    fileprivate var counter = 0.0
    var startValue = 0.0
    var finalValue = 0.0
    var counterTime = 0.0
    
    fileprivate var timeInterval: Double {
        if counterTime <= 0.0 {
            counterTime = defaultTime
        }
        return counterTime / (fabs(startValue - finalValue) / increase)
    }
    
    func startCounter() {
        if !isCounting {
            isCounting = true
            counter = startValue
            if finalValue > startValue {
                countUp()
            } else if startValue > finalValue {
                countDown()
            }
        }
    }
    
    fileprivate func countUp() {
        Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: { (timer) in
            if self.counter < self.finalValue {
                self.counter = self.counter + self.increase
                DispatchQueue.main.async {
                    self.text = String(format: "%.2f", self.counter)
                }
            } else {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.text = String(format: "%.2f", self.finalValue)
                }
            }
        })
    }
    
    fileprivate func countDown() {
        Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: { (timer) in
            if self.counter > self.finalValue {
                self.counter = self.counter - self.increase
                DispatchQueue.main.async {
                    self.text = String(format: "%.2f", self.counter)
                }
            } else {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.text = String(format: "%.2f", self.finalValue)
                }
            }
        })
    }
}
