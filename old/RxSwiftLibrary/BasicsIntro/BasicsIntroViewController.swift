//
//  BasicsIntroViewController.swift
//  RxSwiftLibrary
//
//  Created by somsak on 7/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

struct Product {
    let title: String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItems(){
        let products = [
            Product(title: "aaa"),
            Product(title: "bbb"),
            Product(title: "ccc")
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
}

class BasicsIntroViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let productViewModel = ProductViewModel()
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindTableView()
    }
    
    func bindTableView(){
        productViewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "productCell",
                cellType: BasicsTableViewCell.self))
        { row, model, cell in
            cell.textLabel?.text = model.title
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Product.self).bind { product in
            print("product", product.title)
        }.disposed(by: bag)
        
        productViewModel.fetchItems()
    }
}
