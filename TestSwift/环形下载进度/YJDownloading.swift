//
//  YJDownloading.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/5.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

class YJDownloading: UIView {
    
    var layerBg:CAShapeLayer! = nil
    var layerShow:CAShapeLayer! = nil
    
    //进度圈背景色
    var circleBgColor:UIColor = UIColor.colorWithHex(hex: "FF3B30")
    //进度圈当前色
    var circleColor:UIColor = UIColor.colorWithHex(hex: "FF3B30")
    //进度圈背景线宽度
    var circleBgWidth:CGFloat = 1
    //进度圈当前线宽度
    var circleColorWidth:CGFloat = 2.5

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initViews() {
        backgroundColor = UIColor.white
        


        
        layerBg = CAShapeLayer()
        let bezierBg = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        layerBg.strokeColor = circleBgColor.cgColor
        layerBg.fillColor = UIColor.clear.cgColor
        layerBg.path = bezierBg.cgPath
        layerBg.lineWidth = circleBgWidth
        layerBg.lineCap = kCALineCapRound
        self.layer.addSublayer(layerBg)
        
        
        layerShow = CAShapeLayer()
        let bezierShow = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.size.width - circleBgWidth, height: frame.size.height - circleBgWidth))
        layerShow.strokeColor = circleColor.cgColor
        layerShow.fillColor = UIColor.clear.cgColor
        layerShow.path = bezierShow.cgPath
        layerShow.lineWidth = circleColorWidth
        layerShow.lineCap = kCALineCapRound
        self.layer.addSublayer(layerShow)

        //zhong
        let lblCenter = UILabel(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        lblCenter.center = self.center
        lblCenter.backgroundColor = circleColor
        lblCenter.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI_2))
        self.addSubview(lblCenter)
        
        //旋转-90度，使进度起点为12点钟的位置：
        self.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        
    }
    
    func setProgress(progressNumber:CGFloat) {
        if layerShow != nil {
            layerShow.strokeEnd = progressNumber
        }
        
        
    }
    
    
}
