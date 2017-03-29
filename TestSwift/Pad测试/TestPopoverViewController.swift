//
//  TestPopoverViewController.swift
//  TestSwift
//
//  Created by liyajun on 2017/3/29.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

protocol TestPopoverViewControllerDelegate:NSObjectProtocol {
    func TestPopoverViewControllerDidSelect(index:NSInteger)
}

class TestPopoverViewController: UIViewController {
    
    var tableview:UITableView!

    var data = ["列表1","列表2","列表3","列表4","列表5","列表6","列表7","列表8"]
    
    weak var delegate:TestPopoverViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        //设置pop框最大高度为150
        let maxH = min(150, 40*data.count)
        
        self.preferredContentSize = CGSize(width: 200, height: maxH)
        
        
        tableview = UITableView(frame: self.view.bounds, style: .plain)
        view.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 40
        
    }

   

}

extension TestPopoverViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellid")
        }
        
        cell?.textLabel?.text = data[indexPath.row]
        
        return cell!
    }
}

extension TestPopoverViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.TestPopoverViewControllerDidSelect(index: indexPath.row)
    }
}
