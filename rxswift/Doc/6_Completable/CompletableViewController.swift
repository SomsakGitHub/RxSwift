//
//  CompletableViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class CompletableViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doCompletable()
    }
    
    func cacheLocally() -> Completable {
        return Completable.create { completable in
           // Store some data locally

            guard completable != nil else {
               completable(.error("error" as! Error))
               return Disposables.create {}
           }

           completable(.completed)
           return Disposables.create {}
        }
    }
    
    func doCompletable(){
//        cacheLocally()
//            .subscribe { completable in
//                switch completable {
//                    case .completed:
//                        print("Completed with no error")
//                    case .error(let error):
//                        print("Completed with an error: \(error.localizedDescription)")
//                }
//            }
//            .disposed(by: disposeBag)
        
        cacheLocally()
            .subscribe(onCompleted: {
                           print("Completed with no error")
                       },
                       onError: { error in
                           print("Completed with an error: \(error.localizedDescription)")
                       })
            .disposed(by: disposeBag)
    }

}
