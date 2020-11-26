//
//  AutoLayoutTableView.swift
//  Ant
//
//  Created by flqy on 2020/11/21.
//

import Foundation
import UIKit



class AutoLayoutTableView: UIViewController,UITextViewDelegate, TextViewTbCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var inputText:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
}

extension AutoLayoutTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoHeightTableViewCell", for: indexPath) as? AutoHeightTableViewCell else {
            fatalError()
        }
        debugPrint("重新设置", inputText)
        cell.textView.text = inputText
        cell.delegate = self
        cell.tableView = self.tableView
        return cell
    }
    
    func textViewChange(text: String) {
        self.inputText = text
        
//        self.tableView.reloadData()
    }
}
