//
//  QHttpClient.swift
//  QKit
//
//  QHttpClient 2.0
//
//  Created by Jun-kyu Jeon on 18/11/15.
//  Copyright © 2015 - present Jun-kyu Jeon. All rights reserved.
//
//
//  QHttpClient.swift
//  REST
//
//  Created by Junkyu Jeon on 11/18/15.
//  Copyright © 2015 Jeon Jun-kyu. All rights reserved.
//

import Foundation
import UIKit

let QHTTPCLIENT_FORCE_DEBUG = true

private let kBoundaryString = "---percentboundary236739405175924702888539212340aca3742955c---"

enum QHttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum QHttpDebugStatus {
    case allEnabled
    case partlyEnabled
    case allDisabled
}

@objc protocol QHttpClientProgressDelegate {
    @objc optional func httpClient(_ httpClient: QHttpClient, updateProgress progress: Double)
}

let kHttpClientDebugError = "Error"
let kHttpClientDebugParams = "Params"
let kHttpClientDebugRequestUrl = "RequestUrl"
let kHttpClientDebugResponse = "Response"

class QHttpClient: NSObject {
    class func addCommonHeaderValue(_ value: String, for key: String) {
        QHttpClientSettings.shared.headerValues[key] = value
    }
    
    class func removeCommonHeaderValue(for key: String) -> Bool {
        return QHttpClientSettings.shared.headerValues.removeValue(forKey: key) != nil
    }
    
    var httpMethod : QHttpMethod!
    var debugMode : QHttpClientDebugMode! = QHttpClientDebugMode(error: false, params: false, requestUrl: false, response: false)
    var url: String!
    var headerValues: [String:Any]?
    var parameters: [String:Any]?
    var optionalData: [String:Any]?
    
    var progressDelegate: QHttpClientProgressDelegate?
    
    var blockTimeout = true
    
    var state: URLSessionTask.State? {
        get {
            return task?.state
        }
    }
    
    var showErrorMessage = true
    
    var debugEnabled: [String] {
        get {
            var enabled: [String] = []
            if debugMode.error == true {enabled.append(kHttpClientDebugError)}
            if debugMode.params == true {enabled.append(kHttpClientDebugParams)}
            if debugMode.requestUrl == true {enabled.append(kHttpClientDebugRequestUrl)}
            if debugMode.response == true {enabled.append(kHttpClientDebugResponse)}
            return enabled
        }
    }
    
    var debugStatus: QHttpDebugStatus {
        get {
            if debugMode.error == true && debugMode.params == true && debugMode.requestUrl == true && debugMode.response == true {
                return .allEnabled
            } else if debugMode.error == false && debugMode.params == false && debugMode.requestUrl == false && debugMode.response == false {
                return .allDisabled
            }
            
            return .partlyEnabled
        }
    }
    
    fileprivate var task: URLSessionDataTask?
    fileprivate var timeInterval: Double?
    
    fileprivate let timeoutInterval = 60.0
    fileprivate var timerTimeout: Timer?
    
    var identifier: Double? {
        return timeInterval
    }
    
    func request(to urlString : String, method : QHttpMethod = .post, headerValues headers : [String:Any]? = nil, params : [String:Any]?, completion: ((Bool, String?, Any?) -> Void)?) {
        self.toggleDebugs(QHTTPCLIENT_FORCE_DEBUG)
        
        httpMethod = method
        
        headerValues = headers
        url = urlString
        parameters = params
        
        var reqUrl = url ?? ""
        var paramString: String?
        
//        if parameters != nil {
//            let keys = Array(parameters!.keys)
//
//            if keys.count > 0 {
//                let jsonWriter = SBJsonWriter()
//                paramString = jsonWriter.string(with: params)
//            }
//        }
        var imageData: Data?
        
        if params != nil {
            let keys = Array((params!).keys)
            
            if keys.count > 0 {
                paramString = ""
                
                for i in 0 ..< keys.count {
                    if paramString!.count > 0 {
                        paramString! += "&"
                    }
                    
                    let key = keys[i]
                    if let value = params![key] {
                        if let valueArray = value as? [Any] {
                            let jsonWriter = SBJsonWriter()
                            paramString! += "\(key)=" + jsonWriter.string(with: valueArray)
                        } else if let valueData = value as? Data {
                            imageData = photoDataToFormData(data: valueData, boundary: kBoundaryString, fileName: "ios_\(Int(Date().timeIntervalSince1970)).jpeg")
                        } else {
                            paramString! += "\(key)=\(value)"
                        }
                    }
                }
            }
        }
        
        if httpMethod == .get {
            if paramString != nil {
                reqUrl += "?" + paramString!
            }
        }
        
        reqUrl = reqUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let request = NSMutableURLRequest(url: URL(string: reqUrl)!)
        
        let commonHeaderValues = QHttpClientSettings.shared.headerValues
        let commonHeaderKeys = Array(commonHeaderValues.keys)
        
        for field in commonHeaderKeys {
            guard let value = commonHeaderValues[field] else {continue}
            request.addValue(value, forHTTPHeaderField: field)
        }
        
        if headerValues != nil {
            let keys = Array(headerValues!.keys)
            
            if keys.count > 0 {
                for key in keys {
                    if let aValue = headerValues![key] as? String {
                        request.addValue(aValue, forHTTPHeaderField: key)
                    }
                }
            }
        }
        
        request.httpMethod = method.rawValue
        
//        if httpMethod == .post && params != nil {
//        }
        
        if httpMethod != .get && paramString != nil {
            var httpBody = Data()
            if imageData != nil {
                if params != nil {
                    for (key, value) in params! {
                        if let array = value as? [Any] {
                            for i in 0 ..< array.count {
                                let subvalue = array[i]
                                
                                httpBody.append("--\(kBoundaryString)\r\n".data(using: .utf8)!)
                                httpBody.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                                httpBody.append("\(subvalue)\r\n".data(using: .utf8)!)
                            }
                            
                            continue
                        }
                        httpBody.append("--\(kBoundaryString)\r\n".data(using: .utf8)!)
                        httpBody.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                        httpBody.append("\(value)\r\n".data(using: .utf8)!)
                    }
                }
                
                httpBody.append(imageData!)
                
                request.setValue("multipart/form-data; boundary=" + kBoundaryString, forHTTPHeaderField: "Content-Type")
                request.setValue("\([UInt8](httpBody).count)", forHTTPHeaderField: "Content-Length")
            } else {
                let jsonData: Data = try! JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
                httpBody = jsonData
            }
            
            request.httpBody = httpBody
        }
        
        if debugMode.requestUrl {
            print("[QHttpClient] Request to : \(reqUrl)")
        }
        
        if debugMode.params {
            print("[QHttpClient] Request Header : \(String(describing: request.allHTTPHeaderFields))")
            print("[QHttpClient] Request Params : \(paramString ?? "(No Parameters)")")
        }
        
        let queue = OperationQueue.main
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: queue)
        
