//
//  CreatingYourOwnObservableViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class CreatingYourOwnObservableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doStringCounter()
    }
    
    func myFrom<E>(_ sequence: [E]) -> Observable<E> {
        print("myFrom ----")
        return Observable.create { observer in
            print("create ----")
            for element in sequence {
                observer.on(.next(element))
                print("next ----")
            }

            observer.on(.completed)
            print("completed ----")
            return Disposables.create()
        }
    }
    
    func doStringCounter(){
        let stringCounter = myFrom(["first", "second"])

        print("Started ----")

        // first time
        stringCounter
            .subscribe(onNext: { n in
                print(n)
            })

        print("----")

        // again
        stringCounter
            .subscribe(onNext: { n in
                print(n)
            })

        print("Ended ----")
    }

}
