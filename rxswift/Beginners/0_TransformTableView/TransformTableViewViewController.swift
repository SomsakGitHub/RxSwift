//
//  TransformTableViewViewController.swift
//  rxswift
//
//  Created by somsak on 14/8/2566 BE.
//

import UIKit
import RxSwift
import RxCocoa

class TransformTableViewViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableViewItems = Observable.just([Food.init(name: "name 1", image: "image 1")])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTable()
        selectedCell()
    }
    
    func setTable(){
        tableViewItems.bind(to: tableView
            .rx
            .items(cellIdentifier: "myCell")){
                (tv, tableViewItem, cell) in
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

struct Food {
    let name: String
    let image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
