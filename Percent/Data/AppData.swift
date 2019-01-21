//
//  AppData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 10/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class AppData: BaseData {
    convenience init(withCode aCode: String?, name: String?) {
        self.init(with: [:])
        
        code = aCode
        code_name = name
    }
    
    var code: String? {
        get {
            return rawData["code"] as? String
        } set {
            rawData["code"] = newValue
        }
    }
    
    var code_type_name: String? {
        get {
            return rawData["code_type_name"] as? String
        } set {
            rawData["code_type_name"] = newValue
        }
    }
    
    var code_name: String? {
        get {
            return rawData["code_name"] as? String
        } set {
            rawData["code_name"] = newValue
        }
    }
    
    var code_type: String? {
        get {
            return rawData["code_type"] as? String
        } set {
            rawData["code_type"] = newValue
        }
    }
}
