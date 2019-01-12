//
//  SurveyData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class SurveyData: BaseData {
    var survey_idx: Int? {
        return rawData["survey_idx"] as? Int
    }
    
    var type1_cd: String? {
        return rawData["type1_cd"] as? String
    }
    
    var type2_cd: String? {
        return rawData["type2_cd"] as? String
    }
    
    var text: String? {
        return rawData["text"] as? String
    }
}
