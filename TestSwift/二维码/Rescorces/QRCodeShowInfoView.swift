//
//  QRCodeShowInfoView.swift
//  TestSwift
//
//  Created by YJ on 2017/3/13.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit

class QRCodeShowInfoView: UIView {
    
    var lblTitle:UILabel! = nil
    var lblPwd:UILabel! = nil
    var btnCopy:UIButton! = nil
    
    //用于拷贝的内容存储
    var password:String = ""
    
    
    private let lblTitleH:CGFloat = 30
    private let lblPwdH:CGFloat = 53
    private let btnCopyH:CGFloat = 60
    private let lblMarginVertical:CGFloat = 5           //表情垂直间距
    
    
    var lblTip:UILabel! = nil
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    
    func initViews() {
        self.backgroundColor = UIColor.white
        let lblTitleY:CGFloat = (KScreenHeight-lblPwdH)/2 - lblTitleH - lblMarginVertical
        
        lblTitle = UILabel(frame: CGRect(x: 0, y: lblTitleY, width: KScreenWidth, height: lblTitleH))
        lblTitle.textColor = UIColor.colorWithHex(hex: "4A4A4A")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(lblTitle)
        
        lblPwd = UILabel(frame: CGRect(x: 0, y: (KScreenHeight-lblPwdH)/2, width: KScreenWidth, height: lblPwdH))
        lblPwd.textColor = UIColor.colorWithHex(hex: "4A4A4A")
        lblPwd.textAlignment = .center
        lblPwd.font = UIFont.boldSystemFont(ofSize: 38)
        self.addSubview(lblPwd)
        
        btnCopy = UIButton(frame: CGRect(x: 0, y: (KScreenHeight+lblPwdH)/2 + lblMarginVertical, width: KScreenWidth, height: btnCopyH))
        btnCopy.setTitle("复  制", for: .normal)
        btnCopy.backgroundColor = UIColor.colorWithHex(hex: "FF3B30")
        btnCopy.setTitleColor(UIColor.white, for: .normal)
        btnCopy.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        btnCopy.addTarget(self, action: #selector(self.copyPwd), for: .touchUpInside)
        self.addSubview(btnCopy)
        
        let lblTipW:CGFloat = 130
        lblTip = UILabel(frame: CGRect(x: (KScreenWidth-lblTipW)/2, y: -lblPwdH, width: lblTipW, height: lblPwdH))
        lblTip.textColor = UIColor.white
        lblTip.layer.cornerRadius = 10
        lblTip.layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
        lblTip.textAlignment = .center
        lblTip.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(lblTip)
        
    }

    func setValue(wifiName:String,wifiPwd:String) {
        lblTitle.text = "请到Wifi设置中选择\(wifiName)网络进行连接"
        lblPwd.text = wifiPwd
        self.password = wifiPwd
    }
    
    func copyPwd(sender:UIButton) {
        let paste = UIPasteboard.general
        paste.string = password
        
        showTip(tipMessage: "拷贝成功")
        
        
    }
    
    func showTip(tipMessage:String) {
        lblTip.text = tipMessage
        weak var weakLbltip = lblTip
        UIView.animate(withDuration: 0.5, animations: {
            weakLbltip?.transform = CGAffineTransform(translationX: 0, y: 200)
        }) { (flag) in
            
            UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseInOut, animations: {
                weakLbltip?.transform = CGAffineTransform.identity
            }, completion: nil)
            
        }
        
    }
}
