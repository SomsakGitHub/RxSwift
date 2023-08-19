//
//  DebugMemoryLeakViewController.swift
//  rxswift
//
//  Created by somsak on 19/8/2566 BE.
//

import UIKit
import RxSwift
import RxCocoa

class DebugMemoryLeakViewController: UIViewController {
    
    @IBOutlet weak var text: UILabel!
    let name: BehaviorRelay = BehaviorRelay(value: "")
    let dis = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        name.map ({ name in
            print(RxSwift.Resources.total)
            return "AAA"
        }).bind(to: text.rx.text)
            .disposed(by: dis)
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
