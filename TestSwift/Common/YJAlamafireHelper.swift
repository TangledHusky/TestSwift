//
//  YJAlamafireHelper.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/2/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import Alamofire



public class YJAlamafireHelper: NSObject {
    
    

    class func get(urlStr:String,params:[String:AnyObject],finishBlock:@escaping ((_ result:AnyObject)->Void)){
       requestData(type: .get, urlStr: urlStr, params: params) { (response) in
        finishBlock(response)
        }
    
    }
    
    
    class func post(urlStr:String,params:[String:AnyObject],finishBlock:@escaping ((_ result:AnyObject)->Void)){
        requestData(type: .post, urlStr: urlStr, params: params) { (response) in
        finishBlock(response)
        }
        
    }
    
    
    class func download(urlStr:String,finishBlock:@escaping ((_ result:AnyObject)->Void)){
        Alamofire.download(urlStr).responseData { (data) in
            finishBlock(data as AnyObject)
        }
    }


}


extension YJAlamafireHelper{
    class func requestData(type:HTTPMethod,urlStr:String,params:[String:AnyObject],finishBlock:@escaping ((_ result:AnyObject)->Void)) {
        
        
        Alamofire.request(urlStr, method: type, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response)  in
            //是否请求成功
            if let jsonValue = response.result.value {
                print("jsonValue:\(jsonValue)")
                finishBlock(jsonValue as AnyObject)
            }
        }

        
        
        
    }
    
}
