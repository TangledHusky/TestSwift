//
//  YJSlider.swift
//  k12_sl_iOS
//
//  Created by liyajun on 2017/4/14.
//
//

import UIKit

class YJSlider: UISlider {

   
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        //bounds.origin.x, bounds.origin.y, 10, 15
        print("thumbRect:\(bounds)-\(rect)-\(value)")
        
        super .thumbRect(forBounds: bounds, trackRect: rect, value: value)
        let margin:CGFloat = 110
        
        return CGRect(x: bounds.origin.x-margin, y: bounds.origin.y-margin, width: margin*2, height: margin*2); // w 和 h 是滑块可触摸范围的大小，跟通过图片改变的滑块大小应当一致。
        
        
//        rect.origin.y = rect.origin.y - 10;
//        rect.size.height = rect.size.height + 20;
//        return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 ,10);
        
    }

}
