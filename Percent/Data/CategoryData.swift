//
//  CategoryData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class CategoryData: BaseData {
    var category_idx: Int? {
        return rawData["category_idx"] as? Int
    }
    
    var text: String? {
        get {
            guard let string = rawData["text"] as? String else { return nil }
            
            let genderString = MyData.shared.sex == .female ? "남성" : "여성"
            return string.replacingOccurrences(of: "[성별]", with: genderString)
        }
    }
}
