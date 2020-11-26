//
//  ViewController.swift
//  Ant
//
//  Created by flqy on 2020/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var vc: AutoLayoutTableView = {
        return AutoLayoutTableView()
    }()
    
    let dataSource = ["AutoLayoutTableView","ScrollViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        tableView.register(UINib(nibName: "AutoHeightTableViewCell", bundle: nil), forCellReuseIdentifier: "AutoHeightTableViewCell")

//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    @objc private
//    func keyboardWillShow(_ notification: Notification?) {
//        debugPrint("显示键盘")
//    }
//
//    @objc private
//    func keyboardWillHide(_ notification: Notification?) {
//        debugPrint("隐藏键盘")
//    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.item]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = AutoLayoutTableView()
        let id = self.dataSource[indexPath.item]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    
}




