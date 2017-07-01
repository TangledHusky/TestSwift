//
//  BigFileDownloadViewController.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/20.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

class BigFileDownloadViewController: UIViewController {
    
    let cellID:String = "downloadCellid"
    

    @IBOutlet weak var tableview: UITableView!
    
    
    var datas:[DownloadModel] = [DownloadModel(),DownloadModel(),DownloadModel(),DownloadModel(),DownloadModel(),DownloadModel()]
    
    lazy var session:URLSession = {
        let ss = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        return ss
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        //测试：随机找了几段可下载的链接
        datas[0].downloadUrl = "http://data.vod.itc.cn/?rb=1&prot=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/92/189/Tey0slH3Qo6powiufo2IsA.mp4"
        datas[1].downloadUrl = "http://58.222.16.21/sohu/s26h23eab6/xdispatch/sohu.vod.qingcdn.com/192/188/HlMsPsUIRsOSJXTBCzGWJA.mp4?key=yLqhKgTdnOUJGx1K6B6ztQDDiIIH08An&n=1&a=4902&cip=121.235.19.0&pt=1&rb=1&prod=flash"
        datas[2].downloadUrl = "http://data.vod.itc.cn/?rb=1&prot=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/92/189/Tey0slH3Qo6powiufo2IsA.mp4"
        datas[3].downloadUrl = "http://data.vod.itc.cn/?rb=1&prot=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/92/189/Tey0slH3Qo6powiufo2IsA.mp4"
        datas[4].downloadUrl = "http://data.vod.itc.cn/?rb=1&prot=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/92/189/Tey0slH3Qo6powiufo2IsA.mp4"
        datas[5].downloadUrl = "http://data.vod.itc.cn/?rb=1&prot=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&prod=flash&pt=1&new=/92/189/Tey0slH3Qo6powiufo2IsA.mp4"
       
        tableview.register(UINib(nibName: "DownloadCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableview.tableFooterView = UIView()
        tableview.dataSource = self
        
        
    }



    func startDownloadFile(index:Int) {
        let model = datas[index]
        //新下载
        if model.downloadResumeData == nil {
            if let urlStr:String = model.downloadUrl,let url = URL(string: urlStr){
                print("\(model.uuid)  \(model.downloadUrl)")
                let download:DownloadModel = DownloadModel(downloadUrl: urlStr)
                download.downloadTask = session.downloadTask(with: url)
                download.downloadTask?.resume()
                download.status = DownloadStatus.DownloadStatusIsDownloading
                
                datas[index] = download
            }

        }else{
            datas[index].downloadTask = session.downloadTask(withResumeData: datas[index].downloadResumeData!)
            datas[index].downloadTask?.resume()
            datas[index].status = DownloadStatus.DownloadStatusIsDownloading
            
        }
        
        
        
        
    }
    
    
    /// 暂停下载-这里有个弊端：已下载的data最好不要存到内存里，要save到本地，并记录下保存路径
    /// 我这里是为了方便测试，先保存内存
    /// - Parameter index: <#index description#>
    func stopDownload(index:Int) {
        let model = datas[index]
        model.downloadTask?.cancel(byProducingResumeData: { (data) in
            if data != nil{
                model.downloadResumeData = data
            }
        })
        model.status = DownloadStatus.DownloadStatusPause
        
        datas[index] = model
        
    }

    
    func deleteDownload(index:Int) {
        datas[index] = DownloadModel()
    }
    
    func localFilePathForUrl(url:String) -> URL {
        let domin = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        
        let str = domin?.appending("/download").appending("/\(url)")
        return URL(string: str!)!
    }
    
    func getCellIndex(task:URLSessionDownloadTask) -> Int {
        
        var index = 0
        
        for (i,obj) in datas.enumerated() {
            if obj.downloadTask == task {
                index = i
                break
            }
        }
        
        return index
    }

}


extension BigFileDownloadViewController:URLSessionDelegate,URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(" download completed")
        
        let index = getCellIndex(task: downloadTask)
        // 1
        if let destinationURL:URL = localFilePathForUrl(url: datas[index].uuid) {
            
            print("\(location.description)\n\(destinationURL.description)")
            
            // 2
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(at: destinationURL)
            } catch {
                //
                print("fileManager.removeItem error")
            }
            
            do {
                try fileManager.copyItem(at: location, to: destinationURL)
            
            } catch let error as NSError {
                print("fileManager.copyItem error:\(error.localizedDescription)")
            }
        }
        
        // 3
        
        let cell = tableview.cellForRow(at: IndexPath(row:index , section: 0)) as! DownloadCell
        cell.setDownloadCompleted()
      
        datas[index].status = DownloadStatus.DownloadStatusCompleted
        
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let index = getCellIndex(task: downloadTask)
        let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! DownloadCell
        
        DispatchQueue.main.async {
            cell.setProgress(progress: CGFloat(Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)))

        }
        
//        print("\(index)   bytesWritten:\(bytesWritten) totalBytesWritten:\(totalBytesWritten) totalBytesExpectedToWrite:\(totalBytesExpectedToWrite)")

        
    }
    
}

extension BigFileDownloadViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? DownloadCell{
            cell.fill(indexValue: indexPath.row)
            cell.delegate = self
            
            return cell
            
        }
        print("cell nil")
        return DownloadCell()
    }
}

extension BigFileDownloadViewController:DownloadCellDelegate{
    func DownloadCellStart(index: Int) {
        print("DownloadCellStart \(index)")
        startDownloadFile(index: index)
        
    }

    func DownloadCellStop(index: Int) {
        print("DownloadCellStop \(index)")
        stopDownload(index: index)
    }
    
    func DownloadCellDelete(index: Int) {
        print("DownloadCellDelete \(index)")
        
        deleteDownload(index: index)

    }

}

