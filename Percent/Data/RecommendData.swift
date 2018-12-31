//
//  RecommendData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 04/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import Foundation

class RecommendData: BaseData {
    var area: String? {
        return rawData["area"] as? String
    }
    
    var area_cd: String? {
        return rawData["area_cd"] as? String
    }
    
    var sim_sum: Int {
        return rawData["sim_sum"] as? Int ?? 0
    }
    
    var sex: Gender? {
        return Gender(rawValue: rawData["sex"] as? String ?? "")
    }
    
    var nickname: String? {
        return rawData["nickname"] as? String
    }
    
    var job_cd: String? {
        return rawData["job_cd"] as? String
    }
    
    var picture_name: String? {
        return rawData["picture_name"] as? String
    }
    
    var grade_score: Int {
        return rawData["grade_score"] as? Int ?? 0
    }
    
    var job: String? {
        return rawData["job"] as? String
    }
    
    var mem_idx: Int? {
        return rawData["mem_idx"] as? Int ?? -1
    }
    
    var age: Int {
        return rawData["age"] as? Int ?? 0
    }
}
