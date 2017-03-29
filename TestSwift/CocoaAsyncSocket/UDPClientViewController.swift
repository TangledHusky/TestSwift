//
//  UDPClientViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/3/21.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import CocoaAsyncSocket
class UDPClientViewController: UIViewController {

    static let host = "192.168.123.16"
    static let port = 9090
    
    let maxData = 9000  //分片的最大值
    
    var showData:NSMutableData! = nil
    
    
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
        view.addSubview(imageShow)


        
        /*
         1、图片大于9k  不会触发didSendDataWithTag，会失败，直接close连接
         2、文字、图片转data后小于9k都可以
         
         修改GCDAsyncUdpSocket源文件，可以实现发送大于9216的data
         参考：http://www.cnblogs.com/yajunLi/p/6595509.html
         */
        print("start send image")
        
//        let path = Bundle.main.path(forResource: "8k", ofType: "png")      //8k 可以
        let path = Bundle.main.path(forResource: "35k", ofType: "png")            //35k no
//        let path = Bundle.main.path(forResource: "test", ofType: "jpeg")      //1.1M no
        
        
        
        if let imgData = NSData(contentsOf: NSURL(fileURLWithPath: path!) as URL){
//            sendSmall(imgData: imgData)
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
    
    
    /// 将图片数据分片发送
    ///
    /// - Parameter imgData: <#imgData description#>
    func sendSmall(imgData:NSData) {

        let count = imgData.length/maxData
        var temp:Data?
        var startFlag:NSMutableData
        var length = 0
        if count>0 {
            for index in 0...count {
                length = index == count ? imgData.length - index*maxData : maxData
                temp = imgData.subdata(with: NSRange(location: index*maxData, length: length))
               
                //头部加序列号
                let str = getMaxLength(str: "flag\(index)-\(count)")
                startFlag = NSMutableData(data: str.data(using: .utf8)!)
   
                //序号和正文用\r\n分割
                //startFlag.append(GCDAsyncSocket.crlfData())
                startFlag.append(temp! as Data)
                clientSocket?.send(startFlag as Data, toHost: UDPClientViewController.host, port: UInt16(UDPClientViewController.port), withTimeout: -1, tag: 0)
                
              
                
            }
            
            
        }else{
            clientSocket?.send(imgData as Data, toHost: UDPClientViewController.host, port: UInt16(UDPClientViewController.port), withTimeout: -1, tag: 0)

        }
      
    
    
    }
    
    func getMaxLength(str:String) -> String {
        var result:String = str
        
        if str.characters.count<10 {
            let len = 10 - str.characters.count
            for _ in 0..<len {
                result.append("a")
            }
        }
        print(result)
        return result
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

        //测试直接显示的代码
        if let img = UIImage(data: data as Data){
            imageShow.image = img
            showData = nil
        }else{
            print("no img")
        }
        return
        
        
        if data.count<=maxData && showData == nil {
            if let img = UIImage(data: data){
                imageShow.image = img
            }else{
                print("data  error")
            }

        }else{
            let ten = NSData(data: data).subdata(with: NSRange(location: 0, length: 10))
            var tenStr = String(data: ten as Data, encoding: .utf8)
            print("tenStr:\(tenStr)")
            if (tenStr?.contains("flag"))! {
                let imgData = NSData(data: data).subdata(with: NSRange(location: 10, length: data.count-10))
                if showData == nil {
                    showData = NSMutableData(data: imgData)
                }else{
                    showData.append(imgData)
                }
                
                tenStr = tenStr?.replacingOccurrences(of: "flag", with: "")
                tenStr = tenStr?.replacingOccurrences(of: "a", with: "")
                
                let dict:[String] = (tenStr?.components(separatedBy: "-"))!
                if dict.count>1 {
                    let d1 = Int(dict[0])
                    let d2 = Int(dict[1])
                    if d1 == d2 {
                        print(showData.length)
                        if let img = UIImage(data: showData as Data){
                            imageShow.image = img
                            showData = nil
                        }else{
                            print("no img")
                        }
                    }
                }
                
                
            }

        }
        

        

        
    }
    
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print("udp close:\(error?.localizedDescription)")
    }
}
