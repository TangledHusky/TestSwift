//
//  DYHomeViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/2/9.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

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

        
        goAlamofire()
    }
    
    
    func goAlamofire()  {
        
    
            YJRequestManager.share.GET(url: "http://api.product.kai12.cn/v1/update/whitelist", param: nil, success: { (response) in
                let model = AuthorAreaListModel(JSON: response)
                print(model)
                
            }) { (errorMsg) in
                print(errorMsg)
            }
        
    }
    
    
  
}
