//
//  SnapDetailViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/3/22.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class SnapDetailViewController: UIViewController {
    
    
    var type:NSInteger = 0

    
    lazy var box1 = UIView()
    lazy var box2 = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white        
        showSnap()
    }

    func showSnap()  {
        switch type {
        case 101:
            box1.backgroundColor = UIColor.red
            box2.backgroundColor = UIColor.green
            view.addSubview(box1)
            box1.addSubview(box2)
            box1.snp.makeConstraints({ (make) in
                make.width.height.equalTo(200)
                make.center.equalTo(self.view)
            })
            box2.snp.makeConstraints({ (make) in
                //内距box1边距分别为10、20、30、40
                make.edges.equalTo(box1).inset(UIEdgeInsetsMake(10, 20, 30, 40))
            })
        case 102:
            box1.backgroundColor = UIColor.red
            box2.backgroundColor = UIColor.green
            view.addSubview(box1)
            box1.addSubview(box2)
            box1.snp.makeConstraints({ (make) in
                
                make.width.height.equalTo(200)
                make.center.equalTo(self.view)
            })
            box2.snp.makeConstraints({ (make) in
                
                make.top.equalTo(box1.snp.top).offset(30)       //距离box1 30距离
                make.left.equalTo(box1)             //等效于 make.left.equalTo(box1.snp.left)
                make.right.equalTo(box1)
                make.height.equalTo(30)
                
            })

        case 103:
            box1.backgroundColor = UIColor.red
            box2.backgroundColor = UIColor.green
            view.addSubview(box1)
            view.addSubview(box2)
            box1.snp.makeConstraints({ (make) in
            
                make.left.equalTo(20)      //距离左边20
                make.right.equalTo(-20)    //距离右边20，注意，这里要为负的20
                make.top.equalTo(100)
                make.height.equalTo(50)
            })
            box2.snp.makeConstraints({ (make) in
                
                make.top.equalTo(box1.snp.bottom)      //顶部靠着box1底部
                make.left.right.height.equalTo(box1)    //左右和box1对齐

                
            })

        case 104:
            box1.backgroundColor = UIColor.red
            box2.backgroundColor = UIColor.green
            view.addSubview(box1)
            view.addSubview(box2)
            box1.snp.makeConstraints({ (make) in
                make.width.height.equalTo(100)
                make.left.equalTo(view)
                make.top.equalTo(100)
            })
            box2.snp.makeConstraints({ (make) in
                
                make.size.equalTo(box1)             //大小等于box1
                make.top.equalTo(box1)              //顶部和box1对齐
                make.right.equalTo(view)
                
            })

        case 105:
            box1.backgroundColor = UIColor.red
            box2.backgroundColor = UIColor.green
            view.addSubview(box1)
            view.addSubview(box2)
            box1.snp.makeConstraints({ (make) in
                
                make.size.equalTo(CGSize(width: 200, height: 200))
                make.centerX.equalTo(view)
                make.centerY.equalTo(view).offset(-100)     //中心点为view中心偏上100距离
            })
            box2.snp.makeConstraints({ (make) in
                
                make.size.equalTo(box1).multipliedBy(0.5)   //大小为box1一半
                make.centerX.equalTo(box1)
                make.top.equalTo(box1.snp.bottom).offset(20)
                
            })

        default:
            break
        }
        
        
    }

}
