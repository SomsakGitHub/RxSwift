//
//  MaybeViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class MaybeViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doGenerateString()
    }
    
    func generateString() -> Maybe<String> {
        return Maybe<String>.create { maybe in
            maybe(.success("RxSwift"))

            // OR

            maybe(.completed)

            // OR

            maybe(.error(GenerateString.invalidString))

            return Disposables.create {}
        }
    }

    func doGenerateString(){
//        generateString()
//            .subscribe { maybe in
//                switch maybe {
//                    case .success(let element):
//                        print("Completed with element \(element)")
//                    case .completed:
//                        print("Completed with no element")
//                    case .error(let error):
//                        print("Completed with an error \(error.localizedDescription)")
//                }
//            }
//            .disposed(by: disposeBag)
        
        generateString()
            .subscribe(onSuccess: { element in
                           print("Completed with element \(element)")
                       },
                       onError: { error in
                           print("Completed with an error \(error.localizedDescription)")
                       },
                       onCompleted: {
                           print("Completed with no element")
                       })
            .disposed(by: disposeBag)
    }
}

enum GenerateString: Error {
    case error
    case invalidString
}
