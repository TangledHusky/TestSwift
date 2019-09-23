//
//  CityModel.swift
//  TestSwift
//
//  Created by liyajun on 2019/9/23.
//  Copyright © 2019 YJ公司. All rights reserved.
//

import UIKit
import ObjectMapper


//==============激活城市================
struct AuthorAreaListModel : Mappable {
    var is_global_update:Bool = false   //false表示需要对region_info的城市进行激活检测
    var region_info : [AuthorAreaModel]! = []
    init?(map: Map) {
        if map.JSON["is_global_update"] == nil{
            return nil
        }
    }
    mutating func mapping(map: Map) {
        is_global_update <- map["is_global_update"]
        region_info <- map["region_info"]
    }
}

struct AuthorAreaModel : Mappable {
    var region_code:Int = 0
    var region_name : String = ""
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        region_code <- map["region_code"]
        region_name <- map["region_name"]
    }
}
