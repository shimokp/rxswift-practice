//
//  ViewController.swift
//  rxswift-practice
//
//  Created by 下村一将 on 2017/09/07.
//  Copyright © 2017 kazu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var field1: UITextField!
    
    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    
    let hoge = Hoge()
    let presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fieldBindToLabel()
        subscribeHoge()
        subscribePresenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fieldBindToLabel() {
        field1.rx.text
            .map{"[\($0!)]"}
            .bind(to: label1.rx.text)
            .addDisposableTo(disposeBag)
    }
    
    
    
    func subscribeHoge() {
        let disposable = hoge.event.subscribe(
            onNext: { value in
                NSLog("onNext: %d", value)
        },
            onError: { err in
                NSLog("onError")
        },
            onCompleted: {
                NSLog("onComplete")
        },
            onDisposed: {
                NSLog("onDisposed")
        })
    }
    
    func subscribePresenter() {
        let disposable = presenter.buttonHidden.subscribe(onNext: { [button] in
            button?.isHidden = $0
        })
    }
    
    @IBAction func onNextButtonTapped(_ sender: Any) {
        hoge.doSomething()
    }
    
    @IBAction func onErrorButtonTapped(_ sender: Any) {
        hoge.makeError()
    }
    
    @IBAction func onCompleteButtonTapped(_ sender: Any) {
        hoge.completed()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        presenter.start()
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        presenter.stop()
    }
    
    
}

