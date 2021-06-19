//
//  CountDownTimer.swift
//  NetSpider
//
//  Created by 薄海硕 on 2021/4/5.
//  Copyright © 2021 David硕. All rights reserved.
//

import UIKit

class CountDownTimer: NSObject {

    public private(set) var countDownInterval: TimeInterval = 0
    public private(set) var isRepeat: Bool = false
    public private(set) var isPerformInAdvance: Bool = false
    
    private var onTick: () -> Void
    private var isContinuePerform: Bool = false
    private let syncLockQueue = DispatchQueue(label: "ai.util.countdown.timer.lock")
    
    init(
        countDownInterval: TimeInterval,
        isRepeat: Bool = false,
        isPerformInAdvance: Bool = false,
        onTick: @escaping () -> Void
    ) {
        self.countDownInterval = countDownInterval
        self.isRepeat = isRepeat
        self.isPerformInAdvance = isPerformInAdvance
        self.onTick = onTick
    }
    
    private func repeatPerform() {
        DispatchQueue.main.asyncAfter(deadline: .now() + countDownInterval) { [weak self] in
            guard let `self` = self else { return }
            
            if self.isContinuePerform {
                self.onTick()
            }
            
            if self.isRepeat {
                self.repeatPerform()
            }
        }
    }
    
    @discardableResult
    func start() -> Self {
        if isPerformInAdvance {
            self.onTick()
        }
        syncLockQueue.sync {
            self.isRepeat = isRepeat
            self.isContinuePerform = true
            self.repeatPerform()
        }
        return self
    }
    
    func stop() {
        syncLockQueue.sync {
            self.isContinuePerform = false
            self.isRepeat = false
        }
    }
}
