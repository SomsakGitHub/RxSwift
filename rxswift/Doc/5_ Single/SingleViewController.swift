//
//  SingleViewController.swift
//  rxswift
//
//  Created by somsak on 12/8/2566 BE.
//

import UIKit
import RxSwift

class SingleViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doTask()
    }
    
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let task = URLSession.shared.dataTask(with: URL(string: "https://api.github.com/repos/\(repo)")!) { data, _, error in
                if let error = error {
                    single(.failure(error))
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                      let result = json as? [String: Any] else {
                    single(.failure(error!))
                    return
                }

                single(.success(result))
            }

            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
    
    func doTask(){
//        getRepo("ReactiveX/RxSwift")
//            .subscribe { event in
//                switch event {
//                    case .success(let json):
//                        print("JSON: ", json)
//                    case .failure(let error):
//                        print("Error: ", error)
//                }
//            }
//            .disposed(by: disposeBag)
        
        getRepo("ReactiveX/RxSwift")
            .subscribe(onSuccess: { json in
                           print("JSON: ", json)
                       },
                       onFailure: { error in
                           print("Error: ", error)
                       })
            .disposed(by: disposeBag)
    }

}
