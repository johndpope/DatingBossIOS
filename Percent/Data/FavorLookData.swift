//
//  FavorLookData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 11/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class FavorLookData: BaseData {
    var gender: Gender {
        return Gender(rawValue: rawData["sex"] as? String ?? "m") ?? .male
    }
    
    var picture_name: String? {
        return rawData["picture_name"] as? String
    }
    
    var mem_idx: Int {
        get {
            return rawData["mem_idx"] as? Int ?? -1
        }
    }
    
    var age: Int? {
        get {
            return rawData["age"] as? Int
        }
    }
    
    var imageUrl: URL? {
        get {
            guard picture_name != nil else { return nil }
            return URL(string: RequestUrl.Image.File + "\(mem_idx)/" + picture_name!)
        }
    }
}
