//
//  SearchParameter.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 22/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class SearchParameters: NSObject {
    var region: AppData?
    var minAge: Int?
    var maxAge: Int?
    var minHeight: Int?
    var maxHeight: Int?
    var shape: AppData?
    var blood: BloodType?
    var religion: AppData?
    var hobby: AppData?
    var drinking: AppData?
    var smoking: AppData?
    
    var hasCondition: Bool {
        get {
            return (region != nil || minAge != nil || maxAge != nil || minHeight != nil || maxHeight != nil || shape != nil || blood != nil || religion != nil || hobby != nil || drinking != nil || smoking != nil)
        }
    }
    
    var params: [String:Any] {
        get {
            var dict = [String:Any]()
            if let area_cd = region?.code {
                dict["area_cd"] = area_cd
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            let thisYear = Int(formatter.string(from: Date()))!
            
            if let birth_min = minAge {
                dict["birth_min"] = thisYear - birth_min + 1
            }
            if let birth_max = maxAge {
                dict["birth_max"] = thisYear - birth_max + 1
            }
            
            if let height_min = minHeight {
                dict["height_min"] = height_min
            }
            if let height_max = maxHeight {
                dict["height_max"] = height_max
            }
            if let form_cd = shape?.code {
                dict["form_cd"] = form_cd
            }
            if let blood_type = blood?.rawValue.lowercased() {
                dict["blood_type"] = blood_type
            }
            if let religion_cd = religion?.code {
                dict["religion_cd"] = religion_cd
            }
            if let hobby_cd = hobby?.code {
                dict["hobby_cd"] = hobby_cd
            }
            if let drinking_cd = drinking?.code {
                dict["drinking_cd"] = drinking_cd
            }
            if let smoking_cd = smoking?.code {
                dict["smoking_cd"] = smoking_cd
            }
            
            return dict
        }
    }
    
    func clear() {
        region = nil
        minAge = nil
        maxAge = nil
        minHeight = nil
        maxHeight = nil
        shape = nil
        blood = nil
        religion = nil
        hobby = nil
        drinking = nil
        smoking = nil
    }
    
    func commit() {
        var dict = [String:Any]()
        dict["region"] = region?.rawData
        dict["minAge"] = minAge
        dict["maxAge"] = maxAge
        dict["minHeight"] = minHeight
        dict["maxHeight"] = maxHeight
        dict["shape"] = shape?.rawData
        dict["blood"] = blood?.rawValue
        dict["religion"] = religion?.rawData
        dict["hobby"] = hobby?.rawData
        dict["drinking"] = drinking?.rawData
        dict["smoking"] = smoking?.rawData
        
        QDataManager.shared.searchData = dict
        QDataManager.shared.commit()
    }
    
    func loadFromDatabase() {
        clear()
        
        let dict = QDataManager.shared.searchData
        
        if let rawData = dict["region"] as? [String:Any] {
            region = AppData(with: rawData)
        }
        
        minAge = dict["minAge"] as? Int
        maxAge = dict["maxAge"] as? Int
        minHeight = dict["minHeight"] as? Int
        maxHeight = dict["maxHeight"] as? Int
        
        if let rawData = dict["shape"] as? [String:Any] {
            shape = AppData(with: rawData)
        }
        if let rawData = dict["blood"] as? String {
            blood = BloodType(rawValue: rawData)
        }
        if let rawData = dict["religion"] as? [String:Any] {
            religion = AppData(with: rawData)
        }
        if let rawData = dict["hobby"] as? [String:Any] {
            hobby = AppData(with: rawData)
        }
        if let rawData = dict["drinking"] as? [String:Any] {
            drinking = AppData(with: rawData)
        }
        if let rawData = dict["smoking"] as? [String:Any] {
            smoking = AppData(with: rawData)
        }
    }
}
