//
//  PlayGifVC.swift
//  TestSwift
//
//  Created by 李亚军 on 16/7/5.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

class PlayGifVC: UIViewController {
    
    var loadingImg:UIImageView?
    
    var sege:UISegmentedControl! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        sege = UISegmentedControl(items: ["sd_webimage","webview","GifView"])
        sege.frame = CGRect(x: 0, y: 65, width: KScreenWidth, height: 30)
        sege.setTitle("sd_webimage", forSegmentAt: 0)
        sege.setTitle("webview", forSegmentAt: 1)
        sege.setTitle("GifView", forSegmentAt: 2)
        
        sege.selectedSegmentIndex = 0
        self.view.addSubview(sege)
        sege.addTarget(self, action: #selector(self.addGif), for: .valueChanged)
        
        addGif()
    }
    
    func addGif() {
        for v in self.view.subviews {
            if v.isKind(of: UISegmentedControl .classForCoder()) {
                continue
            }
            v.removeFromSuperview()
        }
        
        let imgData:Data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "1533461388039947", ofType: ".gif")!))
        
        switch sege.selectedSegmentIndex {
        case 0:
            //sd_webimage   加载
            loadingImg = UIImageView(frame: CGRect(x: (KScreenWidth-200)/2, y: 100, width:200 , height: 200))
            loadingImg?.image = UIImage.sd_animatedGIF(with: imgData)
            self.view.addSubview(loadingImg!)
            print("sd_webimage")

        case 1:
            //webview加载
            let webv = UIWebView(frame: CGRect(x: 0, y: 100, width: KScreenWidth, height: 200))
            webv.load(imgData, mimeType: "image/gif", textEncodingName: "", baseURL: URL(string: "")!)
            self.view.addSubview(webv)
            print("webview")
        default:
           
            let gifV:GifView = GifView(frame: CGRect(x: (KScreenWidth-200)/2, y: 100, width: 200, height: 200), data: imgData)
            self.view.addSubview(gifV)
            print("GifView")
          
        }
       
        
        
        
        
       
        
    }

}
