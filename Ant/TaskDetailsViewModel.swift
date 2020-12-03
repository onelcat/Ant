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
    
    
    
    private var dataSouce: TaskDetailsModel?
    
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
        
        
        let avatar = BehaviorRelay<Resource?>(value: self.dataSouce?.avatarUrl).asDriver()
        
        avatar.drive(self.userAvatar).disposed(by: disposeBag)

        let name = BehaviorRelay<String?>(value: self.dataSouce?.taskTitle).asDriver().distinctUntilChanged()
        name.drive(self.name).disposed(by: disposeBag)
        
        
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
