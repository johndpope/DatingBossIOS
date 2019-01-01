//
//  ChatListData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

enum ChatListStatus {
    case InProgress
    case Refused
    case Pending
    case Accepted
}

class ChatListData: BaseData {
//    total_message,
//    new_message,
    
    var chat_idx: Int {
        return rawData["chat_idx"] as? Int ?? -1
    }
    
    var mem_idx: Int {
        return rawData["mem_idx"] as? Int ?? -1
    }
    
    var nickname: String? {
        return rawData["nickname"] as? String
    }
    
    var area_cd: String? {
        return rawData["area_cd"] as? String
    }
    
    var job_cd: String? {
        return rawData["job_cd"] as? String
    }
    
    var picture_name: String? {
        return rawData["picture_name"] as? String
    }
    
//    status,
    var status: ChatListStatus?
    
    var age: Int {
        return rawData["age"] as? Int ?? 0
    }
    
    var area: String? {
        return rawData["area"] as? String
    }
    
    var job: String? {
        return rawData["job"] as? String
    }
    
    var last_visit_dt: Double? {
        return rawData["last_visit_dt"] as? Double
    }
}
