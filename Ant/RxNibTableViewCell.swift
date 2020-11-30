//
//  RxNibTableViewCell.swift
//  Ant
//
//  Created by flqy on 2020/11/30.
//

import UIKit
import Reusable

class RxNibTableViewCell: UITableViewCell,NibReusable {

    @IBOutlet weak var nImageView: UIImageView!
    
    @IBOutlet weak var nNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
