import RxSwift

example(of: "subScribe") {
    let observable = Observable.of(episodeIV, episodeV, episodeVI)
    
//    observable.subscribe { event in
//        print(event.element ?? event)
//    }
    
    observable.subscribe(onNext: { element in
        print(element)
    })
}

example(of: "empty") {
    let observable = Observable<Void>.empty()
    
    observable.subscribe(onNext: { element in
        print(element)
    }, onCompleted: {
        print("onCompleted")
    })
}

example(of: "never") {
    let observable = Observable<Any>.never()
    
    observable.subscribe(onNext: { element in
        print(element)
    }, onCompleted: {
        print("onCompleted never")
    })
}

example(of: "dispose") {
    let mostPopular = Observable.of(episodeV, episodeIV, episodeVI)
    
    let subscription = mostPopular.subscribe { event in
        print(event)
    }
    
    subscription.dispose()
}

example(of: "DisposeBag") {
    let disposeBag = DisposeBag()
    
    Observable.of(episodeVII, episodeI, rogueOne)
        .subscribe {
        print($0)
    }
        .disposed(by: disposeBag)
}

example(of: "create") {
    
    enum Droid: Error {
        case OU812
    }
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        
        observer.onNext("R2-D2")
        observer.onError(Droid.OU812)
        observer.onNext("C-3PO")
        observer.onNext("K-2SO")
//        observer.onCompleted()
        
        return Disposables.create()
    }
    .subscribe(
        onNext: { print($0) },
        onError: { print("Eror:", $0) },
        onCompleted: { print("onCompleted") },
        onDisposed: { print("onDisposed") }
    )
    .disposed(by: disposeBag)
}

//example(of: "Single") {
//    
//    let disposeBag = DisposeBag()
//    
//    enum FileReadError: Error {
//        case fileNotFound, unreadable, encodingFailed
//    }
//    
//    func loadText(from filename: String) -> Single<String> {
//        return Single.create { single in
//            let disposables = Disposables.create()
//            
//            guard let path = Bundle.main.path(forResource: filename, ofType: "txt") else {
//                single(.error(FileReadError.fileNotFound))
//                return disposables
//            }
//            
//            guard let data = FileManager.default.contents(atPath: path) else {
//                single(.error(FileReadError.unreadable))
//                return disposables
//            }
//            
//            guard let contents = String(data: data, encoding: .utf8)  else {
//                single(.error(FileReadError.encodingFailed))
//                return disposables
//            }
//            
//            single(.success(contents))
//            
//            return disposables
//        }
//    }
//    
//    loadText(from: "ANewHope")
//        .subscribe {
//            switch $0 {
//            case .success(let string):
//                print(string)
//            case .error(let erroe):
//                print(erroe)
//            }
//        }
//        .disposed(by: disposeBag)
//}
