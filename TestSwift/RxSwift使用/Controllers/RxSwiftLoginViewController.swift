//
//  RxSwiftLoginViewController.swift
//  TestSwift
//
//  Created by YJ on 2017/3/22.
//  Copyright © 2017年 zyyj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftLoginViewController: UIViewController {

    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        
        
    }

    func testGestureEvent()  {
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).addDisposableTo(disposeBag)
        

    
    }
    
 

}
