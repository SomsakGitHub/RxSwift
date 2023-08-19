//
//  SharingSubscriptionViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class SharingSubscriptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doSharingSubscription()
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
    
    func doSharingSubscription(){
        let counter = myInterval(.milliseconds(100))
            .share(replay: 1)

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

        Thread.sleep(forTimeInterval: 0.5)

        subscription2.dispose()

        print("Ended ----")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
