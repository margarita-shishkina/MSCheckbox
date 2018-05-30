//
//  CheckboxAnimationManager.swift
//  bitlish
//
//  Created by Margarita Shishkina on 29/05/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

class AnimationManager {
    let duration: CFTimeInterval

    init(duration: CFTimeInterval) {
        self.duration = duration
    }

    func strokeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.isRemovedOnCompletion = true
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animation
    }

    func opacityAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 1
        animation.toValue = 0
        animation.isRemovedOnCompletion = true
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animation
    }
}
