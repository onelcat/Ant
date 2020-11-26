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


class AutoLayoutTableView: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewHeightLayoutConstraint: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(textView)

//        let label = UILabel()
//        label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: 200))

        textView.rx.text.changed.subscribe { (text) in
            debugPrint("输入框的文字变化",text)
            let newSize = self.textView.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            debugPrint("最新的高度", newSize)
            
//            self.textView.text = text
            self.textView.sizeToFit()
            
        } onError: { (_) in
            
        } onCompleted: {
            debugPrint("文字输入变化完成")
        } onDisposed: {
            
        }.disposed(by: disposeBag)

        
    }
    
}
