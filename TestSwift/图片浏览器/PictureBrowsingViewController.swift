//
//  PictureBrowsingViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2016/12/14.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

class PictureBrowsingViewController: UIViewController {

    var _srcStringArray:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        _srcStringArray = [                        "http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                                                    "http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                                                     "http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                                                      "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                                                       "http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                                                        "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                                                         "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                                                          "http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                                                           "http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"]
        
        
        self.loadPics()
        

        
    }

    
    func loadPics() {
        var pics:[HZPhotoItem] = []
        
        for obj in _srcStringArray {
            let item = HZPhotoItem()
            item.thumbnail_pic = obj
            pics.append(item)
        }
        
        let photoView = HZPhotoGroup(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeight-64))
        photoView.photoItemArray = pics
        self.view.addSubview(photoView)
    }

}
