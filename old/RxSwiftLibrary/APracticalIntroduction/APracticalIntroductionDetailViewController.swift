//
//  APracticalIntroductionDetailViewController.swift
//  RxSwiftLibrary
//
//  Created by somsak on 6/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class APracticalIntroductionDetailViewController: UIViewController {
    
    private let selectedCharacterVariable = BehaviorRelay(value: "User")

    var selectedCharacter:Observable<String> {
        return self.selectedCharacterVariable.asObservable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func characterSelected(_ sender: UIButton) {
        guard let characterName = sender.titleLabel?.text else {return}
        
        self.selectedCharacterVariable.accept(characterName)
    }

}
