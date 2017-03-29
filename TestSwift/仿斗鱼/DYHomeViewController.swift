//
//  DYHomeViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/2/9.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import Alamofire

class DYHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let jsonString:String = PublicMethod.getJSONStringFromDictionary(dictionary: ["SystemName":"iOS","TsName":"Student"]) as String
        
//        YJAlamafireHelper.post(urlStr: "http://sign.siva.edu.cn/app1/appVersionInfo.do", params: ["jsonString":jsonString as AnyObject]) { (response) in
//            print(response)
//        }
        

        
//        YJAlamafireHelper.download(urlStr: "https://httpbin.org/image/png") { (data) in
//            DispatchQueue.main.async {
//                
//            }
//        }
    }
    
  
}
