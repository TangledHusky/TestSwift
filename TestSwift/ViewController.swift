//
//  ViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/2/9.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    let cellID:String = "homeCellID"
    
    lazy var dataArry:[String] = ["alamofire测试",
                                  "图片浏览器",
                                  "圆角与裁剪的测试",
                                  "广告轮播",
                                  "Label文字跑马灯",
                                  "PopView－边角弹出箭头框",
                                  "播放Gif",
                                  "CGContext－直线、虚线、圆",
                                  "侧边固定滑动效果",
                                  "通用测试----",
                                  "二维码扫描",
                                  "UDP发图片-测试data大于9k接受不了",
                                  "SnapKit布局",
                                  "RxSwift-登录界面",
                                  "RxSwift-列表",
                                  "测试Pad-UIPopoverController",
                                  "测试Pad-UISplitController",
                                  "环形下载进度条",
                                  "UISlider触摸区域放大",
                                  "多任务下载",
                                  "批量上传图片",
                                  "测试HandyJSON",
                                  "VLC播放器",
        
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
        
        
        print(ss)
        print(aa)
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
            let vc = DYHomeViewController()
            vc.navigationItem.title=dataArry[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
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
            let vc = ScrollViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 9:
            let vc = CommonTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 10:
            let vc = QRCodeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 11:
            let vc = UDPClientViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 12:
            let vc = SnapKitViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 13:
            let sb = UIStoryboard(name: "RxSwift", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RxSwiftLoginViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 14:
            let vc = RxSwiftTableviewVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 15:
            let vc = TestPadViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 16:
            let vc = RxSwiftTableviewVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 17:
            let vc = TestDownloadingCircleVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 18:
            let vc = YJSliderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break

        case 19:
            let vc = BigFileDownloadViewController(nibName: "BigFileDownloadViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 20:
            let vc = BatchUploadPicViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 21:
            let vc = TestHandyJSONViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 22:
//            let vc = TestVLCViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
            
            break

            
        default:
            break
        }
            
            
            
    }
}

