//
//  ViewController.swift
//  02ImageGR
//
//  Created by baiwei－mac on 2018/5/17.
//  Copyright © 2018年 YuHua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //拖动手势
        let pan = UIPanGestureRecognizer()
        pan.rx.event
            .subscribe(onNext: { [unowned self] pan in
                print("pang手势\(pan)")
                let point = pan.location(in: self.view)
                self.imageView.center = point
            })
            .disposed(by: bag)
        imageView.addGestureRecognizer(pan)
        
        //点击手势
        let tap = UITapGestureRecognizer()
        tap.rx.event
            .subscribe({ [unowned self] event in
                print("tap手势\(event)")
                self.imageView.center = self.view.center
            })
            .disposed(by: bag)
        imageView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

