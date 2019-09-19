//
//  TestHandyJSONViewController.swift
//  TestSwift
//
//  Created by liyajun on 2016/7/5.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit
import HandyJSON


class TestHandyJSONViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let lbl = UILabel()
        lbl.textColor = UIColor.red
        lbl.textAlignment = .center
        lbl.text = "注意看xcode log"
        view.addSubview(lbl)
        lbl.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
            maker.height.equalTo(33)
            maker.center.equalToSuperview()
        }
        
        //可以放开注释！！！！！！
        
        //json 转 model
//        convertModel1()
//        convertModel2()
        convertModel11()
        
        //dict 转 model
//        convertModel3()
      
        //model 转 json
//        convertModel4()
        
    }

    func convertModel1() {
        let jsonStr = "{\"id\":1,\"name\":\"hello\",\"score\":1.1}"
        if let model = JSONDeserializer<TestHandyJson>.deserializeFrom(json: jsonStr){
            print("convertModel1    \(model)")
            
        }
    }
    
    func convertModel2() {
        let jsonStr = "{\"list\":[{\"id\":1,\"name\":\"hello\",\"score\":1.1},{\"id\":2,\"name\":\"kkkkk\",\"score\":2.2}]}"
        if let model = JSONDeserializer<TestHandyJsonList>.deserializeFrom(json: jsonStr){
            print("convertModel2   \(model)")
        }
    }
    
    func convertModel3() {
        let jsonDict:[String : Any] = ["id":1,
                                       "name":"zhangsan",
                                       "sex":"man",
                                       "love":"篮球、菊花茶"]
        if let model = JSONDeserializer<DictToModel>.deserializeFrom(dict: jsonDict as NSDictionary){
           print("convertModel3  \(model)")
        }
    }
    

    func convertModel4() {
        let model = TestHandyJson()
        model.id = 11
        model.name = "zhangsi"
        model.score = 2.2
        
        print(model.toJSON()!) // 序列化到字典
        print(model.toJSONString()!) // 序列化到JSON字符串
        print(model.toJSONString(prettyPrint: true)!) // 序列化为格式化后的JSON字符串,就是会换行，看起来好看
    
    }
    
    func convertModel11() {
        let jsonStr = "{\"errorCode\":0,\"errorMsg\":\"no err\",\"pageSize\":0,\"result\":[{\"billDate\":\"2019-09-16\",\"cashBillInfoId\":324429,\"employeeId\":36362,\"memberCardInfoID\":196024,\"memberCode\":\"13817641531\",\"memberName\":\"杨洋\",\"memberServerChatInfoId\":0,\"mobile\":\"1381764153\",\"projectName\":\"足浴168\",\"projectPicOne\":\"\",\"projectPicThree\":\"\",\"projectPicTwo\":\"\"}],\"startIndex\":0,\"totalSize\":0}"
        if let model = JSONDeserializer<ResponseData<FeedBackModel>>.deserializeFrom(json: jsonStr){
            print("convertModel  \(model.result)")
            
        }
        
        
    }
}
