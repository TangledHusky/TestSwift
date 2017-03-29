
//
//  ScrollViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/3/8.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    var horizontalCount:NSInteger = 20
    var verticalCount:NSInteger = 30
    
    var sliderWH:CGFloat = 50
    

    var scroll:UIScrollView! = nil
    var toptableview:UITableView! = nil
    var topDatas:[String] = []
    
    var lefttableview:UITableView! = nil
    var leftDatas:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        scroll = UIScrollView(frame: CGRect(x: sliderWH, y: 64, width: KScreenWidth-sliderWH, height: KScreenHeight - 64))
        view.addSubview(scroll)
        scroll.backgroundColor = UIColor.red
        scroll.delegate = self
        scroll.bounces = false
        scroll.contentSize = CGSize(width: sliderWH*CGFloat(horizontalCount), height: sliderWH*CGFloat(verticalCount))
        

        toptableview = UITableView(frame: CGRect(x: 0, y: 0, width: sliderWH, height: KScreenWidth-sliderWH), style: .plain)
        toptableview.center = CGPoint(x: (KScreenWidth-sliderWH)/2 + sliderWH, y: 64+sliderWH/2)
        toptableview.alwaysBounceHorizontal = true
        toptableview.dataSource = self
        toptableview.delegate = self
        self.view.addSubview(toptableview)
        toptableview.backgroundColor = UIColor.green
        toptableview.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        
        lefttableview = UITableView(frame: CGRect(x: 0, y: 64+sliderWH, width: 50, height: KScreenHeight-64-sliderWH), style: .plain)
        lefttableview.dataSource = self
        lefttableview.delegate = self
        self.view.addSubview(lefttableview)
        lefttableview.backgroundColor = UIColor.yellow

        
        
        for i in 0..<horizontalCount {
            topDatas.append((i+1).description)
        }
        toptableview.reloadData()
        
        for i in 0..<verticalCount {
            leftDatas.append((i+1).description)
        }
        lefttableview.reloadData()
        
        
        for y in 0..<verticalCount {
            for x in 0..<horizontalCount {
                let v = UIView()
                v.backgroundColor = getRandomColor()
                v.frame.origin.x = CGFloat(x) * sliderWH
                v.frame.origin.y =  CGFloat(y)*sliderWH
                v.frame.size.width = sliderWH
                v.frame.size.height = sliderWH
                scroll.addSubview(v)
            }
        }
        
    }

    func getRandomColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(Double(arc4random_uniform(255))/255.0), green: Float(Double(arc4random_uniform(255))/255.0), blue: Float(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}

extension ScrollViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let y = scrollView.contentOffset.y
        print("x:\(x)  y:\(y)")
        
        if scrollView == scroll {
            toptableview.contentOffset.y = x
            lefttableview.contentOffset.y = y
        }
    }
}



extension ScrollViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == lefttableview {
            return leftDatas.count
        }
        return topDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == lefttableview {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "leftCellID")
            cell.textLabel?.text = leftDatas[indexPath.row]
            cell.backgroundColor = UIColor.brown
            return cell
        }else{
            let cell = UITableViewCell(style: .default, reuseIdentifier: "topCellID")
            cell.textLabel?.text = topDatas[indexPath.row]
            cell.backgroundColor = UIColor.orange
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            return cell
        }

        
    }
}

extension ScrollViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
