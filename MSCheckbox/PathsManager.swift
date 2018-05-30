//
//  CheckboxPaths.swift
//  bitlish
//
//  Created by Margarita Shishkina on 29/05/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

class PathsManager {
    var size: CGSize
    var lineWidth: CGFloat
    var cornerRadius: CGFloat

    init(size: CGSize, lineWidth: CGFloat, cornerRadius: CGFloat) {
        self.size = size
        self.lineWidth = lineWidth
        self.cornerRadius = cornerRadius
    }

    func pathForRect() -> UIBezierPath {
        let w = size.width
        let h = size.height
        let rect = CGRect(x: lineWidth/2, y: lineWidth/2, width: w - lineWidth, height: h - lineWidth)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.lineWidth = lineWidth
        return path
    }

    func pathForCheck() -> UIBezierPath {
        let w = size.width
        let h = size.height
        let point1 = CGPoint(x: w/4, y: h/2)
        let point2 = CGPoint(x: w/2, y: (h/3)*2)
        let point3 = CGPoint(x: (w/4)*3, y: h/3)

        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.lineWidth = lineWidth
        return path
    }
}
