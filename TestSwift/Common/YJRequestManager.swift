//
//  YJRequestManager.swift
//  TestSwift
//
//  Created by YJ on 2017/2/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


typealias NetSuccessBlock = ([String:Any]) -> Void   //成功
typealias NetFailedBlock = (String) -> Void //失败
typealias NetProgressBlock = (Double) -> Void//进度



class YJRequestManager: NSObject {
    
    var baseUrl = ""
    var headers:HTTPHeaders = ["Content-Type":"application/json"]
    
    private var sessionManager: SessionManager?
    static let share = YJRequestManager()
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustPolicyManager: nil)
        
    }
    

}


// MARK: - 基础方法
extension YJRequestManager{
    func GET(url: String, param: Parameters?,addbaseUrl:Bool = true, success: @escaping NetSuccessBlock, failed: @escaping NetFailedBlock) -> Void {
        let wholeurl = addbaseUrl ? (baseUrl + url) : url
        self.sessionManager?.request(wholeurl, method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (response) in
            self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
        })
    }
    
    func POST(url: String, param: Parameters?,addbaseUrl:Bool = true, success: @escaping NetSuccessBlock, failed: @escaping NetFailedBlock) -> Void {
        let wholeurl = addbaseUrl ? (baseUrl + url) : url
        self.sessionManager?.request(wholeurl, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (response) in
                self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
            })
    }
    
    
    //    上传图片
    func uploadImages(images: [UIImage], url: String, param: Parameters?, headers: HTTPHeaders,  progressBlock: @escaping NetProgressBlock, successBlock:@escaping NetSuccessBlock,faliedBlock:@escaping NetFailedBlock) {

        
        let headers = ["content-type":"multipart/form-data"];
        self.sessionManager?.upload(multipartFormData: { (multipartFormData) in
            //采用post表单上传
            // 参数解释
            images.forEach({ (image) in
                let imageData = image.jpegData(compressionQuality: 0.1)
                let dataStr = DateFormatter.init()
                dataStr.dateFormat = "yyyyMMddHHmmss"
                let fileName = "\(dataStr.string(from: Date.init())).png"
                multipartFormData.append(imageData!, withName: "file", fileName: fileName, mimeType: "image/jpg/png/jpeg")
                
                /*
                 if video:
                 let fileName = "\(dataStr.string(from: Date.init())).mp4"
                 multipartFormData.append(video, withName: "file", fileName: fileName, mimeType: "video/mp4");
                 */
            })
            
        }, to: url, headers: headers, encodingCompletion: { (encodingResult) in
            
            
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    self.handleResponse(response: response, successBlock: successBlock, faliedBlock: faliedBlock)
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    progressBlock(progress.fractionCompleted);
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
                break
            case .failure(let encodingError):
                self.handleRequestError(error: encodingError as NSError, faliedBlock: faliedBlock);
                break
            }
        })
    }
    
    
}



// MARK: - 请求数据返回响应方法
extension YJRequestManager{
    /** 处理服务器响应数据*/
    private func handleResponse(response:DataResponse<Any>, successBlock: NetSuccessBlock ,faliedBlock: NetFailedBlock){
        if let error = response.result.error {
            // 服务器未返回数据
            self.handleRequestError(error: error as NSError , faliedBlock: faliedBlock)
            
        }else if let value = response.result.value {
            self.handleRequestSuccess(value: value, successBlock: successBlock, faliedBlock: faliedBlock);
        }
    }
    
    /** 处理请求成功数据*/
    private func handleRequestSuccess(value:Any, successBlock: NetSuccessBlock,faliedBlock: NetFailedBlock){
        //解析总结构
        guard let res = value as? [String:Any],let dataModel = ModelResult.init(JSON: res),let resDict = dataModel.result as? [String:Any] else{
            faliedBlock("解析失败");
            return
        }
        //根据返回内容定义好的status判断
        if dataModel.status == 200 {
            successBlock(resDict)
        } else{
            // 获取服务器返回失败原因
            faliedBlock(dataModel.msg);
        }
    }
    
    
    /** 处理请求失败数据*/
    private func handleRequestError(error: NSError, faliedBlock: NetFailedBlock){
        print(error.debugDescription)
        var errorInfo = ""
        if ( error.code == -1009 ) {
            errorInfo = "无网络连接";
        }else if ( error.code == -1001 ){
            errorInfo = "请求超时";
        }else if ( error.code == -1005 ){
            errorInfo = "网络连接丢失(服务器忙)";
        }else if ( error.code == -1004 ){
            errorInfo = "服务器没有启动";
        }else if ( error.code == 404 || error.code == 3) {
        }
        faliedBlock(errorInfo)
    }
    
}


class ModelResult : Mappable{
    
    var result:Any?
    var msg:String! = ""
    var status : Int! = 0
    required init?(map: Map) {
        if map.JSON["status"] == nil{
            return nil
        }
    }
    
    func mapping(map: Map) {
        msg <- map["msg"]
        result <- map["data"]
        status <- map["status"]
    }
}
