//
//  ViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/2/9.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    let cellID:String = "homeCellID"
    
    lazy var dataArry:[String] = ["仿斗鱼",
                                  "图片浏览器",
                                  "圆角与裁剪的测试",
                                  "广告轮播",
                                  "Label文字跑马灯",
                                  "PopView－边角弹出箭头框",
                                  "播放Gif",
                                  "CGContext－直线、虚线、圆",
                                  ""
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "YJ的测试Demo"
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
        
    }


}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = dataArry[indexPath.row]
        
        return cell!
        
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
            
        case 1:
            
            let vc = PictureBrowsingViewController()
            vc.navigationItem.title=dataArry[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            
            let vc=CornerRadiusViewController()
            vc.navigationItem.title=dataArry[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc=CycleBannerViewController()
            vc.navigationItem.title=dataArry[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc=AnimationTextVC()
            vc.navigationItem.title=dataArry[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        
        case 5:
            let vc = PoPMenuViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = PlayGifVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = CGContextVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            break
            
        default:
            break
        }
            
            
            
    }
}

