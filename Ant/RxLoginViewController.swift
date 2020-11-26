//
//  RxLoginViewController.swift
//  Ant
//
//  Created by flqy on 2020/11/26.
//

import UIKit
import RxCocoa
import RxSwift

class RxLoginViewController: UIViewController {

    @IBOutlet weak var invalidUserNameLabel:UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var invalidPasswordLabel:UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 根据获取的数据 创建观察序列
        let invalidUserName = userNameTextField.rx.text.orEmpty.map({ $0.count > 10}).share(replay: 1)

        // 观察序列绑定到需要进行观察的数据
        _ = invalidUserName.bind(to: invalidUserNameLabel.rx.isHidden).disposed(by: disposeBag)

        let invalidPassword = passwordTextField.rx.text.orEmpty.map({ $0.count > 10}).share(replay: 1)
        
        invalidPassword.bind(to: invalidPasswordLabel.rx.isHidden).disposed(by: disposeBag)
        
        invalidPassword.subscribe { (event) in
            switch event {
            
            case let .next(value):
                debugPrint("result",value)
            case let .error(error):
                debugPrint("错误",error)
                break
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
        
        let loginValid = Observable.combineLatest(invalidUserName, invalidPassword) { !$0 || !$1}.share(replay: 1)
        
        _ = loginValid.bind(to: loginButton.rx.isHidden).disposed(by: disposeBag)
        
    }
    
}
