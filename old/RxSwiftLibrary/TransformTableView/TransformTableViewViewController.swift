//
//  TransformTableViewViewController.swift
//  RxSwiftLibrary
//
//  Created by somsak on 7/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

struct Food {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

class TransformTableViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = Observable.just([
        Food.init(title: "aa"),
        Food.init(title: "bb")
        ])
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Menu"
        bindTableView()
    }

    func bindTableView(){
//        items.bind(
//            to: tableView.rx.items(
//                cellIdentifier: "foodCell", cellType: FoodTableViewCell.self))
//        { row, model, cell in
//            cell.textLabel?.text = model.title
//        }.disposed(by: bag)
//
//        tableView.rx.modelSelected(Food.self)
//            .subscribe(onNext: {
//
//            }, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//            .bind { product in
//            print("product", product.title)
//        }.disposed(by: bag)
    }
}
