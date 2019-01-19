//
//  UserData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 04/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import Foundation

enum SignupStatus: String {
    case unknown = ""
    case complete = "y"
    case denied = "n"
    case pending = "r"
    case profile = "p"
    case survey = "s"
    case looks = "l"
}

class MyData: UserData {
    static let shared = MyData()
    
    func setMyInfo(with dict: [String:Any], reset: Bool = false) {
        super.updateData(with: dict, reset: reset)
        
        if auth_key != nil {
            QHttpClient.addCommonHeaderValue(self.auth_key!, for: "auth_key")
        } else {
            _ = QHttpClient.removeCommonHeaderValue(for: "auth_key")
        }
    }
    
    override func reloadData(_ completion: ((Bool) -> Void)? = nil) {
        
    }
    
    func clear() {
        setMyInfo(with: [:], reset: true)
    }
    
    var new_gather: Int {
        get {
            return rawData["new_gather"] as? Int ?? -1
        } set {
            rawData["new_gather"] = newValue
        }
    }
    
    var bonus_fl: Bool {
        get {
            return (rawData["bonus_fl"] as? String ?? "n") == "y"
        } set {
            rawData["bonus_fl"] = newValue ? "y" : "n"
        }
    }
    
    var premium_end_dt: Double? {
        get {
            guard let dateString = rawData["premium_end_dt"] as? String else { return nil }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: dateString)?.timeIntervalSince1970
        } set {
            guard premium_end_dt != nil else {
                rawData["premium_end_dt"] = nil
                return
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            rawData["premium_end_dt"] = formatter.string(from: Date(timeIntervalSince1970: premium_end_dt!))
        }
    }
    
    var picture_name: String? {
        get {
            return rawData["picture_name"] as? String
        } set {
            rawData["picture_name"] = newValue
        }
    }
    
    var auth_key: String? {
        get {
            return rawData["auth_key"] as? String
        }
    }
    
    var cherry_quantity: Int {
        get {
            return Int(rawData["cherry_quantity"] as? String ?? "") ?? 0
        } set {
            rawData["cherry_quantity"] = "\(newValue)"
        }
    }
    
    var new_ok_chat: Int {
        get {
            return rawData["new_ok_chat"] as? Int ?? 0
        } set {
            rawData["new_ok_chat"] = newValue
        }
    }
}

class UserData: BaseData {
    var mem_idx: Int {
        get {
            return rawData["mem_idx"] as? Int ?? -1
        } set {
            rawData["mem_idx"] = newValue
        }
    }
    
    var report_fl: Bool {
        get {
            return (rawData["report_fl"] as? String ?? "n") == "y"
        } set {
            rawData["report_fl"] = newValue ? "y" : "n"
        }
    }
    
    var sim_style: Int {
        get {
            return rawData["sim_style"] as? Int ?? 0
        }
    }
    
    var religion_cd: String? {
        get {
            return rawData["religion_cd"] as? String
        } set {
            rawData["religion_cd"] = newValue
        }
    }
    
    var job_cd: String? {
        get {
            return rawData["job_cd"] as? String
        } set {
            rawData["job_cd"] = newValue
        }
    }
    
    var hobby_cd: String? {
        get {
            return rawData["hobby_cd"] as? String
        } set {
            rawData["hobby_cd"] = newValue
        }
    }
    
    var opposite_report_fl: Int {
        get {
            return rawData["opposite_report_fl"] as? Int ?? 0
        } set {
            rawData["opposite_report_fl"] = newValue
        }
    }
    
    var sim_values: Int {
        get {
            return rawData["sim_values"] as? Int ?? 0
        } set {
            rawData["sim_values"] = newValue
        }
    }
    
    var area_cd: String? {
        get {
            return rawData["area_cd"] as? String
        } set {
            rawData["area_cd"] = newValue
        }
    }
    
    var sim_character: Int {
        get {
            return rawData["sim_character"] as? Int ?? 0
        } set {
            rawData["sim_character"] = newValue
        }
    }
    
    var school: String? {
        get {
            return rawData["school"] as? String
        } set {
            rawData["school"] = newValue
        }
    }
    
    var job_etc: String? {
        get {
            return rawData["job_etc"] as? String
        } set {
            rawData["job_etc"] = newValue
        }
    }
    
