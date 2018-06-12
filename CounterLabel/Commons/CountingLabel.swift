import UIKit

class CountingLabel: UILabel {
    
    fileprivate let counterVelocity: Float = 3.0
    
    enum CounterAnimationType {
        case Linear
        case EaseIn
        case EaseOut
    }
    
    enum CounterType {
        case Int
        case Float
    }
    
    fileprivate var startNumber: Float = 0.0
    fileprivate var endNumber: Float = 0.0
    fileprivate var progress: TimeInterval!
    fileprivate var duration: TimeInterval!
    fileprivate var lastUpdate: TimeInterval!
    fileprivate var timer: Timer?
    fileprivate var counterType: CounterType!
    fileprivate var counterAnimationType: CounterAnimationType!
    
    fileprivate var currentCounterValue: Float {
        if progress >= duration {
            return endNumber
        }
        
        let percentage = Float(progress / duration)
        let update = updateCounter(counterValue: percentage)
        
        return startNumber + (update * (endNumber - startNumber))
    }
    
    func count(from fromValue: Float,
               to toValue: Float,
               withDuration duration: TimeInterval = 1.5,
               animationType: CounterAnimationType = .EaseOut,
               counterType: CounterType = .Float) {
        
        startNumber = fromValue
        endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        progress = 0
        lastUpdate = Date.timeIntervalSinceReferenceDate
        
        invalidateTimer()
        
        if duration == 0 {
            updateText(value: toValue)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func updateValue() {
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        if progress >= duration {
            invalidateTimer()
            progress = duration
        }
        updateText(value: currentCounterValue)
    }
    
    fileprivate func updateText(value: Float) {
        switch counterType! {
        case .Int:
            self.text = "\(value)"
        case .Float:
            self.text = String(format: "%.2f", value)
        }
    }
    
    fileprivate func updateCounter(counterValue: Float) -> Float {
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, counterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, counterVelocity)
        }
    }
    
    fileprivate func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    

}
