//
//  TermsData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class TermsData: BaseData {
    var indispensable_fl: Bool {
        return rawData["indispensable_fl"] as? String ?? "n" == "y"
    }
    
    var terms_title: String {
        return rawData["terms_title"] as? String ?? ""
    }
    
    var terms_idx: Int? {
        return rawData["terms_idx"] as? Int
    }
    
    var terms_text: String? {
        return rawData["terms_text"] as? String
    }
    
    var isAgreed = false
}
