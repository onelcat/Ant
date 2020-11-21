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

struct MySection {
    var header: String
    var items: [Item]
}

// 发送高度

extension MySection : AnimatableSectionModelType {
    typealias Item = Int

    var identity: String {
        return header
    }

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
    
    func getHeight() -> Observable<CGFloat> {
        return Observable.create { (observer) -> Disposable in
            observer.onNext(10)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

class LocationTbaleViewCell: UITableViewCell,NibLoadable,Reusable {
    
    @IBOutlet weak var lImageView: UIImageView!
    
    @IBOutlet weak var lName: UILabel!
    
    @IBOutlet weak var fButton: UIButton!
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        debugPrint("初实话")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        debugPrint("进行布局连线")
        
    }
    
}

class CUITableViewCell:  UITableViewCell,Reusable {
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: { ds, tv, index, item in
                
                guard let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: index)as?LocationTbaleViewCell else {
                    fatalError()
                }
                
                cell.lName?.text = "Item \(item)"

                return cell
            },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
            }
        )

        self.dataSource = dataSource
        
        let sections = [
            MySection(header: "First section", items: [
                1,
                2
            ]),
            MySection(header: "Second section", items: [
                3,
                4
            ])
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
              .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe { (index) in
                
            }
            .disposed(by: disposeBag)


        
        tableView.rx.itemSelected
            .subscribe(onNext:{ [weak self] indexPath in
                debugPrint("点击按钮",indexPath)
//               self?.navigationController?.pushViewController(RxSearchVC(), animated: true)
            })
            .disposed(by:disposeBag)
//        tableView.rx.setDelegate(self)
//              .disposed(by: disposeBag)
    }
    
    
}

extension ViewController: UITableViewDelegate {
}


