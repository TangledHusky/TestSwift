//
//  QRCodeGenerateViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/3/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class QRCodeGenerateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 33))
        btn.setTitle("生成二维码", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(self.generate), for: .touchUpInside)
        view.addSubview(btn)
        
    }
    
    func generate() {
        let img = self.creatQRCodeImage(text: "123", WH: 100)
        let imgView = UIImageView(frame: CGRect(x: 100, y: 150, width: 100, height: 100))
        imgView.image = img
        view.addSubview(imgView)
        
        
        
    }
    
    
    //MARK: 传进去字符串,生成二维码图片(>=iOS7)  text：要生成的二维码内容   WH：二维码高宽
    private func creatQRCodeImage(text: String,WH:CGFloat) -> UIImage{
        
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        //还原滤镜的默认属性
        filter?.setDefaults()
        //设置需要生成二维码的数据
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //从滤镜中取出生成的图片
        let ciImage = filter?.outputImage
        //这个清晰度好
        let bgImage = createNonInterpolatedUIImageFormCIImage(image: ciImage!, size: WH)
        
        return bgImage
    }
    //MARK: - 根据CIImage生成指定大小的高清UIImage
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = image.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)
        
        let width = extent.width * scale
        let height = extent.height * scale
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        let scaledImage: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: scaledImage)
    }
    
    //MARK: - 根据背景图片和头像合成头像二维码
    private func creatIconImage(iconImage:UIImage,sizeWH:CGFloat,superImgView:UIImageView){
        
        let iconImgView = UIImageView(image: iconImage)
        iconImgView.contentMode = .scaleAspectFit
        iconImgView.frame = CGRect(x: (superImgView.bounds.size.width-sizeWH)/2, y: (superImgView.bounds.size.height-sizeWH)/2, width: sizeWH, height: sizeWH)
        iconImgView.layer.cornerRadius = 5
        iconImgView.layer.borderColor = UIColor.white.cgColor
        iconImgView.layer.borderWidth = 4
        iconImgView.layer.masksToBounds = true
        superImgView.addSubview(iconImgView)
        
    }

}
