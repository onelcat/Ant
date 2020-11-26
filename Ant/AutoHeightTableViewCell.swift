//
//  AutoHeightTableViewCell.swift
//  Ant
//
//  Created by flqy on 2020/11/21.
//

import UIKit
import Reusable

class AutoHeightTableViewCell: UITableViewCell{

    @IBOutlet weak var textView:  UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        textView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
