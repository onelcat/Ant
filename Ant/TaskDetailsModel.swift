//
//  TaskDetailsModel.swift
//  Ant
//
//  Created by flqy on 2020/12/3.
//
import RxMoya
import RxSwift
import Foundation
import ObjectMapper

struct TaskInfoButtonShowInfoModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        buttonName <- map["buttonName"]
        buttonType <- map["buttonType"]
    }
    
    var buttonName: String?
    /// 1-打开链接 2-微信 3-QQ 4-复制 5 打开app助力
    var buttonType: Int = 4
}

struct TaskDetailsModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        taskStatus <- map["taskStatus"]
        taskLaunchStatus <- map["taskLaunchStatus"]
        accepTaskId <- map["accepTaskId"]
        accepTaskImgUrl <- (map["accepTaskImgUrl"], URLTransform())
        avatarUrl <- (map["avatarUrl"], URLTransform())
        id <- map["id"]
        taskTitle <- map["taskTitle"]
        taskUnitPrice <- map["taskUnitPrice"]
        taskIconUrl <- (map["taskIconUrl"], URLTransform())
        taskAccessWebUrl <- (map["taskAccessWebUrl"], URLTransform())
        taskAccessImgUrl <- (map["taskAccessImgUrl"], URLTransform())
        taskSampleImgUrl <- (map["taskSampleImgUrl"], URLTransform())
        surplusTaskTotal <- map["surplusTaskTotal"]
        taskActualTotalApprovalNum <- map["taskActualTotalApprovalNum"]
        taskEffectiveTime <- map["taskEffectiveTime"]
        taskStepDescArray <- map["taskStepDescArray"]
        taskTutorialUrl <- (map["taskTutorialUrl"], URLTransform())
        taskLinkBrowserButtonShowStatus <- map["taskLinkBrowserButtonShowStatus"]
        taskLinkWeixinButtonShowStatus <- map["taskLinkWeixinButtonShowStatus"]
        taskAuditRemark <- map["taskAuditRemark"]
        pushUniqueId <- map["pushUniqueId"]
        taskRecommendStatus <- map["taskRecommendStatus"]
        iosCallPkgName <- map["iosCallPkgName"]
        aosCallPkgName <- map["aosCallPkgName"]
        appCallButtonName <- map["appCallButtonName"]
        appCallName <- map["appCallName"]
        taskQQButtonShowStatus <- map["taskQQButtonShowStatus"]
        taskCopyButtonShowStatus <- map["taskCopyButtonShowStatus"]
        buttonName <- map["buttonName"]
        buttonType <- map["buttonType"]
        taskAuditStatus <- map["taskAuditStatus"]
        taskContentType <- map["taskContentType"]
        taskInitTotalApprovalNum <- map["taskInitTotalApprovalNum"]
        taskStepDesc <- map["taskStepDesc"]
        taskSubType <- map["taskSubType"]
        taskSubTypeName <- map["taskSubTypeName"]
        userId <- map["userId"]
        buttonShowInfo <- map["buttonShowInfo"]
        taskAccessWordContent <- map["taskAccessWordContent"]
    }
   
    
    /// "接任务状态：-1没接任务 0未提交 1-各各中 2-各各通过 3-已过期 4-各各失败 5-再次提交 6-提交申诉7-申诉失败 8-申诉成功（没接任务没有）"
    var taskStatus: Int?
    /// 任务自身状态：1-投放中 2-已结束 3-已关闭
    var taskLaunchStatus: Int?
    /// 接收任务ID（没接任务没有）
    var accepTaskId: Int?
    /// 提交各各的图片（没提交各各没有）
    var accepTaskImgUrl: URL?
    /// 用户头像
    var avatarUrl: URL?
    /// 任务ID
    var id: Int?
    /// 任务标题
    var taskTitle: String?
    /// 任务单次佣金
    var taskUnitPrice: Int?
    /// icon
    var taskIconUrl: URL?
    /// 任务访问网址URL
    var taskAccessWebUrl: URL?
    /// 任务访问二维码（小程序码）图片URL
    var taskAccessImgUrl: URL?
    /// 任务示意图图片URL
    var taskSampleImgUrl: URL?
    /// 任务剩余数
    var surplusTaskTotal: Int?
    /// 任务完成数
    var taskActualTotalApprovalNum: Int?
    
    /// 任务时长
    var taskEffectiveTime: Int?
    /// 任务步骤描述
    var taskStepDescArray:[String] = []
    /// 任务教程URL
    var taskTutorialUrl: URL?
    /// 任务链接浏览器打开按钮显示状态 0-不显示 1-显示
    var taskLinkBrowserButtonShowStatus: Int?
    /// 任务链接在微信打开按钮显示状态 0-不显示 1-显示
    var taskLinkWeixinButtonShowStatus: Int?
    /// 各各备注
    var taskAuditRemark: String?
    /// 发布者ID
    var pushUniqueId: String?
    /// 是否热门 0-否 1-是
    var taskRecommendStatus: Int?
    /// ios包名
    var iosCallPkgName: String?
    /// 安卓包名
    var aosCallPkgName: String?
    /// 口令任务详情的按钮名字
    var appCallButtonName: String?
    /// 口令任务调用的APP名字
    var appCallName: String?
    /// 复制按钮 0-隐藏 1-显示
    var taskQQButtonShowStatus: Int?
    /// QQ分享按钮 0-隐藏 1-显示
    var taskCopyButtonShowStatus: Int?
    /// 按钮名称
    var buttonName: String?
    /// "按钮类型 1-打开链接 2-微信3-QQ 4-复制 5-第三方APP"
    var buttonType: Int?
    
    var taskAccessWordContent: String?
    var buttonShowInfo: [TaskInfoButtonShowInfoModel] = []
    var taskAuditStatus: Int?
    var taskContentType: Int?
    var taskInitTotalApprovalNum: Int?
    var taskStepDesc: String?
    var taskSubType: Int?
    var taskSubTypeName: String?
    var userId: Int?
}

