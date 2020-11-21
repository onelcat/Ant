//
//  LayoutTabelViewCell.swift
//  Ant
//
//  Created by flqy on 2020/11/21.
//

import Foundation
import UIKit
import RxDataSources
import Differentiator
import RxCocoa
import RxSwift

struct DataSouce {
    var items: [Item]
}
extension DataSouce: SectionModelType {
    
  typealias Item = Int

   init(original: DataSouce, items: [Item]) {
    self = original
    self.items = items
  }
    
}

class AutoLayoutTableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    

    var dataSource: RxTableViewSectionedReloadDataSource<DataSouce>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "AutoHeightTableViewCell", bundle: nil), forCellReuseIdentifier: "AutoHeightTableViewCell")
        
        let dataSource = RxTableViewSectionedReloadDataSource<DataSouce>(
            configureCell: { ds, tv, index, item in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "AutoHeightTableViewCell", for: index) as? AutoHeightTableViewCell else {
                    fatalError()
                }
                return cell
            }
        )
        
        self.dataSource = dataSource
        let data = [DataSouce(items: [1])]
        
        Observable.just(data)
            .bind(to: tableView.rx.items(dataSource: dataSource))
              .disposed(by: DisposeBag())
        
        
    }
    
    
    
}
