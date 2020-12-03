//
//  TaskDetailsViewController.swift
//  Ant
//
//  Created by flqy on 2020/12/2.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import RxMoya
import Kingfisher
import SnapKit



// TODO: 删除tupian按钮
class TaskDetailsViewController: UIViewController {
    
    var taskID:  Int?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var bgImageViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var bgView0TopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bgView0: UIView!
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!

    @IBOutlet weak var goldLabel: UILabel!
    
    @IBOutlet weak var bgView1: UIView!
    
    @IBOutlet weak var taskContentView0: UIView!
    
    @IBOutlet weak var taskContentView1: UIView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var step1Label: UILabel!
    
    @IBOutlet weak var step1TipView: UIView!
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    @IBOutlet weak var saveQRButton: UIButton!
    
    @IBOutlet weak var saveQRLabel: UILabel!
    
    @IBOutlet weak var shareQRButton: UIButton!
    
    @IBOutlet weak var shareQRLabel: UILabel!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var shareCodeButton: UIButton!
    
    @IBOutlet weak var openCodeButton: UIButton!
    
    @IBOutlet weak var step2Label: UILabel!
    
    @IBOutlet weak var step2TipView: UIView!
    
    @IBOutlet weak var sampleImageView: UIImageView!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var removeButton: UIButton!
    
    private var dataSource: TaskDetailsModel?
//    {
//        didSet {
//            guard let data = self.dataSource else {
//                return
//            }
//            let aurl = data.avatarUrl!
////            userAvatarImageView.kf.setImage(with: URL(string: aurl))
//
//            nameLabel.text = data.taskTitle
//
//            countLabel.text = "剩余数量：\(data.surplusTaskTotal!)/\(data.taskInitTotalApprovalNum!)"
//
//            goldLabel.text = "+\(data.taskUnitPrice!)"
//
//            step1Label.text = data.taskStepDescArray[0]
//            step2Label.text = data.taskStepDescArray[1]
//
//
////            sampleImageView.kf.setImage(with: )
//
//            if let url = data.accepTaskImgUrl {
//
////                myImageView.kf.setImage(with: URL(string: url))
//
//                addButton.isHidden = true
//                myImageView.isHidden = false
//
//            } else {
//
//                addButton.isHidden = false
//                myImageView.isHidden = true
//
//            }
//
//            let pushUniqueId  = data.pushUniqueId
//
//            if data.taskContentType == 1 || data.taskContentType == 3 {
//                // 口令 网址
//                taskContentView0.isHidden = true
//                taskContentView1.isHidden = false
//
//                if data.taskContentType == 1 {
//                    // //1-网页任务
////                    codeLabel.text = data.taskAccessWebUrl?.absoluteString
//                }
//                else if data.taskContentType == 3 {
//                    //口令
//                    codeLabel.text = data.taskAccessWordContent!
//                } else {
//                    assert(false)
//                }
//
//                let butAr = data.buttonShowInfo
//                if butAr.count == 0 { //没有返回按钮 默认一个复制链接按钮
//                    shareCodeButton.isHidden = true
//
//                    openCodeButton.isHidden = false
//                    openCodeButton.setTitle("复制链接", for: .normal)
//                } else
//                if butAr.count == 1 {
//                    shareCodeButton.isHidden = true
//
//                    openCodeButton.isHidden = false
//                    openCodeButton.setTitle(butAr[0].buttonName, for: .normal)
//                }
//                else if butAr.count == 2 {
//                    shareCodeButton.isHidden = false
//                    shareCodeButton.setTitle(butAr[0].buttonName, for: .normal)
//
//                    openCodeButton.isHidden = false
//                    openCodeButton.setTitle(butAr[1].buttonName, for: .normal)
//                } else {
//                    // 当前版本 最多只有2个按钮
//                    assert(false)
//                }
//
//
//            } else {
//                // 二维码
//                taskContentView0.isHidden = false
//                taskContentView1.isHidden = true
//
////                if let urlStr = data.taskAccessImgUrl,let imageURL = URL(string: urlStr) {
////                    self.qrImageView.kf.setImage(with: imageURL)
////                }
//
//                if data.taskContentType == 4 {
//
//                    self.saveQRButton.isHidden = true
//                    self.shareQRButton.isHidden = true
//
//                    self.saveQRLabel.isHidden = true
//                    self.shareQRLabel.isHidden = true
//
//                } else {
//
//                    self.saveQRButton.isHidden = false
//                    self.shareQRButton.isHidden = false
//
//                    self.saveQRLabel.isHidden = false
//                    self.shareQRLabel.isHidden = false
//
//                }
//
//                qrImageView.layer.cornerRadius = 8.0
//                qrImageView.layer.borderWidth = 1.0
//                qrImageView.layer.borderColor = #colorLiteral(red: 0.01176470588, green: 0.5960784314, blue: 1, alpha: 1)
//                qrImageView.contentMode = .scaleToFill
//                qrImageView.clipsToBounds = true
//            }
//
//
//        }
//    }

    
    static func instantiateViewController() -> TaskDetailsViewController {
        let sb = UIStoryboard(name: "TaskInfo", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TaskDetailsViewController") as! TaskDetailsViewController
        return vc
    }
    
    var vm: TaskDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
        scrollView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
        }
        bgView0TopConstraint.constant = 8 + 88
        
