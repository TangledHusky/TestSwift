//
//  TestPadViewController.swift
//  TestSwift
//
//  Created by liyajun on 2017/3/29.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

class TestPadViewController: UIViewController {

    var popOver:UIPopoverController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "必须用pad模拟器或pad测试"
        
        let popVC = TestPopoverViewController()
        popVC.delegate = self       //代理为了点击内部的处理事件
        
        //添加contentview子视图，大小建议在子视图内部设置
        popOver = UIPopoverController(contentViewController: popVC)
        popOver.delegate = self
        
        //设置pop背景色，一般是为了和里面的content背景色一致，不然默认情况下会造成色差
        popOver.backgroundColor = UIColor.white
        
        //哪些控件可以继续跟用户进行正常交互。这样的话，点击区域外的控件就不会让UIPopoverController消失了
        //popOver.passthroughViews = [view]   //这句话加上后，点击蒙版，pop就不会消失，因为设置了view的交互可用
        
        //导航点击弹出
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.testNavPop))
        
        //按钮点击弹出
        testBtnPop()
        
    }
    
    @objc func testNavPop() {
        popOver.present(from: self.navigationItem.leftBarButtonItem!, permittedArrowDirections: .any, animated: true)

    }
    
    
    func testBtnPop()  {
        
        let btn1 = UIButton(frame: CGRect(x: 0, y: 170, width: KScreenWidth, height: 25))
        btn1.tag = 101
        btn1.backgroundColor = UIColor.getRandomColor()
        btn1.setTitle("从按钮处pop", for: .normal)
        btn1.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
        view.addSubview(btn1)

    }
    
    /// 在按钮弹出
    @objc func btnClick(sender:UIButton) {
        //这种是紧靠着按钮位置弹出
        //popOver.present(from: sender.bounds, in: sender, permittedArrowDirections: .any, animated: true)
        
        //自定义弹出位置，比如这里我设置y上面间隔20
        popOver.present(from: CGRect(x: sender.bounds.origin.x, y: sender.bounds.origin.y+20, width: sender.bounds.size.width, height: sender.bounds.size.height), in: sender, permittedArrowDirections: .any, animated: true)
        
    }

  
}

/// popover代理
extension TestPadViewController:UIPopoverControllerDelegate{
    //popoverController消失的时候调用
    func popoverControllerDidDismissPopover(_ popoverController: UIPopoverController) {
        print("popoverControllerDidDismissPopover")
    }
    
    //popoverController的位置改变的时候调用（如竖屏变横屏）
    func popoverController(_ popoverController: UIPopoverController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        print("willRepositionPopoverTo")
    }
    
    //用来决定用户点击了蒙版后，popoverController是否可以dismiss,返回YES代表可以，返回NO代表不可以
    func popoverControllerShouldDismissPopover(_ popoverController: UIPopoverController) -> Bool {
        return true
    }
}

/// popover容器内点击事件的代理
extension TestPadViewController:TestPopoverViewControllerDelegate{
    internal func TestPopoverViewControllerDidSelect(index: NSInteger) {
        popOver.dismiss(animated: true)
        print("click \(index)")
    }

    
}
