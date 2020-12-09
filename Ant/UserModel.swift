//
//  UserModel.swift
//  Ant
//
//  Created by flqy on 2020/12/9.
//

import Foundation
import ObjectMapper
import UIKit
import YYModel
/*
 所有测试是当前数据模型
 经过测试: 归档 比 model -> json 存储json文件 快8倍
         解档 比 读取json文件 -> model 慢1倍
 
         归档的文件比 json文件 大一倍
 */

struct UserModel0:Mappable {
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        login <- map["login"]
        id <- map["id"]
        avatar_url <- map["avatar_url"]
        gravatar_id <- map["gravatar_id"]
        url <- map["url"]
        html_url <- map["html_url"]
        followers_url <- map["followers_url"]
        following_url <- map["following_url"]
        gists_url <- map["gists_url"]
        starred_url <- map["starred_url"]
        subscriptions_url <- map["subscriptions_url"]
        organizations_url <- map["organizations_url"]
        repos_url <- map["repos_url"]
        events_url <- map["events_url"]
        received_events_url <- map["received_events_url"]
        type <- map["type"]
        site_admin <- map["site_admin"]
        name <- map["name"]
        company <- map["company"]
        blog <- map["blog"]
        location <- map["location"]
        email <- map["email"]
        hireable <- map["hireable"]
        bio <- map["bio"]
        public_repos <- map["public_repos"]
        public_gists <- map["public_gists"]
        followers <- map["followers"]
        following <- map["following"]
    }
    
    var login: String?
    var id: Int?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin = false
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var public_repos: Int = 0
    var public_gists: Int = 0
    var followers: Int = 0
    var following: Int = 0
}


class UserModel1: NSObject ,NSCoding, NSSecureCoding,YYModel {
    func copy(with zone: NSZone? = nil) -> Any {
        return self.yy_modelCopy()!
    }
    
    
    // 必须要实现 NSSecureCoding 不然会报错 4866
    static var supportsSecureCoding: Bool {
        return true
    }
    
    override init() {
        super.init()
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
            self.init()
            self.yy_modelInit(with: aDecoder)
        
    }

    
    func encode(with coder: NSCoder) {
        self.yy_modelEncode(with: coder)
    }
    
//    required init?(coder: NSCoder) {
//        super.init()
//        self.yy_modelInit(with: coder)
//    }
    
//    override var hash: Int {
//        return Int(self.yy_modelHash())
//    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object else {
            return false
        }
        return self.yy_modelIsEqual(object)
    }
    
    override var description: String {
        return self.yy_modelDescription()
    }
    
    
    
