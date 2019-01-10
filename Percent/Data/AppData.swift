//
//  AppData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 10/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class AppData: BaseData {
    var code: String? {
        return rawData["code"] as? String
    }
    
    var code_type_name: String? {
        return rawData["code_type_name"] as? String
    }
    
    var code_name: String? {
        return rawData["code_name"] as? String
    }
    
    var code_type: String? {
        return rawData["code_type"] as? String
    }
}
