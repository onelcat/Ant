//
//  TaskDetailsViewModel.swift
//  Ant
//
//  Created by flqy on 2020/12/3.
//

import RxMoya
import RxSwift
import Foundation
import ObjectMapper
import RxCocoa
import UIKit
import Kingfisher

extension UILabel{
    
    
    public var rx_text: ControlProperty<String> {
        let source: Observable<String> = self.rx.observe(String.self, "text").map { $0 ?? ""}
        let setter: (UILabel, String) -> Void = { $0.text = $1 }
        let bindingObserver = Binder(self, binding: setter)
        return ControlProperty<String>(values: source, valueSink: bindingObserver)
    }

}

// 静态数据只进行数据的显示
class TaskDetailsViewModel: ReactiveCompatible {
    
    let API = bangbangwoProvider
    
    let disposeBag = DisposeBag()
    
    let userAvatar: Binder<Resource?>
    
    let name: Binder<String?>
    
    let count: Binder<String?>
    
    let gold: Binder<String?>
    
    let warning: Binder<String?>
    
    let step1: Binder<String?>
    
    let qrImage: Binder<Resource?>
    
    let step2: Binder<String?>
    
    let code: Binder<String?>
    
    let sampleImage: Binder<Resource?>
    
    
    
    private var dataSouce: TaskDetailsModel? {

        didSet {
            bindTo()
        }
    }
    
    private var isBind = false
    func bindTo() {
        if isBind { return }
        self.isBind = true
        let avatar = BehaviorRelay<Resource?>(value: self.dataSouce?.avatarUrl)
        avatar.bind(to: self.userAvatar).disposed(by: disposeBag)

//        avatar.on

        // 发送出数据
        let name = BehaviorRelay<String?>(value: self.dataSouce?.taskTitle).asDriver().distinctUntilChanged()
        name.drive(self.name).disposed(by: disposeBag)
        
        let step1 = BehaviorRelay<String?>(value: self.dataSouce?.taskStepDescArray[0]).asDriver().distinctUntilChanged()
        step1.drive(self.step1).disposed(by: disposeBag)
    }
    
    init(userAvatar: Binder<Resource?>, name: Binder<String?>, count: Binder<String?>, gold: Binder<String?>, warning: Binder<String?>, step1: Binder<String?>, qrImage: Binder<Resource?>, step2: Binder<String?>, code: Binder<String?>, sampleImage: Binder<Resource?>) {
        
        self.userAvatar = userAvatar
        self.name = name
        self.count = count
        self.gold = gold
        self.warning = warning
        self.step1 = step1
        self.qrImage = qrImage
        self.step2 = step2
        self.code = code
        self.sampleImage = sampleImage
        

        // 获取任务详情
        API.rx.request(.taskDetails(nil, ""))
            .mapObject(ResponseData<TaskDetailsModel>.self)
            .subscribe { [weak self] (response) in
                guard let self = self else {return}
                debugPrint("获取任务详情", response.head.code)
                guard response.head.code == 200 else {
                    assert(false,response.head.msg)
                    return
                }
                
                self.dataSouce = response.data
                
            } onError: { (error) in
                debugPrint("需要显示错误",error.localizedDescription)
            }
            .disposed(by: disposeBag)

        
        
        
    }
    
    
    
    
}

extension Reactive where Base: TaskDetailsViewModel {

    func read(uID: String?, taskID: String) -> Single<ResponseData<TaskDetailsModel>> {
        return base.API.rx.request(.taskDetails(uID, taskID)).mapObject(ResponseData<TaskDetailsModel>.self)
    }
    
}
