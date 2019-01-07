//
//  BoardData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 03/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class BoardData: BaseData {
    var board_idx: Int? {
        return rawData["board_idx"] as? Int
    }
    
    var text: String? {
        return rawData["text"] as? String
    }
    
    var title: String? {
        return rawData["title"] as? String
    }
    
    var isExpanded = false
}
