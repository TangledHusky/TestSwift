//
//  ViewController.swift
//  TestSwift
//
//  Created by YJ on 16/5/4.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit
import SwiftPopMenu

class PoPMenuViewController: UIViewController {

    
    //数据tableview
    var tableview:UITableView?=nil
    
    var popMenu:SwiftPopMenu!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
               
        self.view.backgroundColor = UIColor.white
        
        let config = [SwiftPopMenuConfigure.popMenuAlpha(0.4)]
        popMenu = SwiftPopMenu(menuWidth: 150, arrow: CGPoint(x: 100, y: 100), datas: [(icon:"",title:"sdddf"),(icon:"",title:"23344")])
        popMenu.show()
        
 

    }


}

extension PoPMenuViewController : SwiftPopMenuDelegate{
    func swiftPopMenuDidSelectIndex(index: Int) {
        print(" xuan zhong \(index)")
        popMenu.dismiss()
    }
}