//    func encode(with coder: NSCoder) {
//        coder.encode(login, forKey: "login")
//        coder.encode(id!, forKey: "i_id")//这里必须强制解包 不能是可选类型 int 类型不能是可选类型
//        coder.encode(avatar_url, forKey: "avatar_url")
//        coder.encode(gravatar_id, forKey: "gravatar_id")
//        coder.encode(url, forKey: "url")
//        coder.encode(html_url, forKey: "html_url")
//        coder.encode(followers_url, forKey: "followers_url")
//        coder.encode(following_url, forKey: "following_url")
//        coder.encode(gists_url, forKey: "gists_url")
//        coder.encode(starred_url, forKey: "starred_url")
//        coder.encode(subscriptions_url, forKey: "subscriptions_url")
//        coder.encode(organizations_url, forKey: "organizations_url")
//        coder.encode(repos_url, forKey: "repos_url")
//        coder.encode(events_url, forKey: "events_url")
//        coder.encode(received_events_url, forKey: "received_events_url")
//        coder.encode(type, forKey: "type")
//        coder.encode(name, forKey: "name")
//        coder.encode(company, forKey: "company")
//        coder.encode(blog, forKey: "blog")
//        coder.encode(location, forKey: "location")
//        coder.encode(email, forKey: "email")
//        coder.encode(hireable, forKey: "hireable")
//        coder.encode(bio, forKey: "bio")
//        coder.encode(site_admin, forKey: "site_admin")
//        coder.encode(public_repos, forKey: "public_repos")
//        coder.encode(public_gists, forKey: "public_gists")
//        coder.encode(followers, forKey: "followers")
//        coder.encode(following, forKey: "following")
//    }
//
//    required init?(coder: NSCoder) {
//
//        self.login = coder.decodeObject(forKey: "login") as? String
//        self.id = coder.decodeInteger(forKey: "i_id")
//        self.avatar_url = coder.decodeObject(forKey: "avatar_url") as? String
//        self.gravatar_id = coder.decodeObject(forKey: "gravatar_id") as? String
//        self.url = coder.decodeObject(forKey: "url") as? String
//        self.html_url = coder.decodeObject(forKey: "html_url") as? String
//        self.followers_url = coder.decodeObject(forKey: "followers_url") as? String
//        self.following_url = coder.decodeObject(forKey: "following_url") as? String
//        self.gists_url = coder.decodeObject(forKey: "gists_url") as? String
//        self.starred_url = coder.decodeObject(forKey: "starred_url") as? String
//        self.subscriptions_url = coder.decodeObject(forKey: "subscriptions_url") as? String
//        self.organizations_url = coder.decodeObject(forKey: "organizations_url") as? String
//        self.repos_url = coder.decodeObject(forKey: "repos_url") as? String
//        self.events_url = coder.decodeObject(forKey: "events_url") as? String
//        self.received_events_url = coder.decodeObject(forKey: "received_events_url") as? String
//        self.type = coder.decodeObject(forKey: "type") as? String
//        self.site_admin = coder.decodeBool(forKey: "site_admin")
//        self.name = coder.decodeObject(forKey: "name") as? String
//        self.company = coder.decodeObject(forKey: "company") as? String
//        self.blog = coder.decodeObject(forKey: "blog") as? String
//        self.location = coder.decodeObject(forKey: "location") as? String
//        self.email = coder.decodeObject(forKey: "email") as? String
//        self.hireable = coder.decodeObject(forKey: "hireable") as? String
//        self.bio = coder.decodeObject(forKey: "bio") as? String
//        self.public_repos = coder.decodeInteger(forKey: "public_repos")
//        self.public_gists = coder.decodeInteger(forKey: "public_gists")
//        self.followers = coder.decodeInteger(forKey: "followers")
//        self.following = coder.decodeInteger(forKey: "following")
//    }
    
    @objc var login: String?
    var id: Int?
    @objc var avatar_url: String?
    @objc var gravatar_id: String?
    @objc var url: String?
    @objc var html_url: String?
    @objc var followers_url: String?
    @objc var following_url: String?
    @objc var gists_url: String?
    @objc var starred_url: String?
    @objc var subscriptions_url: String?
    @objc var organizations_url: String?
    @objc var repos_url: String?
    @objc var events_url: String?
    @objc var received_events_url: String?
    @objc var type: String?
    @objc var site_admin = false
    @objc var name: String?
    @objc var company: String?
    @objc var blog: String?
    @objc var location: String?
    @objc var email: String?
    @objc var hireable: String?
    @objc var bio: String?
    @objc var public_repos: Int = 0
    @objc var public_gists: Int = 0
    @objc var followers: Int = 0
    @objc var following: Int = 0
}

