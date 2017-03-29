//
//  AnimationTextVC.swift
//  TestSwift
//
//  Created by YJ on 16/7/5.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

class AnimationTextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black

        // Do any additional setup after loading the view.
        
        let txt:BSCycleTextView = BSCycleTextView(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        txt.text = "wsdkjdksnskfkdnfdfdfdfndkfnk"
        txt.timeInterval = 2
        txt.textColor = UIColor.white
        self.view.addSubview(txt)
        
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
