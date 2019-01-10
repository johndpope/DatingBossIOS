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
    
    func clear() {
        name = nil
        phone = nil
        birthDate = nil
        gender = .male
        
        email = nil
        password = nil
        nickname = nil
        
        pictures.removeAll()
    }
}
