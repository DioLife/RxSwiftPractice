//
//  ViewController.swift
//  05Calculate
//
//  Created by baiwei－mac on 2018/5/18.
//  Copyright © 2018年 YuHua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var numSlider: UISlider!
    @IBOutlet weak var inPutNum: UITextField!
    @IBOutlet weak var resultLable: UILabel!
    
    private var result = Variable(Float(0))
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inPutNum.rx.text
            .subscribe(onNext: { [weak self] _ in
                self?.checkResult()
            })
            .disposed(by: bag)
        
        numSlider.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.checkResult()
            })
            .disposed(by: bag)
        
        result.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.resultLable.text = String(value)
            })
            .disposed(by: bag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inPutNum.resignFirstResponder()
    }
    
    private func checkResult() {
        result.value = numSlider.value * Float(inPutNum.text!)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

