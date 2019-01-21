//
//  AppDataManager.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class AppDataManager: NSObject {
    static let shared = AppDataManager()
    
    private var codeDict = [String:String]()
    private var dataDict = [String:[AppData]]()
    var data: [String:[AppData]] {
        return dataDict
    }
    
    func reloadData(_ completion: ((Bool) -> Void)? = nil) {
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Account.GetProfileEntries + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            guard isSucceed, let responseData = response as? [[String:Any]] else {
                completion?(false)
                return
            }
            
            self.dataDict.removeAll()
            
            for i in 0 ..< responseData.count {
                let item = AppData(with: responseData[i])
                guard let code_type = item.code_type else { continue }
                
                var dataArray = self.dataDict[code_type] ?? [AppData]()
                dataArray.append(item)
                self.dataDict[code_type] = dataArray
            }
            
            completion?(true)
        }
    }
}
