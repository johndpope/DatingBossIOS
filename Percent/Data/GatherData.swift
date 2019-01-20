//
//  GatherData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

enum GatheringType: String  {
    case read = "read"
    case request = "request"
    case response = "response"
}

class GatherData: UserData {
    var reg_dt: Double? {
        return rawData["reg_dt"] as? Double
    }
    
    var gather_fl: String? {
        return rawData["gather_fl"] as? String
    }
    
    var type: GatheringType? {
        return GatheringType(rawValue: gather_fl ?? "")
    }
}
