//
//  ViewController.swift
//  Ant
//
//  Created by flqy on 2020/11/20.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift
import Reusable
import Differentiator

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = Int

    var identity: String {
        return header
    }

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

class LocationTbaleViewCell: UITableViewCell,Reusable {
    
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
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        tableView.register(cellType: LocationTbaleViewCell.self)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: { ds, tv, index, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell") as! LocationTbaleViewCell
                    
                
//                let date = Date(timeIntervalSince1970: <#T##TimeInterval#>)
                //?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
//                cell.textLabel?.text = "Item \(item)"
//                return cell
                
                // 自适应布局无效？
//                let cell: LocationTbaleViewCell = tv.dequeueReusableCell(for: index)
//                debugPrint("文字中绘制失败")
                
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

         
        tableView.rx.setDelegate(self)
              .disposed(by: disposeBag)
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        // you can also fetch item
        guard let item = dataSource?[indexPath],
        // .. or section and customize what you like
            dataSource?[indexPath.section] != nil
            else {
            return 0.0
        }

        return CGFloat(40 + item * 10)
    }
}


