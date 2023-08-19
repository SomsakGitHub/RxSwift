//
//  OperatorsViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class OperatorsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doMymap()
    }
    
    func myInterval(_ interval: DispatchTimeInterval) -> Observable<Int> {
        return Observable.create { observer in
            print("Subscribed")
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: DispatchTime.now() + interval, repeating: interval)

            let cancel = Disposables.create {
                print("Disposed")
                timer.cancel()
            }

            var next = 0
            timer.setEventHandler {
                if cancel.isDisposed {
                    return
                }
                observer.on(.next(next))
                next += 1
            }
            timer.resume()

            return cancel
        }
    }
    
    func doMymap(){
        let subscription = myInterval(.milliseconds(100))
            .debug("my probe")
            .map { e in
                return "This is simply \(e)"
            }
            .subscribe(onNext: { n in
                print(n)
            })
    }
}

extension ObservableType {
    func myMap<R>(transform: @escaping (Element) -> R) -> Observable<R> {
        return Observable.create { observer in
            let subscription = self.subscribe { e in
                    switch e {
                    case .next(let value):
                        let result = transform(value)
                        observer.on(.next(result))
                    case .error(let error):
                        observer.on(.error(error))
                    case .completed:
                        observer.on(.completed)
                    }
                }

            return subscription
        }
    }
}