        task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            self.timerTimeout?.invalidate()
            self.timerTimeout = nil
            
            if error != nil {
                if self.debugMode.error {
                    print("[QHttpClient] Failed on error : \(String(describing: error))")
                }
                
                let errDescription = String(describing: error)
                DispatchQueue.main.async {
                    completion?(false, errDescription.count > 0 ? errDescription : kStringErrorUnknown, nil)
                }
                session.finishTasksAndInvalidate()
                return
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?
            
            if self.timeInterval != nil {
                self.timeInterval = Date().timeIntervalSince1970 - self.timeInterval!
            }
            
            if self.debugMode.response {
                if self.timeInterval != nil {
                    print("[QHttpClient] Response Time : \(self.timeInterval!) sec")
                }
                print("[QHttpClient] Response : \(responseString ?? "(No Response)")")
            }
            
            self.task = nil
            
            let jsonParser = SBJsonParser()
            if responseString != nil {
                DispatchQueue.main.async {
                    completion?(true, nil, jsonParser.object(with: responseString))
                }
            } else {
                DispatchQueue.main.async {
                    completion?(false, kStringErrorUnknown, nil)
                }
            }
            session.finishTasksAndInvalidate()
        })
        timeInterval = Date().timeIntervalSince1970
        task!.resume()
        
        if blockTimeout {return}
        
        timerTimeout = Timer.scheduledTimer(withTimeInterval: timeoutInterval, repeats: false, block: { (timer) in
            self.task?.cancel()
            
            self.timerTimeout?.invalidate()
            self.timerTimeout = nil
            
            DispatchQueue.main.async {
                completion?(false, kStringErrorUnknown, nil)
            }
        })
    }
    
    func cancel() {
        task?.cancel()
    }
    
    func enableAllDebugs() {
        toggleDebugs(true)
    }
    
    func disableAllDebugs() {
        toggleDebugs(false)
    }
    
    func toggleDebugs(_ toggle: Bool) {
        debugMode.error = toggle
        debugMode.params = toggle
        debugMode.requestUrl = toggle
        debugMode.response = toggle
    }
    
    func photoDataToFormData(data: Data, boundary: String, fileName: String) -> Data {
        var fullData = Data()
        
        let lineOne = "--" + boundary + "\r\n"
        fullData.append(lineOne.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        let lineTwo = "Content-Disposition: form-data; name=\"picture\"; filename=\"" + fileName + "\"\r\n"
        fullData.append(lineTwo.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        let lineThree = "Content-Type: image/jpeg\r\n\r\n"
        fullData.append(lineThree.data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        
        fullData.append(data as Data)
        
        let lineFive = "\r\n"
        fullData.append(lineFive.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        let lineSix = "--" + boundary + "--\r\n"
        fullData.append(lineSix.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        return fullData
    }
}

extension QHttpClient: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        progressDelegate?.httpClient?(self, updateProgress: progress)
    }
}

struct QHttpClientDebugMode{
    var error: Bool = false
    var params: Bool = false
    var requestUrl: Bool = false
    var response: Bool = false
}

private class QHttpClientSettings: NSObject {
    static let shared = QHttpClientSettings()
    
    var headerValues = [String:String]()
}
