//
//  ViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 16/5/4.
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
        
        
        popMenu =  SwiftPopMenu(frame: CGRect(x: 230, y: 44, width: 140, height: 100))
        
        
        popMenu.popData = [(icon:"",title:"sdddf"),(icon:"",title:"23344")]
        popMenu.show()
        
 

    }


}

extension PoPMenuViewController : SwiftPopMenuDelegate{
    func swiftPopMenuDidSelectIndex(index: Int) {
        print(" xuan zhong \(index)")
        popMenu.dismiss()
    }
}

