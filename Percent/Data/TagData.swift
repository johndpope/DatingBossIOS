//
//  TagData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class TagData: BaseData {
    var code: String? {
        return rawData["code"] as? String
    }
    
    var code_name: String? {
        return rawData["code_name"] as? String
    }
    
    var isSelected: Bool = false
}
