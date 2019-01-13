//
//  UserPayload.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class UserPayload: NSObject {
    static let shared = UserPayload()
    
    var name: String?
    var phone: String?
    var birthDate: Double?
    var gender: Gender = .male
    
    var email: String?
    var password: String?
    var nickname: String?
    
    var pictures = [UIImage]()
    
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
        
    }
}