        bgView0.layer.shadowColor = #colorLiteral(red: 0, green: 0.4392156863, blue: 0.5725490196, alpha: 0.2)
        bgView0.layer.borderWidth = 1.0
        bgView0.layer.borderColor = #colorLiteral(red: 0.6078431373, green: 0.831372549, blue: 0.9764705882, alpha: 1)
        
        sampleImageView.layer.borderWidth = 1
        sampleImageView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490731359, blue: 0.9489092231, alpha: 1)
        sampleImageView.contentMode = .scaleToFill
        
        qrImageView.layer.borderWidth = 1
        qrImageView.layer.borderColor = #colorLiteral(red: 0.7475480437, green: 0.8955097795, blue: 0.9967898726, alpha: 1)
        
        myImageView.layer.borderWidth = 1
        myImageView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490731359, blue: 0.9489092231, alpha: 1)
        myImageView.contentMode = .scaleToFill

        let ma = NSMutableAttributedString()
        let atr0 = NSAttributedString(string: "注意！所有加QQ微信/淘宝刷单/拆红包必中，",
                                      attributes:
                                        [NSAttributedString.Key.font :
                                            UIFont.systemFont(ofSize: 14),
                                         NSAttributedString.Key.foregroundColor:
                                            #colorLiteral(red: 0.5058823529, green: 0.5058823529, blue: 0.5058823529, alpha: 1)
        ])
        let atr1 = NSAttributedString(string: "全是骗子！勿贪便宜！不要付款！",
                                      attributes:
                                        [NSAttributedString.Key.font :
                                            UIFont.systemFont(ofSize: 14),
                                         NSAttributedString.Key.foregroundColor:
                                            #colorLiteral(red: 0.3098039216, green: 0.7176470588, blue: 1, alpha: 1)
        ])
        ma.append(atr0)
        ma.append(atr1)
        warningLabel.attributedText = ma
//        userAvatarImageView.rx.image.orEmpty
//        nameLabel.rx.text
        vm = TaskDetailsViewModel(userAvatar: userAvatarImageView.kf.rx.image(), name: nameLabel.rx.text, count: countLabel.rx.text, gold: goldLabel.rx.text, warning: warningLabel.rx.text, step1: step1Label.rx.text, qrImage: self.qrImageView.kf.rx.image(), step2: step2Label.rx.text, code: codeLabel.rx.text, sampleImage: sampleImageView.kf.rx.image())

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bgView0.layer.cornerRadius = 8.0
        bgView0.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner,.layerMaxXMinYCorner])

        bgView1.layer.cornerRadius = 8.0
        bgView1.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
    }
    
    // MARK: 读取任务详情
    private
    func read() {
        
    }
    
}

extension TaskDetailsViewController: UIScrollViewDelegate {
    
}
