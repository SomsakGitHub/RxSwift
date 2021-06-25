//
//  LoginViewController.swift
//  RxSwiftLibrary
//
//  Created by somsak on 6/6/2564 BE.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginTouch(_ sender: Any) {
        print("loginTouch")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()

        usernameTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.usernamePublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.passwordPublishSubject).disposed(by: disposeBag)
        
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.1}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }
    
}

class LoginViewModel {
    let usernamePublishSubject = PublishSubject<String>()
    let passwordPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(usernamePublishSubject.asObservable(), passwordPublishSubject.asObservable()).map { username, password in
            
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }
}
