//
//  BatchUploadPicViewController.swift
//  TestSwift
//
//  Created by liyajun on 2017/5/2.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit
import AFNetworking

class BatchUploadPicViewController: UIViewController {
    
    var images = [UIImage(named: "1.png"),UIImage(named: "1.png"),UIImage(named: "1.png"),UIImage(named: "1.png"),UIImage(named: "1.png")]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 33))
        btn.setTitle("上传图片", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(self.batchUpload(sender:)), for: .touchUpInside)
        view.addSubview(btn)
        
        //AFNetworking 3  上传图片
        
        
    }
    
    

    @objc func batchUpload(sender:UIButton) {
        
        let group = DispatchGroup()
        
        let result = NSMutableArray()
        for _ in images {
            result.add(NSNull.init())
        }
        
     
        
        group.notify(queue: DispatchQueue.main) { 
            print("上传完成")
        }
        
        
    }

  

}


