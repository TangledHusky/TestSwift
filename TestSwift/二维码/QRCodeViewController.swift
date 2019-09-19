//
//  QRCodeViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/3/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 33))
        btn.setTitle("生成二维码", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(self.generate), for: .touchUpInside)
        view.addSubview(btn)

        let btnScan = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 33))
        btnScan.setTitle("扫描二维码", for: .normal)
        btnScan.backgroundColor = UIColor.red
        btnScan.addTarget(self, action: #selector(self.scan), for: .touchUpInside)
        view.addSubview(btnScan)

        
    }
    
    @objc func generate() {
        
        let vc = QRCodeGenerateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @objc func scan() {
        let vc = QRCodeScanViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