class UserManager {
    static let shared =  UserManager()
    var user0: UserModel0?
    var user1: UserModel1?
    init() {}
    lazy var documentDirectory: String = {
        guard let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            fatalError()
        }
        return path
    }()

    // 225 byte read: 0.00019025802612304688 write: 0.001394033432006836 JSON字符串存取
    lazy var path0: String = {
        var root = NSString(string: documentDirectory)
        return root.appendingPathComponent("account.json")
    }()
    
    // 499 byte read: 0.0009238719940185547 write: 0.0009698867797851562 归档
    lazy var path1: String = {
        var root = NSString(string: documentDirectory)
        return root.appendingPathComponent("account.data")
    }()
    
    //629 byte read: 0.0002129077911376953 wirte: 0.001210927963256836 .plist文件
    lazy var path2: String = {
        var root = NSString(string: documentDirectory)
        return root.appendingPathComponent("account.plist")
    }()
    
    lazy var path3: String = {
        var root = NSString(string: documentDirectory)
        return root.appendingPathComponent("yy_account.json")
    }()
    
    func write0(_ data: UserModel0) {
        do {
            // 模型转字符串 太慢
            let json = data.toJSONString()!
            try json.write(toFile: self.path0, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            assert(false, error.localizedDescription)
        }
    }
    
    func read0() -> UserModel0? {
        do {
            let json = try String.init(contentsOfFile: self.path0, encoding: String.Encoding.utf8) // 0.0002009868621826172
            let model = Mapper<UserModel0>().map(JSONString: json)
            return model
        } catch let error {
            assert(false, error.localizedDescription)
            return nil
        }
    }
    
    // 归档 比 存json文件快 8倍
    func write1(_ data: UserModel1) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            let url1 = URL(fileURLWithPath: self.path1)
            
            try data.write(to: url1, options: .atomic)
        } catch let error {
            assert(false, error.localizedDescription)
        }
    }
    
    func read1() -> UserModel1? {
        do {
            let url1 = URL(fileURLWithPath: self.path1)
            let data = try Data.init(contentsOf: url1, options: [])
            let model = try NSKeyedUnarchiver.unarchivedObject(ofClass: UserModel1.self, from: data)
            return model
        } catch let error {
            debugPrint(error)
            assert(false, error.localizedDescription)
            return nil
        }
    }
    
    func write2(_ data: UserModel0) {
        let json = data.toJSON()
        let dic = NSDictionary(dictionary: json)
        dic.write(toFile: path2, atomically: true)
    }
    
    func read2() -> UserModel0? {
        let dic = NSDictionary(contentsOfFile: path2) as! [String : Any]
        return Mapper<UserModel0>().map(JSON: dic)
    }
    
    func write3(_ data: UserModel1) {
//        [user yy_modelToJSONObject];
        guard let json = data.yy_modelToJSONString() else {
            assert(false)
            return
        }
        
        do {
            try json.write(toFile: self.path3, atomically: true, encoding: .utf8)
        } catch let error {
            debugPrint(error)
            assert(false)
        }
        
    }
    
    func read3() -> UserModel1? {
        do {
            let json = try String.init(contentsOfFile: self.path3, encoding: .utf8)
            return UserModel1.yy_model(withJSON: json)
        } catch let error {
            debugPrint(error)
            assert(false)
        }
        
        
//        let json = data.yy_modelToJSONString()!
//        do {
//            try json.write(toFile: self.path3, atomically: true, encoding: .utf8)
//        } catch let error {
//            debugPrint(error)
//            assert(false)
//        }
        
    }
    
    static func modeTo(model: UserModel0) -> UserModel1 {
        let result = UserModel1()
        result.login = model.login
        result.id = model.id
        result.avatar_url = model.avatar_url
        result.gravatar_id = model.gravatar_id
        result.url = model.url
        result.html_url = model.html_url
        result.followers_url = model.followers_url
        result.following_url = model.following_url
        result.gists_url = model.gists_url
        result.starred_url = model.starred_url
        result.subscriptions_url = model.subscriptions_url
        result.organizations_url = model.organizations_url
        result.repos_url = model.repos_url
        result.events_url = model.events_url
        result.received_events_url = model.received_events_url
        result.type = model.type
        result.site_admin = model.site_admin
        result.name = model.name
        result.company = model.company
        result.blog = model.blog
        result.location = model.location
        result.email = model.email
        result.hireable = model.hireable
        result.bio = model.bio
        result.public_repos = model.public_repos
        result.public_gists = model.public_gists
        result.followers = model.followers
        result.following = model.following
        return result
    }
    
    static func test() {
        
        let paht = Bundle.main.path(forResource: "GithubUser.json", ofType: "")!
        let jsonStr = try! String.init(contentsOfFile: paht, encoding: String.Encoding.utf8)
        let user0 = Mapper<UserModel0>().map(JSONString: jsonStr)!
        let user1 = UserManager.modeTo(model: user0)

        let date0 = Date()
        UserManager.shared.write0(user0)
        date0.duration()
        
        let date1 = Date()
        UserManager.shared.write1(user1)
        date1.duration()
        
        let date2 = Date()
        UserManager.shared.write2(user0)
        date2.duration()
        
        let date3 = Date()
        UserManager.shared.write3(user1)
        date3.duration()
        
        debugPrint("---------------------------")
        
        let date00 = Date()
        let model0 = UserManager.shared.read0()
        date00.duration()


        let date01 = Date()
        let model1 = UserManager.shared.read1()
        date01.duration()
        
        
        let date02 = Date()
        let model2 = UserManager.shared.read2()
        date02.duration()
        
        let date03 = Date()
        let model3 = UserManager.shared.read3()
        date03.duration()
        
        debugPrint("-------------------------------")
//        print(model0, "\r\n" , model1,"\r\n", model2)
    }
}


