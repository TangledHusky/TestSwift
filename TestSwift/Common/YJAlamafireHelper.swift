//
//  YJAlamafireHelper.swift
//  TestSwift
//
//  Created by 李亚军 on 2017/2/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
}

public class YJAlamafireHelper: NSObject {
    
    

    class func get(urlStr:String,params:[String:AnyObject],finishBlock:((_ result:AnyObject)->Void)) {
        requestData(type: MethodType.GET, urlStr: urlStr, params: params) { (result) in
            finishBlock(result)
        }
    }

}


extension YJAlamafireHelper{
    class func requestData(type:MethodType,urlStr:String,params:[String:AnyObject],finishBlock:((_ result:AnyObject)->Void)) {
        
//        let requestType = type == MethodType.GET ? Alamofire.Method.GET : Alamofire.Method.POST
        
        
        
        
    }
    
}
