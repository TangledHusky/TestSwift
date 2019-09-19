//
//  QRCodeScanViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/3/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScanViewController: UIViewController {
    
    private let scanDescContent = "将二维码放入框内，即可自动扫描"
    
    private let qrcodeWH:CGFloat = 300

    
    //扫描定义属性
    var device:AVCaptureDevice! = nil
    var input:AVCaptureDeviceInput! = nil
    var output:AVCaptureMetadataOutput! = nil
    var session:AVCaptureSession! = nil
    var preview:AVCaptureVideoPreviewLayer! = nil
    
    var line:UIImageView! = nil
    var canOpen:Bool = false
    var timer:Timer? = nil
    var upOrdown:Bool = false
    var num:NSInteger = 0
    
    var scanSuccessview:QRCodeShowInfoView! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        creatBackGroundView()
        creatUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        
        setupCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
        
        
    }
    
    
    /// 背景遮罩层
    func creatBackGroundView() {
        let maskView = UIImageView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
        maskView.image = UIImage.maskImageWithMaskrect(maskRect: maskView.frame, clearRect: CGRect(x: (KScreenWidth-qrcodeWH)/2, y: (KScreenHeight-qrcodeWH)/2, width: qrcodeWH, height: qrcodeWH))
        self.view.addSubview(maskView)
        
        
    }
    
    
    /// 扫描说明内容
    func creatUI() {
        //提示信息
        let lblDesc = UILabel(frame: CGRect(x: 0, y: (KScreenHeight+qrcodeWH)/2, width: KScreenWidth, height: 50))
        lblDesc.text = scanDescContent
        lblDesc.textAlignment = .center
        lblDesc.textColor = UIColor.white
        lblDesc.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(lblDesc)
        
        //扫描背景框
        let bgImg = UIImageView(frame: CGRect(x: (KScreenWidth-qrcodeWH)/2, y: (KScreenHeight-qrcodeWH)/2, width: qrcodeWH, height: qrcodeWH))
        bgImg.image = UIImage(named: "Icon_SaoYiSao")
        view.addSubview(bgImg)
        
        
        //扫描红线
        line = UIImageView(frame: CGRect(x: (KScreenWidth-qrcodeWH)/2, y: (KScreenHeight-qrcodeWH)/2, width: qrcodeWH, height: 12))
        line.image = UIImage(named: "Icon_SaoLine")
        view.addSubview(line)
    }
    
    
    /// 设置扫描参数
    func setupCamera() {
        DispatchQueue.global().async {
            if (self.device == nil){
                self.device = AVCaptureDevice.default(for: AVMediaType.video)//AVCaptureDevice.defaultDevice(withMediaType: AVMediaType.video)
                do{
                    self.input = try AVCaptureDeviceInput.init(device: self.device)
                }catch{
                    print("self.input init error")
                }
                
                self.output = AVCaptureMetadataOutput.init()
                self.output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                self.session = AVCaptureSession.init()
                self.session.canSetSessionPreset(AVCaptureSession.Preset.high)
                if self.session.canAddInput(self.input){
                    self.session .addInput(self.input)
                    self.canOpen = true
                }else{
                    DispatchQueue.main.async {
                        let alert = UIAlertView(title: "提示", message: "打开相机权限", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "设置")
                        alert.show()
                    }
                }
                
                if self.canOpen{
                    if self.session.canAddOutput(self.output){
                        self.session.addOutput(self.output)
                    }
                    // 只支持二维码
                    self.output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                    
                    self.preview = AVCaptureVideoPreviewLayer(session: self.session)
                    self.preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    DispatchQueue.main.async {
                        self.preview.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight)
                        self.view.layer.insertSublayer(self.preview, at: 0)
                    }
                    
                }
                
            }
            if self.canOpen{
                DispatchQueue.main.async {
                    //开启定时器，构造移动动画效果
                    self.timer = Timer(timeInterval: 0.02, target: self, selector: #selector(self.lineAnimation), userInfo: nil, repeats: true)
                    RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
                    //开始采集数据
                    self.session.startRunning()
                }
            }
        }
      
    }
    
    
    /// 扫描框红线移动动画
    @objc func lineAnimation() {
        let scanX:CGFloat = (KScreenWidth-qrcodeWH)/2
        if upOrdown == false{
            num += 1
            line.frame = CGRect(x: scanX, y: (KScreenHeight-qrcodeWH)/2+2*CGFloat(num), width: qrcodeWH, height: 12)
            
            if 2*num >= NSInteger(qrcodeWH)-12{
                upOrdown = true
                line.image = UIImage(named: "Icon_SaoLineOn")
            }
            
        }else{
            
            num += -1
            line.frame = CGRect(x: scanX, y: (KScreenHeight-qrcodeWH)/2+2*CGFloat(num), width: qrcodeWH, height: 12)
            
            if num == 0{
                upOrdown = false
                line.image = UIImage(named: "Icon_SaoLine")
            }

            
        }
        
        
        
    }
    
    
    /// 扫描播放音效
    func playBeep() {
        var sound = kSystemSoundID_Vibrate
        let path = Bundle.main.path(forResource: "QRCodeRead", ofType: "wav")
        if path != nil{
            let error = AudioServicesCreateSystemSoundID(NSURL.fileURL(withPath: path!) as CFURL, &sound)
            if error != kAudioServicesNoError{
                sound = 0
            }
            
        }
        //播放声音
        AudioServicesPlaySystemSound(sound)
        //静音模式下震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
    }
    
    
    /// 扫描结果后，处理二维码
    ///
    /// - Parameter qrcodeString: <#qrcodeString description#>
    func showQRCode(qrcodeString:String)  {
        print(qrcodeString)
        
        if scanSuccessview == nil{
            scanSuccessview = QRCodeShowInfoView(frame: self.view.frame)
        }
        scanSuccessview.setValue(wifiName: "kai12", wifiPwd: "123222")
        self.view.addSubview(scanSuccessview)
        
    }
   
}


// MARK: - 扫描二维码后的代理
extension QRCodeScanViewController:AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var strValue:String = ""
        if metadataObjects.count>0{
            let obj:AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            strValue = obj.stringValue ?? ""
        }
        
        self.session.stopRunning()
        self.timer?.invalidate()
        self.timer = nil
        
        self.playBeep()
        
        self.showQRCode(qrcodeString: strValue)
    }
    
}

extension QRCodeScanViewController:UIAlertViewDelegate{
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0{
            //取消
            self.navigationController?.popViewController(animated: true)
            
        }else if buttonIndex == 1{
            //打开设置
            let url:NSURL = NSURL(string: UIApplication.openSettingsURLString)!
            if UIApplication.shared.canOpenURL(url as URL){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
}
