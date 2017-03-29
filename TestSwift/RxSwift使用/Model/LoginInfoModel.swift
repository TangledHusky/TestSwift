//
//  LoginInfoModel.swift
//  TestSwift
//
//  Created by liyajun on 2017/3/23.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginInfoModel: NSObject,Mappable,NSCoding {
    
    var name:String! = ""
    var addr:String! = ""
    var sex:String! = ""
    var id:String! = ""
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        name <- map["name"]
        addr <- map["addr"]
        sex <- map["sex"]
        id <- map["id"]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    }

}

