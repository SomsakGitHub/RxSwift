//
//  APracticalIntroductionViewController.swift
//  RxSwiftLibrary
//
//  Created by somsak on 6/6/2564 BE.
//

import UIKit
import RxSwift

class APracticalIntroductionViewController: UIViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectCharacter(_ sender: Any) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "APracticalIntroductionDetailViewController") as! APracticalIntroductionDetailViewController
        
        detailVC.selectedCharacter
        .subscribe(onNext: { character in
            self.greetingsLabel.text = "Hello \(character)"
        }).disposed(by: disposeBag)
       
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
