//
//  TestHandyJson.swift
//  TestSwift
//
//  Created by liyajun on 2017/7/5.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit
import HandyJSON

class TestHandyJson: HandyJSON {
    var id: Int!
    var name: String!
    var score: Double? = 0.0
    
    //必须实现
    required init() {
        
    }
}

class TestHandyJsonList: HandyJSON {
    var list: [TestHandyJson]! = []
    
    //必须实现
    required init() {
        
    }
}

class DictToModel: HandyJSON {
    var id: Int!
    var name: String!
    var sex: String!
    var love: String!
    
    //必须实现
    required init() {
        
    }
}


struct structModel:HandyJSON {
    var id: Int!
    var name: String!
    
    init() {
        
    }
}



