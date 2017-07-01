//
//  DownloadModel.swift
//  TestSwift
//
//  Created by liyajun on 2017/4/20.
//  Copyright © 2017年 YJ公司. All rights reserved.
//

import UIKit

enum DownloadStatus {
    case DownloadStatusWaitToDownload
    case DownloadStatusIsDownloading
    case DownloadStatusPause
    case DownloadStatusCompleted
}

class DownloadModel: NSObject {
    
    var uuid = getUUID()    
    
    var downloadUrl = ""
    var downloadProgress = 0.0
    
    var downloadTask: URLSessionDownloadTask?
    var downloadResumeData: Data?
    var status = DownloadStatus.DownloadStatusWaitToDownload
    
    
    init(downloadUrl:String) {
        self.downloadUrl = downloadUrl
    }
    
    override init() {
        
    }

}

//获取UUID
func getUUID() -> String {
    let uuidRef = CFUUIDCreate(nil)
    let uuidStringRef = CFUUIDCreateString(nil,uuidRef)
    return uuidStringRef! as String
}
