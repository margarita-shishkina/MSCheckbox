//
//  Checkbox.swift
//  bitlish
//
//  Created by Margarita Shishkina on 25/05/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

@IBDesignable public class MSCheckbox: UIControl {
    @IBInspectable public var lineWidth: CGFloat = 1 { didSet {
        pathsManager.lineWidth = lineWidth
        self.setNeedsDisplay()
    } }
    @IBInspectable public var cornerRadius: CGFloat = 0 { didSet {
        pathsManager.cornerRadius = cornerRadius
        self.setNeedsDisplay()
    } }
    @IBInspectable public var checkColor: UIColor? = nil { didSet { self.setNeedsDisplay() } }
    @IBInspectable public var fillColor: UIColor = .clear { didSet { self.setNeedsDisplay() } }
    @IBInspectable public var borderColor: UIColor = .lightGray { didSet { self.setNeedsDisplay() } }

    private var _on = false
    @IBInspectable public var on: Bool {
        get {
            return _on
        } set {
            _on = newValue
            self.setNeedsDisplay()
        }
    }

    public override var intrinsicContentSize: CGSize { return CGSize(width: 18, height: 18) }

    private var pathsManager: PathsManager!
    private var animationManager: AnimationManager!

    fileprivate let boxOnLayer = CAShapeLayer()
    fileprivate let boxOffLayer = CAShapeLayer()
    fileprivate let checkLayer = CAShapeLayer()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    private func commonInit() {
        pathsManager = PathsManager(size: frame.size, lineWidth: lineWidth, cornerRadius: cornerRadius)
        animationManager = AnimationManager(duration: 0.25)
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        _setOn(on: on, animated: false)
    }

    public override func layoutSubviews() {
        pathsManager.size = frame.size
        super.layoutSubviews()
    }

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        _on = !_on
        _setOn(on: on, animated: true)
        self.sendActions(for: .valueChanged)
        return true
    }

    public func setOn(on: Bool, animated: Bool) {
        if _on == on { return }
        _on = on
        _setOn(on: on, animated: animated)
    }

    private func _setOn(on: Bool, animated: Bool) {
        if on {
            drawBoxOn()
            drawCheck()
            boxOffLayer.removeFromSuperlayer()
            if animated {
                let animation = animationManager.strokeAnimation()
                animation.delegate = self
                self.checkLayer.add(animation, forKey: "strokeEnd")
            }
        } else {
            drawBoxOff()
            if animated {
                let animation = animationManager.opacityAnimation()
                animation.delegate = self
                boxOnLayer.add(animation, forKey: "opacity")
                checkLayer.add(animation, forKey: "opacity")
            } else {
                boxOnLayer.removeFromSuperlayer()
                checkLayer.removeFromSuperlayer()
            }
        }
    }

    private func drawBoxOn() {
        let path = pathsManager.pathForRect()
        boxOnLayer.removeFromSuperlayer()
        boxOnLayer.path = path.cgPath
        boxOnLayer.fillColor = fillColor.cgColor
        boxOnLayer.lineWidth = lineWidth
        self.layer.addSublayer(boxOnLayer)
    }

    private func drawBoxOff() {
        let path = pathsManager.pathForRect()
        boxOffLayer.removeFromSuperlayer()
        boxOffLayer.path = path.cgPath
        boxOffLayer.strokeColor = borderColor.cgColor
        boxOffLayer.fillColor = nil
        boxOffLayer.lineWidth = lineWidth
        self.layer.addSublayer(boxOffLayer)
    }

    private func drawCheck() {
        let path = pathsManager.pathForCheck()
        checkLayer.removeFromSuperlayer()
        checkLayer.path = path.cgPath
        checkLayer.strokeColor = (checkColor ?? tintColor).cgColor
        checkLayer.fillColor = nil
        checkLayer.lineJoin = kCALineJoinRound
        checkLayer.lineCap = kCALineCapRound
        checkLayer.lineWidth = lineWidth
        self.layer.addSublayer(checkLayer)
    }
}

extension MSCheckbox: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if !self.on {
                self.boxOnLayer.removeFromSuperlayer()
                self.checkLayer.removeFromSuperlayer()
            }
        }
    }
}
