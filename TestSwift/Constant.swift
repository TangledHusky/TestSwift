//
//  Constant.swift
//  TestSwift
//
//  Created by YJ on 16/7/5.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit


let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height


#if APPDEV
    let ss = "dev"
#elseif APPTEST
    let ss = "test"
#else
    let ss = "product"
#endif



#if DEBUG
    let aa = 2
#else
    let aa = 22
#endif



class Constant: NSObject {
    

}
