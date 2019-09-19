//
//  TestDownloadingCircleVC.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/5.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

class TestDownloadingCircleVC: UIViewController {

    var loading:YJDownloading! = nil
    var progress:Float = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
     
        addCircle()
        
       
        
     }
    
    func addCircle() {
        loading = YJDownloading(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        loading.center = view.center
        view.addSubview(loading)
        
        
        loading.setProgress(progressNumber: 0.3)
        
        
        let tt = Timer(timeInterval: 1, target: self, selector: #selector(self.updateCircle), userInfo: nil, repeats: true)
        RunLoop.current.add(tt, forMode: RunLoop.Mode.common)

    }
    
    @objc func updateCircle()  {
        progress = progress + 0.1
        loading.setProgress(progressNumber: CGFloat(progress))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    
//    // 1.把两张图片绘制成一张图片
//    func combine(leftImage: UIImage, rightImage: UIImage) -> UIImage {
//        
//        // 1.1.获取第一张图片的宽度
//        let width = leftImage.size.width
//        // 1.2.获取第一张图片的高度
//        let height = leftImage.size.height + rightImage.size.height
//        
//        // 1.3.开始绘制图片的大小
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//        // 1.4.绘制第一张图片的起始点
//        leftImage.draw(at: CGPoint(x: 0, y: 0))
//        // 1.5.绘制第二章图片的起始点
//        rightImage.draw(at: CGPoint(x: 0, y: leftImage.size.height + 5))
//        
//        // 1.6.获取已经绘制好的
//        let imageLong = UIGraphicsGetImageFromCurrentImageContext()
//        // 1.7.结束绘制
//        UIGraphicsEndImageContext()
//        
//        // 1.8.返回已经绘制好的图片
//        return imageLong!
//    }
//    
//    // 1.把多张绘制成一张图片
//    func drawImages(imageArray: [UIImage]) -> UIImage {
//        // 1.1.图片的宽度
//        var width: CGFloat = 0
//        // 1.2.图片的高度
//        var height: CGFloat = 0
//        
//        // 1.3.遍历图片数组里的所有图片
//        for image in imageArray {
//            // 1.3.1.获取每一张图片的宽度
//            width = (image.size.width > width) ? image.size.width : width
//            // 1.3.2.获取每一张图片的高度, 并且相加
//            height += image.size.height
//        }
//        
//        // 1.4.开始绘制图片的大小
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//        
//        // 1.5.设置一个变量用来获取UIImage的Y值
//        var imageY: CGFloat = 0
//        
//        // 1.6.遍历图片的数组
//        for image in imageArray {
//            // 1.6.1.开始绘画图片
//            image.draw(at: CGPoint(x: 0, y: imageY))
//            // 1.6.2.自增每张图片的Y轴
//            imageY += image.size.height
//        }
//        
//        // 1.7.获取已经绘制好的图片
//        let drawImage = UIGraphicsGetImageFromCurrentImageContext()
//        
//        // 1.8.结束绘制图片
//        UIGraphicsEndImageContext()
//        
//        // 1.9.返回已经绘制的图片
//        return drawImage!
//    }

}
