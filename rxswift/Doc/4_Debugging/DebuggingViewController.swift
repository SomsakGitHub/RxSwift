//
//  DebuggingViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class DebuggingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doDebug()
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
    
    func doDebug(){
        let subscription = myInterval(.milliseconds(100))
            .myDebug(identifier: "my probe")
            .map { e in
                return "This is simply \(e)"
            }
            .subscribe(onNext: { n in
                print(n)
            })

        Thread.sleep(forTimeInterval: 0.5)

        subscription.dispose()
    }

}

extension ObservableType {
    public func myDebug(identifier: String) -> Observable<Self.Element> {
        return Observable.create { observer in
            print("subscribed \(identifier)")
            let subscription = self.subscribe { e in
                print("event \(identifier)  \(e)")
                switch e {
                case .next(let value):
                    observer.on(.next(value))

                case .error(let error):
                    observer.on(.error(error))

                case .completed:
                    observer.on(.completed)
                }
            }
            return Disposables.create {
                   print("disposing \(identifier)")
                   subscription.dispose()
            }
        }
    }
 }
