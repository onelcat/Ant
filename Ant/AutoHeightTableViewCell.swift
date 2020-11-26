//
//  AutoHeightTableViewCell.swift
//  Ant
//
//  Created by flqy on 2020/11/21.
//

import UIKit
import Reusable

protocol TextViewTbCellDelegate {
    func textViewChange(text: String)
}

class AutoHeightTableViewCell: UITableViewCell{

    @IBOutlet weak var textView:  UITextView!
    
    weak var tableView: UITableView?
    
    var delegate:TextViewTbCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        // 必须设置为no 才可以
        textView.isScrollEnabled = false;
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension AutoHeightTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        debugPrint("我输入的问题",textView.text,text)
        self.tableView?.beginUpdates()
        delegate?.textViewChange(text: text)
        textView.sizeToFit()
        self.tableView?.endUpdates()
        // 可以设置输入框的长度
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
