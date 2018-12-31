//
//  BaseData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 04/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import Foundation

class BaseData: NSObject {
    internal var rawData: [String:Any]
    
    var dictionary: [String:Any] {
        return rawData
    }
    
    init(with dict: [String:Any] = [:]) {
        rawData = dict
        super.init()
    }
    
    func resetData(with dict: [String:Any]) {
        rawData = dict
    }
}
