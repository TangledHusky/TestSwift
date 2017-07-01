//
//  YJDownloadProgress.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/20.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

class YJDownloadProgress: UIView {
    
    var lineColor:UIColor = UIColor.red
    
    var lineRadius:CGFloat = 2
    
    

    /// 自定义下载进度条，也可以用UIProgressView做
    ///
    /// - Parameter frame: <#frame description#>
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = lineRadius
        initViews()
    }
    
    
    var lineLayer :CAShapeLayer! = nil
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    func initViews()  {
        
        lineLayer = CAShapeLayer()
        lineLayer.frame = CGRect(x: 0, y: 0, width: 0, height: self.bounds.height)

        lineLayer.cornerRadius = lineRadius
        lineLayer.backgroundColor = lineColor.cgColor
        self.layer.addSublayer(lineLayer)
        
        
    }
    
    
    func setProgress(progress:CGFloat) {
        lineLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width*(progress/1.0), height: self.bounds.height)

    }

}
