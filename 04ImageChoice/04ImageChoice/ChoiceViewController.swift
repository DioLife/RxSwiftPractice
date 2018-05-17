//
//  ChoiceViewController.swift
//  04ImageChoice
//
//  Created by yuhua on 2018/5/17.
//  Copyright © 2018年 余华. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChoiceViewController: UIViewController {
    
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn9: UIButton!
    
    
    //公开给外部订阅
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotosSubject.asObserver()
    }
    
    //私有
    private let selectedPhotosSubject = PublishSubject<UIImage>()
    private let bag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btn2.addTarget(self, action: #selector(tapBtn(btn:)), for: .touchUpInside)
        btn5.addTarget(self, action: #selector(tapBtn(btn:)), for: .touchUpInside)
        btn9.addTarget(self, action: #selector(tapBtn(btn:)), for: .touchUpInside)
    }
    
    //@objc使方法支持动态派发
    @objc private func tapBtn(btn: UIButton) {
        selectedPhotosSubject.onNext(btn.currentImage!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //发送结束事件
        selectedPhotosSubject.onCompleted()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("\(type(of: self))销毁了")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
