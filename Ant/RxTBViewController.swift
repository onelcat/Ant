//
//  RxTBViewController.swift
//  Ant
//
//  Created by flqy on 2020/11/30.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

struct CustomData {
    var image: UIImage
    var name:String
}

struct SectionOfCustomData {
  var header: String
  var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = CustomData

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}

class RxTBViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellType: RxNibTableViewCell.self)
        tableView.register(cellType: RxTableViewCell.self)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
          configureCell: { dataSource, tableView, indexPath, item in

            if indexPath.item == 0 {
                let cell:RxNibTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.nImageView.image = dataSource[indexPath.section].items[indexPath.item].image
                cell.nNameLabel.text = dataSource[indexPath.section].items[indexPath.item].name
                return cell
            }
            if indexPath.item == 1 {
                let cell:RxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.imageView?.image = dataSource[indexPath.section].items[indexPath.item].image
                cell.textLabel?.text = dataSource[indexPath.section].items[indexPath.item].name
                return cell
            }
            fatalError()
        })

        let item = SectionOfCustomData(header: "tou", items: [CustomData(image: #imageLiteral(resourceName: "qing-xiao-s503"), name: "女帝"),CustomData(image: #imageLiteral(resourceName: "qing-xiao-s503"), name: "女帝")])
        
        let sections: [SectionOfCustomData] = [item]
        
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
//    }
        // Do any additional setup after loading the view.
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
