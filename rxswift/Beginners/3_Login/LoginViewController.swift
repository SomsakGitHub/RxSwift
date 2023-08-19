//
//  LoginViewController.swift
//  rxswift
//
//  Created by somsak on 19/8/2566 BE.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    func setUp(){
        let usernameObs = self.username.rx.text.orEmpty
        let passwordObs = self.password.rx.text.orEmpty
        
        let observableCombined = Observable.combineLatest(usernameObs, passwordObs)
        
        self.login.rx.tap
            .withLatestFrom(observableCombined)
            .subscribe(onNext: {
                self.loginLogic(user: $0, password: $1)
            })
            .disposed(by: disposeBag)
    }
    
    func loginLogic(user: String, password: String){
        if (user == "" || password == ""){
            print("false")
        }else{
            print("true")
        }
    }
}
