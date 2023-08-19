//
//  SubjectsAndRelaysViewController.swift
//  rxswift
//
//  Created by somsak on 18/8/2566 BE.
//

import UIKit
import RxSwift
import RxRelay

class SubjectsAndRelaysViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //publishSubject()
        //behaviorSubject()
        //replaySubject()
        //asyncSubject()
        //publishRelay()
        behaviorRelay()
    }
    
    func publishSubject(){
        //Starts empty and only emits new elements to subscribers.
        let pSub = PublishSubject<String>()
        pSub.onNext("pSub")
        
        let obj = pSub.subscribe(onNext: {
            e in
            print(e)
        })
        
        pSub.onNext("pSub 0")
    }
    
    func behaviorSubject(){
        //Starts with an initial value and replays it or the latest element to new subscribers.
        let bSub = BehaviorSubject<String>(value: "bSub")
        
        let obj = bSub.subscribe(onNext: {
            e in
            print(e)
        })
    }
    
    func replaySubject(){
        //Initialized with a buffer size and will maintain a buffer of elements up to that size and replay it to new subscribers.
        let rSub = ReplaySubject<Int>.create(bufferSize: 3)
        rSub.onNext(1)
        rSub.onNext(2)
        rSub.onNext(3)
        rSub.onNext(4)

        let obj = rSub.subscribe(onNext: {
            e in
            print(e)
        })
    }
    
    func asyncSubject(){
        // An AsyncSubject emits the last value (and only the last value) emitted by the source Observable,
        // and only after that source Observable completes.
        let aSub = AsyncSubject<String>()
        aSub.onNext("aSub")
        aSub.onNext("aSub 0")

        aSub.onCompleted()

        let obj = aSub.subscribe(onNext: {
            e in
            print(e)
        })
    }
    
    func publishRelay(){
        // Unlike `PublishSubject` it can't terminate with error or completed.
        let pSubR = PublishRelay<String>()
        pSubR.accept("pSubR")

        let obj = pSubR.subscribe(onNext: {
            e in
            print(e)
        })
        
        pSubR.accept("pSubR 0")
    }
    
    func behaviorRelay(){
        // Unlike `BehaviorSubject` it can't terminate with error or completed.
        let bR = BehaviorRelay<String>(value: "bR")

        let obj = bR.subscribe(onNext: {
            e in
            print(e)
        })
        
        bR.accept("bR 0")
    }
}
