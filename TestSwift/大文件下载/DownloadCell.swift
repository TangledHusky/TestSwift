//
//  DownloadCell.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/20.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit


protocol DownloadCellDelegate:NSObjectProtocol {
    //下载
    func DownloadCellStart(index:Int)

    //暂停
    func DownloadCellStop(index:Int)

    //删除
    func DownloadCellDelete(index:Int)

}
class DownloadCell: UITableViewCell {

    @IBOutlet weak var lineProgress: YJDownloadProgress!
    
    @IBOutlet weak var btnDownload: UIButton!
    
    weak var delegate:DownloadCellDelegate?
    
    var index:Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(indexValue:Int) {
        index = indexValue
    }
    
    
    func setProgress(progress:CGFloat) {
        lineProgress.setProgress(progress: progress)
    }
    
    @IBAction func startDownload(_ sender: Any) {
        if btnDownload.titleLabel?.text == "下载" {
            btnDownload.setTitle("暂停", for: .normal)
            self.delegate?.DownloadCellStart(index: index)

        }else if btnDownload.titleLabel?.text == "暂停" {
            btnDownload.setTitle("下载", for: .normal)
            self.delegate?.DownloadCellStop(index: index)
            
        }else if btnDownload.titleLabel?.text == "删除" {
            btnDownload.setTitle("下载", for: .normal)
            self.delegate?.DownloadCellDelete(index: index)
            self.setProgress(progress: 0)
            
        }
        
       
        
    }
    
    func setDownloadCompleted() {
        btnDownload.setTitle("删除", for: .normal)
    }

  
}
