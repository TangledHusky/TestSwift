//
//  YJRequest.swift
//  TestSwift
//
//  Created by 李亚军 on 16/7/18.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit
import AFNetworking

class YJRequest: NSObject {
    
    //#pragma mark - 上传图片 
    func uploadImageWithImage(_ imageData: Data){

    let sessionConfiguration = URLSessionConfiguration.default
    let manager =  AFHTTPSessionManager(sessionConfiguration: sessionConfiguration)
    manager.responseSerializer.acceptableContentTypes = NSSet(arrayLiteral: "application/json", "text/json", "text/javascript","text/html") as? Set<String>

        
        
        manager.post("", parameters: ["":""], constructingBodyWith: { (formData) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            formatter.timeZone = NSTimeZone.system
            let fileName:String = "\(formatter.string(from: NSDate.init() as Date)).jpg"
            formData.appendPart(withFileData: imageData, name: "head", fileName: fileName, mimeType: "image/png")
            }, progress: { (progress) in
                //
            }, success: { (task, response) in
                //
                print("suceess")
            }) { (task, error) in
                //
                 print(error)
        }
        
    }
}
