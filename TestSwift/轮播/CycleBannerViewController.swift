//
//  CycleBannerViewController.swift
//  TestSwift
//
//  Created by YJ on 2016/12/12.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit
import SDCycleScrollView

class CycleBannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
        //https://github.com/gsdios/SDCycleScrollView
        
        let url = "http://f.hiphotos.baidu.com/image/pic/item/203fb80e7bec54e753da379aba389b504fc26a7b.jpg"
        let banner = SDCycleScrollView(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: 200), delegate: self, placeholderImage: UIImage(named: "default_lunbo"))
        banner?.imageURLStringsGroup = [url,url,url,url]
        banner?.titlesGroup = ["我是第1张图片","我是第2张图片","我是第3张图片","我是第4张图片"]
        banner?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        self.view.addSubview(banner!)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension CycleBannerViewController:SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("dianjile \(index)")
    }
}
