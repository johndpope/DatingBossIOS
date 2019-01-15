//
//  UserPayload.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

struct UserPictureData {
    let image: UIImage?
    let imageUrl: String?
    let picture_idx: String
}

class UserPayload: NSObject {
    static let shared = UserPayload()
    
    var name: String?
    var phone: String?
    var birthDate: Double?
    var gender: Gender = .male
    
    var email: String?
    var password: String?
    var nickname: String?
    
    var pictures = [UserPictureData]()
    
    var height: Int?
    var shape: AppData?
    var blood: String?
    var region: AppData?
    var education: AppData?
    var educationDetail: String?
    var job: AppData?
    var jobDetail: String?
    var wage: AppData?
    var religion: AppData?
    var hobby = [AppData]()
    var drinking: AppData?
    var smoking: AppData?
    var introduction: String?
    
    override init() {
        super.init()
    }
    
    func clear() {
        name = nil
        phone = nil
        birthDate = nil
        gender = .male
        
        email = nil
        password = nil
        nickname = nil
        
        pictures.removeAll()
        
        height = nil
        shape = nil
        blood = nil
        region = nil
        education = nil
        educationDetail = nil
        job = nil
        jobDetail = nil
        wage = nil
        religion = nil
        hobby.removeAll()
        drinking = nil
        smoking = nil
        introduction = nil
    }
    
    func loadFromDatabase() {
        clear()
        
        let signupData = QDataManager.shared.signupData
        
        name = signupData["name"] as? String
        phone = signupData["phone"] as? String
        birthDate = signupData["birthDate"] as? Double
        if let value = signupData["gender"] as? String {
            gender = Gender(rawValue: value) ?? .male
        }
        
        email = signupData["email"] as? String
        password = signupData["password"] as? String
        nickname = signupData["nickname"] as? String
        
        height = signupData["height"] as? Int
        if let value = signupData["shape"] as? [String:Any] {
            shape = AppData(with: value)
        }
        blood = signupData["blood"] as? String
        if let value = signupData["region"] as? [String:Any] {
            region = AppData(with: value)
        }
        if let value = signupData["education"] as? [String:Any] {
            education = AppData(with: value)
        }
        educationDetail = signupData["educationDetail"] as? String
        if let value = signupData["job"] as? [String:Any] {
            job = AppData(with: value)
        }
        jobDetail = signupData["jobDetail"] as? String
        if let value = signupData["wage"] as? [String:Any] {
            wage = AppData(with: value)
        }
        if let value = signupData["religion"] as? [String:Any] {
            religion = AppData(with: value)
        }
        
        hobby.removeAll()
        if let hobbies = signupData["hobby"] as? [[String:Any]] {
            hobby.append(contentsOf: hobbies.map({ (item) -> AppData in
                return AppData(with: item)
            }))
        }
        
        if let value = signupData["drinking"] as? [String:Any] {
            drinking = AppData(with: value)
        }
        if let value = signupData["smoking"] as? [String:Any] {
            smoking = AppData(with: value)
        }
        introduction = signupData["introduction"] as? String
    }
    
    func commit() {
        var dataDict = [String:Any]()
        
        dataDict["name"] = name
        dataDict["phone"] = phone
        dataDict["birthDate"] = birthDate
        dataDict["gender"] = gender.rawValue
        
        dataDict["email"] = email
        dataDict["password"] = password
        dataDict["nickname"] = nickname
        
        dataDict["height"] = height
        dataDict["shape"] = shape?.rawData
        dataDict["blood"] = blood
        dataDict["region"] = region?.rawData
        dataDict["education"] = education?.rawData
        dataDict["educationDetail"] = educationDetail
        dataDict["job"] = job?.rawData
        dataDict["jobDetail"] = jobDetail
        dataDict["wage"] = wage?.rawData
        dataDict["religion"] = religion?.rawData
        dataDict["hobby"] = hobby.map({ (item) -> [String:Any] in
            return item.rawData
        })
        dataDict["drinking"] = drinking?.rawData
        dataDict["smoking"] = smoking?.rawData
        dataDict["introduction"] = introduction
        
        QDataManager.shared.signupData = dataDict
        QDataManager.shared.commit()
    }
}
