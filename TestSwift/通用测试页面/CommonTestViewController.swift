//
//  CommonTestViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/3/10.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class CommonTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        

        
        //1.测试剪切板
//        testPasteBoard(str: "123")
    
        //1.测试字符串截取
        testSubbstring()
        
        //1.测试label字符间距
        testUILabelMargin()
        
        
    }

    
    /// 测试剪切板，实现代码拷贝内容
    /// 结论：应用程序内可实现长按输入框后，粘贴，应用程序外依然可以。
    func testPasteBoard(str:String) {
        //应用内实现粘贴，这个txt用来测试的
        let txt = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 33))
        txt.backgroundColor = UIColor.yellow
        txt.placeholder = "shuru"
        view.addSubview(txt)

        //就这两句话就实现了
        let paste = UIPasteboard.general
        paste.string = str
        
       
    }
    
    
    ///  测试-截取字符串
    func testSubbstring() {
        var str = "12345678"
        let length = str.characters.count

        //截取前四位
        let sub1 = str.substring(to: str.index(str.startIndex, offsetBy: 4))
        
        //截取后2位（两种方法）
        let sub2 = str.substring(from: str.index(str.startIndex, offsetBy: length-2))
        let sub3 = str.substring(from: str.index(str.endIndex, offsetBy: -2))
        

        
        //截取中间4位，从第2位开始(二种方法)
        let start1 = str.index(str.startIndex, offsetBy: 2)
        str = str.substring(from: start1)  //取到从第2位开始的所有字符
        let end1 = str.index(str.startIndex, offsetBy: 4)
        let sub5 = str.substring(to: end1)   //从新的字符开始取4位
        
        //截取中间4位，从第2位开始
        let start = str.index(str.startIndex, offsetBy: 2)
        let end = str.index(str.endIndex,offsetBy:-(length - 6))
        let sub4 = str.substring(with: start..<end)
        
        print(sub1)
        print(sub2)
        print(sub3)
        print(sub4)
        print(sub5)
        
    }
    
    /// 测试label字符间距
    func testUILabelMargin() {
        let lblTitle2 = UILabel(frame: CGRect(x: 10, y: 250, width: KScreenWidth-20, height: 100))
        lblTitle2.textColor = UIColor.red
        lblTitle2.backgroundColor = UIColor.lightGray
        lblTitle2.textAlignment = .center
        lblTitle2.numberOfLines = 0
        lblTitle2.font = UIFont.systemFont(ofSize: 12)
        lblTitle2.text = "SDCycleScrollView之前一直在OC中使用觉得很简单又熟悉了所以这次写的Demo依旧搬了过来"
        self.view.addSubview(lblTitle2)
        
        let lblTitle = UILabel(frame: CGRect(x: 10, y: 150, width: KScreenWidth-20, height: 100))
        lblTitle.textColor = UIColor.white
        lblTitle.backgroundColor = UIColor.darkGray
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 0
        lblTitle.font = UIFont.systemFont(ofSize: 12)
        lblTitle.text = "SDCycleScrollView之前一直在OC中使用觉得很简单又熟悉了所以这次写的Demo依旧搬了过来.SDCycleScrollView之前一直在OC中使用觉得很简单又熟悉了所以这次写的Demo依旧搬了过来."
        self.view.addSubview(lblTitle)

        let attrStr = NSMutableAttributedString(string: lblTitle.text!)
        //设置行间距
        let style:NSMutableParagraphStyle  = NSMutableParagraphStyle()
        style.lineSpacing = 10              //行间距（垂直上的间距）
        style.lineBreakMode = .byCharWrapping       //英文字符拆开显示，byWordWrapping表示不拆开显示
        style.alignment = .center           //居中显示（如果要设置alignment，这个必须设置，因为label的textAlignment会无效）
        style.firstLineHeadIndent = 25.0    //设置首行字符缩进距离
        style.headIndent = 5                //每行的左右间距
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: (lblTitle.text?.characters.count)!))
        //设置字间距
        attrStr.addAttribute(NSKernAttributeName, value: 1.5, range: NSRange(location: 0, length: (lblTitle.text?.characters.count)!))
        lblTitle.attributedText = attrStr
        
    }
}
