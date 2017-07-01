//
//  YJSliderViewController.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/15.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

class YJSliderViewController: UIViewController {

    var slider:DBSlider! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setu after loading the view.
        view.backgroundColor = UIColor.black
        
//        slider = YJSlider(frame: CGRect(x: 100, y: 200, width: 200, height: 10))
//        slider.setThumbImage(UIImage(named: "videoSliderIndicator"), for: .normal)
//        slider.addTarget(self, action: #selector(self.changeSlider), for: .valueChanged)
//        view.addSubview(slider)
        
        slider = DBSlider(frame: CGRect(x: 100, y: 300, width: 200, height: 10))
        slider.setThumbImage(UIImage(named: "videoSliderIndicator"), for: .normal)
        slider.addTarget(self, action: #selector(self.changeSlider), for: .valueChanged)
        view.addSubview(slider)

        
        
    }
    
    func changeSlider() {
        print(slider.value)
        
    }

  
}