    var blood_type: BloodType? {
        get {
            guard let typeString = rawData["blood_type"] as? String else { return nil }
            return BloodType(rawValue: typeString)
        } set {
            rawData["school"] = newValue?.rawValue
        }
    }
    
    var smoking: String? {
        get {
            return rawData["smoking"] as? String
        } set {
            rawData["smoking"] = newValue
        }
    }
    
    var nickname: String? {
        get {
            return rawData["nickname"] as? String
        } set {
            rawData["nickname"] = newValue
        }
    }
    
    var edu_cd: String? {
        get {
            return rawData["edu_cd"] as? String
        } set {
            rawData["edu_cd"] = newValue
        }
    }
    
    var introduction: String? {
        get {
            return rawData["introduction"] as? String
        } set {
            rawData["introduction"] = newValue
        }
    }
    
    var height: Int {
        get {
            return rawData["height"] as? Int ?? 0
        } set {
            rawData["height"] = newValue
        }
    }
    
    var area: String? {
        get {
            return rawData["area"] as? String
        } set {
            rawData["area"] = newValue
        }
    }
    
    var form_cd: String? {
        get {
            return rawData["form_cd"] as? String
        } set {
            rawData["form_cd"] = newValue
        }
    }
    
    var ghost_fl: Bool {
        get {
            return (rawData["ghost_fl"] as? String ?? "n") == "y"
        } set {
            rawData["ghost_fl"] = newValue ? "y" : "n"
        }
    }
    
    var drinking: String? {
        get {
            return rawData["drinking"] as? String
        } set {
            rawData["drinking"] = newValue
        }
    }
    
    var sim_sum: Int {
        get {
            return rawData["sim_sum"] as? Int ?? 0
        } set {
            rawData["sim_sum"] = newValue
        }
    }
    
    var sex: Gender? {
        get {
            return Gender(rawValue: rawData["sex"] as? String ?? "")
        } set {
            rawData["sex"] = newValue?.rawValue
        }
    }
    
    var religion: String? {
        get {
            return rawData["religion"] as? String
        } set {
            rawData["religion"] = newValue
        }
    }
    
    var drinking_cd: String? {
        get {
            return rawData["drinking_cd"] as? String
        } set {
            rawData["drinking_cd"] = newValue
        }
    }
    
    var form: String? {
        get {
            return rawData["form"] as? String
        } set {
            rawData["form"] = newValue
        }
    }
    
    var edu: String? {
        get {
            return rawData["edu"] as? String
        } set {
            rawData["edu"] = newValue
        }
    }
    
    var job: String? {
        get {
            return rawData["job"] as? String
        } set {
            rawData["job"] = newValue
        }
    }
    
    var smoking_cd: String? {
        get {
            return rawData["smoking_cd"] as? String
        } set {
            rawData["smoking_cd"] = newValue
        }
    }
    
    var age: Int {
        get {
            return rawData["age"] as? Int ?? 0
        }
    }
    
    var sign_up_fl: String? {
        get {
            return rawData["sign_up_fl"] as? String
        } set {
            rawData["sign_up_fl"] = newValue
        }
    }
    
    var signupStatus: SignupStatus {
        get {
            guard sign_up_fl != nil else { return .unknown }
            return SignupStatus(rawValue: sign_up_fl!) ?? .unknown
        }
    }
    
    var hobby: String? {
        get {
            return rawData["hobby"] as? String
        } set {
            rawData["hobby"] = newValue
        }
    }
    
    func reloadData(_ completion: ((Bool) -> Void)? = nil) {
        guard MyData.shared.mem_idx != -1 else {
            completion?(false)
            return
        }
        
        var params = [String:Any]()
        params["opposite_mem_idx"] = mem_idx
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Account.GetInfo + "\(MyData.shared.mem_idx)", params: params) {[weak self] (isSucceed, message, response) in
            guard isSucceed, let responseData = response as? [String:Any] else {
                completion?(false)
                return
            }
            
            self?.updateData(with: responseData)
            
            completion?(true)
        }
    }
    
    internal func updateData(with dict: [String:Any], reset: Bool = false) {
        if reset {
            rawData.removeAll()
        }
        
        let keys = Array(dict.keys)
        for key in keys {
            rawData[key] = dict[key]
        }
    }
}
