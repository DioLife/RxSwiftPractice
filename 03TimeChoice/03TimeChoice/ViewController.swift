//
//  ViewController.swift
//  03TimeChoice
//
//  Created by baiwei－mac on 2018/5/17.
//  Copyright © 2018年 YuHua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel2: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    private let bag = DisposeBag()
    private var time = Variable(Date())
    private let formatter: DateFormatter = {
        let formate = DateFormatter()
        formate.dateFormat = "MM dd, yyyy, hh:mm:ss"
        return formate
    }()
    private var timeString = Variable("0")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.time.value = Date()
            self.timeString.value = self.formatter.string(from: Date())
        }
        
        //通过订阅获得数据的改变
        time.asObservable()
            .observeOn(MainScheduler.instance)//保证后续后续代码是在UI线程执行
            .subscribe(onNext: { [weak self] time in
                self?.timeLabel2.text = self?.formatter.string(from: time)
            })
            .disposed(by: bag)
        
        //将UI界面与数据绑定
        timeString.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: timeLabel.rx.text)
            .disposed(by: bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

