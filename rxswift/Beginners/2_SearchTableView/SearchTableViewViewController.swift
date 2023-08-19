//
//  SearchTableViewViewController.swift
//  rxswift
//
//  Created by somsak on 18/8/2566 BE.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchTableViewViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let tableViewItems = BehaviorRelay.init(value: [Food.init(name: "name 1", image: "image 1"),
                                                    Food.init(name: "name 2", image: "image 2")])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setBar()
        //selectedCell()
    }
    
    func setBar(){
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { query in
                self.tableViewItems.value.filter { food in
                    query.isEmpty || food.name.lowercased().contains(query.lowercased())
                }
            }
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "myCellData")){
                    (tv, tableViewItem, cell) in
                    print(RxSwift.Resources.total)
                    cell.textLabel?.text = tableViewItem.name
            }.disposed(by: disposeBag)
    }
    
    func selectedCell(){
        tableView
            .rx
            .modelSelected(Food.self)
            .subscribe(onNext: {
                foodObject in
                print("foodObject=>", foodObject)
            }).disposed(by: disposeBag)
    }

}
