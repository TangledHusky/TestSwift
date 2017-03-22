//
//  UDPClientViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/3/21.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import CocoaAsyncSocket
class UDPClientViewController: UIViewController {

    static let host = "192.168.123.16"
    static let port = 9090
    
    //服务端和客户端的socket引用
    var clientSocket: GCDAsyncUdpSocket?
    var imageShow:UIImageView! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        clientSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
     
        do{
            try  clientSocket?.bind(toPort: UInt16(UDPClientViewController.port))
            
        }catch{
            print("serverSocket bind port error")
        }
        
        do{
            try clientSocket?.beginReceiving()
            print("beginReceiving success")
        }catch{
            print("serverSocket beginReceiving error")
        }
        clientSocket?.setMaxReceiveIPv4BufferSize(uint_fast16_t.max)
        clientSocket?.setMaxReceiveIPv6BufferSize(uint.max)
        

        
        imageShow = UIImageView(frame: CGRect(x: 0, y: 200, width: KScreenWidth, height: 200))
        imageShow.image = UIImage(named: "test")
        view.addSubview(imageShow)
        
//        let pathtemp = Bundle.main.path(forResource: "35k", ofType: "png")
//        if let imgDatatemp = NSData(contentsOf: NSURL(fileURLWithPath: pathtemp!) as URL){
//            imageShow.image = UIImage(data: imgDatatemp as Data)
//        }
 

        
        /*
         1、图片大于9k  不会触发didSendDataWithTag，会失败，直接close连接
         2、文字、图片转data后小于9k都可以
         
         */
        print("start send image")
        
//        let path = Bundle.main.path(forResource: "8k", ofType: "png")      //8k 可以
        let path = Bundle.main.path(forResource: "35k", ofType: "png")            //35k no
//        let path = Bundle.main.path(forResource: "test", ofType: "jpeg")      //1.1M no
        
        
        
        if let imgData = NSData(contentsOf: NSURL(fileURLWithPath: path!) as URL){
            clientSocket?.send(imgData as Data, toHost: UDPClientViewController.host, port: UInt16(UDPClientViewController.port), withTimeout: -1, tag: 0)
            print("send it")
        }else{
            print("imgdata error")
        }
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clientSocket?.close()
    }
    

}

extension UDPClientViewController:GCDAsyncUdpSocketDelegate{
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("发送信息成功")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
        print("发送信息失败")
        
    }
    
    
    /// 只要开始添加了 beginreceiving  这里就可以检测到（这里我就在一个里面实现了 send 并 接收显示）
    ///
    /// - Parameters:
    ///   - sock: <#sock description#>
    ///   - data: <#data description#>
    ///   - address: <#address description#>
    ///   - filterContext: <#filterContext description#>
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        print("接收到\(address)的消息")
        
        if let img = UIImage(data: data){
            imageShow.image = img
        }else{
            print("data  error")
        }

        
    }
    
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print("udp close:\(error?.localizedDescription)")
    }
}
