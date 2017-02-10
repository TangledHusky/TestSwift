//
//  CGContextVC.swift
//  TestSwift
//
//  Created by 李亚军 on 16/5/14.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

class CGContextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        // Do any additional setup after loading the view.
        
        let contextView =  CGContextView(frame:CGRect(origin: CGPoint.zero, size: self.view.bounds.size))
        self.view.addSubview(contextView)

     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
