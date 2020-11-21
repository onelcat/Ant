//
//  ViewController.swift
//  Ant
//
//  Created by flqy on 2020/11/20.
//

import UIKit
import RxCocoa

import RxSwift

import RxDataSources
import Differentiator

// 不是
import Reusable

struct VCModel {
    var title: String
    var vc: UIViewController
}

struct SectionOfVC {
    var header: String
    var items: [Item]
}

extension SectionOfVC: SectionModelType {
    
  typealias Item = VCModel

   init(original: SectionOfVC, items: [Item]) {
    self = original
    self.items = items
  }
    
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionOfVC>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfVC>(
            configureCell: { ds, tv, index, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                
                cell.textLabel?.text = item.title
                
                return cell
            }
        )

        self.dataSource = dataSource
        

        let items = VCModel(title: "onelcat", vc: UIViewController())
        let sections = [SectionOfVC(header: "onelcat", items: [items])]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
              .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext:{ [weak self] indexPath in
                let vc = sections[0].items[indexPath.item].vc
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by:disposeBag)

    }
    
    
}

extension ViewController: UITableViewDelegate {
}


