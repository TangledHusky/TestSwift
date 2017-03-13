//
//  CommonTestViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/3/10.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class CommonTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        //应用内实现粘贴，这个txt用来测试的
        let txt = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 33))
        txt.backgroundColor = UIColor.yellow
        txt.placeholder = "shuru"
        view.addSubview(txt)

        
        //1.测试剪切板
        testPasteBoard(str: "123")
        
        
    }

    
    /// 测试剪切板，实现代码拷贝内容
    /// 结论：应用程序内可实现长按输入框后，粘贴，应用程序外依然可以。
    func testPasteBoard(str:String) {
        
        //就这两句话就实现了
        let paste = UIPasteboard.general
        paste.string = str
        
       
    }
}
