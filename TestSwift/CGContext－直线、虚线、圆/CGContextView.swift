//
//  CGContext.swift
//  TestSwift
//
//  Created by YJ on 16/5/14.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

class CGContextView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor=UIColor.gray
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context=UIGraphicsGetCurrentContext()
        
        //直线
        context!.beginPath()
        context!.setLineWidth(3)
        context!.move(to: CGPoint(x: 100, y: 100))
        context!.addLine(to: CGPoint(x: 200, y: 200))
        context!.setStrokeColor(UIColor.red.cgColor)
        context!.strokePath()

        //虚线
        let lengths: [CGFloat] = [3 * 3, 1 * 3]
        context?.setLineDash(phase: 0, lengths: lengths)
        context!.move(to: CGPoint(x: 100, y: 120))
        context!.addLine(to: CGPoint(x: 200, y: 220))
        context!.setStrokeColor(UIColor.red.cgColor)
        context!.strokePath()
        
        //椭圆
        let rect = CGRect(x: 100, y: 200, width: 200, height: 50)
        context!.setLineWidth(5)
        context!.addEllipse(in: rect)
        context!.strokePath()
        
    }

}
