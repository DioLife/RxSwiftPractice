//
//  ViewController.swift
//  01TapCounter
//
//  Created by baiwei－mac on 2018/5/16.
//  Copyright © 2018年 YuHua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var totalLable: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cleanBtn: UIButton!
    
    /*
     Subjet有四种类型：
     PublishSubject:只发送最新事件
     BehaviorSubject:发送订阅前一次事件和后续事件
     ReplaySubject:发送订阅前缓存的事件
     Variable:BehaviorSubject的封装
     */
    var total = Variable(0)
    
    /*
     DisposeBag：相当于ARC中，系统的作用一样，管理订阅
     */
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtn.rx.tap.subscribe(onNext:{ [weak self] _ in
            //对value进行赋值，相当于调用了total的onNext方法
            self?.total.value += 1
        }).disposed(by: bag)
        
        cleanBtn.rx.tap.subscribe(onNext:{ [weak self] _ in
            self?.total.value = 0
        }).disposed(by: bag)
        
        //asObservable:获得被封装了的BehaviorSubject
        total.asObservable().subscribe(onNext: { [weak self] value in
            self?.totalLable.text = String(value)
        }).disposed(by: bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

