//
//  CreatingAnObservableViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class CreatingAnObservableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doMyInterval()
        doSubscription()
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
    
    func doMyInterval(){
        let counter = myInterval(.milliseconds(100))

        print("Started ----")

        let subscription = counter
            .subscribe(onNext: { n in
                print(n)
            })

        Thread.sleep(forTimeInterval: 0.5)

        subscription.dispose()

        print("Ended ----")
    }
    
    func doSubscription(){
        let counter = myInterval(.milliseconds(100))

        print("Started ----")

        let subscription1 = counter
            .subscribe(onNext: { n in
                print("First \(n)")
            })

        let subscription2 = counter
            .subscribe(onNext: { n in
                print("Second \(n)")
            })

        Thread.sleep(forTimeInterval: 0.5)

        subscription1.dispose()

        print("Disposed1")

        Thread.sleep(forTimeInterval: 0.5)

        subscription2.dispose()

        print("Disposed2")

        print("Ended ----")
    }
}
