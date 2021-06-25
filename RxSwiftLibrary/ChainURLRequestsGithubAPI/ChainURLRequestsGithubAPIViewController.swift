//
//  ChainURLRequestsGithubAPIViewController.swift
//  RxSwiftLibrary
//
//  Created by somsak on 7/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class ChainURLRequestsGithubAPIViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let githubRepository = GithubRepository()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let reposObservable = githubRepository.getRepos().share()
        
        print("reposObservable", reposObservable)
        
        let randomNumber = Int.random(in: 0...50)
        
        reposObservable.map { repos -> String in
            let repo = repos[randomNumber]
            return repo.owner.login + "/" + repo.name
        }
        
        
        .startWith("Loading...")
        .bind(to: navigationItem.rx.title)
        .disposed(by: disposeBag)

        reposObservable.flatMap { repos -> Observable<[Branch]> in
            
            let repo = repos[randomNumber]
            
            return self.githubRepository.getBranches(ownerName: repo.owner.login, repoName: repo.name)
        }.bind(to: tableView.rx.items(cellIdentifier: "branchCell", cellType: BranchTableViewCell.self)) { index, branch, cell in
            cell.branchNameLabel.text = branch.name
        }.disposed(by: disposeBag)
    }

}

struct Repo: Decodable {
    let name: String
    let owner: Owner
}

struct Owner: Decodable {
    let login: String
}

struct Branch: Decodable {
    let name: String
}

class GithubRepository {
    private let networkService = NetworkService()
    private let baseURLString = "https://api.github.com"
    
    func getRepos() -> Observable<[Repo]> {
        return networkService.execute(url: URL(string: baseURLString + "/repositories")!)
    }
    
    func getBranches(ownerName: String, repoName: String) -> Observable<[Branch]>{
        return networkService.execute(url: URL(string: baseURLString + "/repos/\(ownerName)/\(repoName)/branches")!)
    }
}

class NetworkService {
    func execute<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observable -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    return
                }
                
                observable.onNext(decoded)
                observable.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
