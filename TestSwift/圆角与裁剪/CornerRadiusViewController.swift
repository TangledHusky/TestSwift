//
//  CornerRadiusViewController.swift
//  TestSwift
//
//  Created by 李亚军 on 2016/12/13.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

class CornerRadiusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         
         uiview直接cornerRadius是可以的
         uiimageview和uilabel不可以，必须加上masktobounds=true
         
         避免离屏渲染
         离屏渲染，指的是GPU在当前屏幕缓冲区以外新开辟一个缓冲区进行渲染操作。由上面的一个结论视图和圆角的大小对帧率并没有什么卵影响，数量才是伤害的核心输出啊。可以知道离屏渲染耗时是发生在离屏这个动作上面，而不是渲染。为什么离屏这么耗时？原因主要有创建缓冲区和上下文切换。创建新的缓冲区代价都不算大，付出最大代价的是上下文切换。
         
         http://www.jianshu.com/p/34189f62bfd8
         
         http://www.jianshu.com/p/34189f62bfd8
         
         总结
         如果能够只用 cornerRadius 解决问题，就不用优化。
         如果必须设置 masksToBounds，可以参考圆角视图的数量，如果数量较少（一页只有几个）也可以考虑不用优化。
         UIImageView 的圆角通过直接截取图片实现，其它视图的圆角可以通过 Core Graphics 画出圆角矩形实现。
         
         文／bestswifter（简书作者）
         原文链接：http://www.jianshu.com/p/f970872fdc22
         
         */
        
        self.view.backgroundColor = UIColor.white
        
        let img = UIImageView(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
        img.image = UIImage(named: "test1")
        img.layer.cornerRadius = 20
        self.view.addSubview(img)
        
        let vv = UIView(frame: CGRect(x: 100, y: 180, width: 40, height: 40))
        vv.backgroundColor = UIColor.red
        vv.layer.cornerRadius = 20
        self.view.addSubview(vv)
        
        
        let lbl = UILabel(frame: CGRect(x: 100, y: 260, width: 40, height: 20))
        lbl.text = "label"
        lbl.backgroundColor = UIColor.green
        lbl.layer.cornerRadius = 10
        self.view.addSubview(lbl)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
