//
//  SurveyManager.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 08/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

class SurveyManager: NSObject {
    static let shared = SurveyManager()
    
    private var surveyKeys = [String]()
    var keys: [String] {
        return surveyKeys
    }
    
    private var surveys = [String:[SurveyData]]()
    var dataDict: [String:[SurveyData]] {
        return surveys
    }
    
    func reloadSurveys(forcing: Bool = false, completion: ((Bool) -> Void)? = nil) {
        if forcing == false, surveys.count > 0 {
            completion?(true)
            return
        }
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Survey + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
            self.surveyKeys.removeAll()
            self.surveys.removeAll()
            
            guard let responseData = response as? [[String:Any]] else {
                completion?(false)
                return
            }
            
            for item in responseData {
                let newData = SurveyData(with: item)
                guard let type1_cd = newData.type1_cd else { continue }
                
                var dataArray = self.surveys[type1_cd] ?? [SurveyData]()
                dataArray.append(newData)
                self.surveys[type1_cd] = dataArray
            }
            
            self.surveyKeys = Array(self.surveys.keys).sorted()
            
            completion?(true)
        }
    }
}
