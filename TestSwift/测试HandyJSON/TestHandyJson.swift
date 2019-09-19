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
    //数组list
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



//==========other test=========

struct ResponseData<T: HandyJSON>: HandyJSON {
    var errorCode: Int?
    var errorMsg: String?
    var result: [T]?
    var startIndex:Int!
    var totalSize:Int!
}

struct FeedBackModel: HandyJSON {
    var billDate: String?
    var cashBillInfoId: Int?
    var employeeId: Int?
    var memberCardInfoID: Int?
    var memberCode: String?
    var memberName: String?
    var memberServerChatInfoId: Int?
    var mobile: String?
    var projectName: String?
    var projectPicOne: String?
    var projectPicTwo: String?
    var projectPicThree: String?
}
