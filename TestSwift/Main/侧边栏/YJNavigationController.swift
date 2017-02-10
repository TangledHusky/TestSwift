//
//  YJViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2016/12/14.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit
import ENSwiftSideMenu


class YJNavigationController: ENSideMenuNavigationController,ENSideMenuDelegate {

    var blurView : UIView!
    var destController : UIViewController!
    
    var showSideMenu : Bool = true
    
    var menuWidth:CGFloat = 180
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MyRightMenuViewController(), menuPosition:.Right)
        
        sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = menuWidth // optional, default is 160
        sideMenu?.bouncingEnabled = false
        sideMenu?.allowPanGesture = false
        
        view.bringSubview(toFront: navigationBar)
        
        
        blurView = UIView()
        blurView.backgroundColor = UIColor.clear
        blurView.frame = CGRect(origin: CGPoint(x: 0, y: 64), size: CGSize(width: KScreenWidth-menuWidth, height: KScreenHeight - 64))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeSideMenu))
        blurView.addGestureRecognizer(tapGestureRecognizer)
        
        
        
    }
    
    func closeSideMenu(){
        sideMenu?.toggleMenu()
    }


    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    
        var frame = self.blurView.frame
        self.view.addSubview(blurView)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            frame.size.width = KScreenWidth - (self.sideMenu?.menuWidth)!
            self.blurView.frame = frame
            self.blurView.backgroundColor = UIColor.black
            self.blurView.alpha = 0.3
            
        }) 
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.blurView.alpha = 0
            self.blurView.frame = CGRect(origin: CGPoint(x: 0, y: 64), size: CGSize(width: KScreenWidth, height: KScreenHeight - 64))
            },completion: { (finished) -> Void in
                self.blurView.removeFromSuperview()
        })
        

    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }

    func sideMenuShouldOpenSideMenu() -> Bool {
        return showSideMenu
    }

}
