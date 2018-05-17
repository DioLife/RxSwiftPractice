//
//  ViewController.swift
//  04ImageChoice
//
//  Created by yuhua on 2018/5/17.
//  Copyright © 2018年 余华. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //从storyboard中获取vc
        let board = UIStoryboard(name: "Main", bundle: Bundle.main)
        let choice = board.instantiateViewController(withIdentifier: "Choice") as! ChoiceViewController
        
        choice.selectedPhoto
            .subscribe(onNext: { [unowned self] image in
                if self.image1.image == nil {
                    self.image1.image = image
                }else if self.image2.image == nil {
                    self.image2.image = image
                }else {
                    self.image3.image = image
                }
                }, onDisposed: { print("选择已结束") })
            .disposed(by: bag)
        
        navigationController?.pushViewController(choice, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

