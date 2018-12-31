//
//  PictureData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 05/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import Foundation

class PictureData: BaseData {
    var picture_idx: Int? {
        return rawData["picture_idx"] as? Int
    }
    
    var mod_fl: Bool {
        return (rawData["mod_fl"] as? String ?? "n") == "y"
    }
    
    var picture_name: String? {
        return rawData["picture_name"] as? String
    }
    
    var mem_idx: Int {
        get {
            return rawData["mem_idx"] as? Int ?? -1
        } set {
            rawData["mem_idx"] = newValue
        }
    }
    
    var imageUrl: URL? {
        get {
            guard picture_name != nil else { return nil }
            return URL(string: RequestUrl.Image.File + "\(mem_idx)/" + picture_name!)
        }
    }
}
