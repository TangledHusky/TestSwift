//
//  UIImageExtension.swift
//  TestSwift
//
//  Created by YJ on 2017/3/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import Foundation
import UIKit


extension UIImage{
    
   class func maskImageWithMaskrect(maskRect:CGRect,clearRect:CGRect) -> UIImage {
        UIGraphicsBeginImageContext(maskRect.size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(UIColor.black.cgColor)
        ctx?.setFillColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        ctx?.fill(maskRect)
        ctx?.clear(clearRect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
  
        
    }
    
    
    
    
}
