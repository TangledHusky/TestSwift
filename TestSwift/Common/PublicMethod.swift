//
//  PublicMethod.swift
//  TestSwift
//
//  Created by YJ on 2017/3/10.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class PublicMethod: NSObject {

    
    class func getJSONStringFromDictionary(dictionary:NSDictionary) -> NSString {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString!
    }

    
    
    
}
