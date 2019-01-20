//
//  QDataManager.swift
//  QKit
//
//  Created by Jun-kyu Jeon on 07/09/2012.
//  Recreated in Swift by Jun-kyu Jeon on 13/12/2016.
//  Supported Swift4.0 by Jun-kyu Jeon on 13/10/2017.
//  Copyright © 2012 - present Jun-kyu Jeon. All rights reserved.
//

import Foundation
import SQLite3

private let kFileName = "settingsV1"
private let kFileExtension = "dat"
private let kFile = kFileName + "." + kFileExtension

private let kDirectory = FileManager.SearchPathDirectory.documentDirectory
private let kDomainMask = FileManager.SearchPathDomainMask.userDomainMask

class QDataManager: NSObject {
    static let shared = QDataManager.loadDatabase
    
    var version = Int32(1)
    
    var uuidString: String?
    var userId: String?
    var password: String?
    
    var registerStep: Int?
    
    var surveyAnswers = [Int:[[String:Any]]]()
    
    var signupData = [String:Any]()
    
    var deviceToken: Data?
    var fcmToken: String?
    
    var preferSettingCount = 0
    var preferSettingDate: Double?
    
    required override init() {
        super.init()
        self.clear()
    }
    
    required init(_ manager: QDataManager) {
        super.init()
        self.version = manager.version
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.uuidString  =  aDecoder.decodeObject(forKey: "uuidString") as? String
        self.userId  =  aDecoder.decodeObject(forKey: "userId") as? String
        self.password  =  aDecoder.decodeObject(forKey: "password") as? String
        self.registerStep  =  (aDecoder.decodeObject(forKey: "registerStep") as? NSNumber)?.intValue
        self.surveyAnswers = aDecoder.decodeObject(forKey: "surveyAnswers") as? [Int:[[String:Any]]] ?? [:]
        self.signupData = aDecoder.decodeObject(forKey: "signupData") as? [String:Any] ?? [:]
        self.deviceToken  =  aDecoder.decodeObject(forKey: "deviceToken") as? Data
        self.fcmToken  =  aDecoder.decodeObject(forKey: "fcmToken") as? String
        self.preferSettingCount  = (aDecoder.decodeObject(forKey: "preferSettingCount") as? NSNumber)?.intValue ?? 0
        self.preferSettingDate  =  (aDecoder.decodeObject(forKey: "preferSettingDate") as? NSNumber)?.doubleValue
    }
    
    func commit() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(self, forKey: "Data")
        archiver.finishEncoding()
        
        let paths = NSSearchPathForDirectoriesInDomains(kDirectory, kDomainMask, true)
        
        let documentsDirectory = paths[0] as NSString
        let filePath = documentsDirectory.appendingPathComponent(kFile)
        
        data.write(toFile: filePath, atomically: true)
    }
    
    func clear() {
        uuidString = nil
        userId = nil
        password = nil
        registerStep = nil
        surveyAnswers.removeAll()
        signupData.removeAll()
        deviceToken = nil
        fcmToken = nil
        preferSettingCount = 0
        preferSettingDate = nil
        
        commit()
    }
}

extension QDataManager {
    class var loadDatabase: QDataManager {
        get {
            guard let thePath = NSSearchPathForDirectoriesInDomains(kDirectory, kDomainMask, true).first as NSString? else  {
                return QDataManager()
            }
            
            let filePath = thePath.appendingPathComponent(kFile)
           
            var data: Data!
            do {
                data = try NSData(contentsOfFile: filePath) as Data
            } catch {
                return QDataManager()
            }
            
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            guard let dataManager = unarchiver.decodeObject(forKey: "Data") as? QDataManager else {
                return QDataManager()
            }
            
            _ = dataManager.sqlite()
            
            return dataManager
        }
    }
    
    func sqlite() -> Bool {
        do {
            var database: OpaquePointer?
            
            let manager = FileManager.default
            let documentUrl = try manager.url(for: kDirectory, in: kDomainMask, appropriateFor: nil, create: false).appendingPathComponent(kFile)
            
            if sqlite3_open(documentUrl.path, &database) == SQLITE_OK {
                var statement: OpaquePointer?
                
                var userVersion = Int32(0)
                var query = "PRAGMA user_version;"
                
                if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
                    if sqlite3_step(statement) == SQLITE_ROW {
                        userVersion = sqlite3_column_int(statement, 0)
                    }
                }
                
                sqlite3_finalize(statement)
                
                if version > userVersion {
                    query = "CREATE TABLE IF NOT EXISTS statuses (id INTEGER PRIMARY KEY, hit_date REAL)"
                    sqlite3_exec(database, query, nil, nil, nil)
                    
                    query = "PRAGMA user_version=\(version);"
                    sqlite3_exec(database, query, nil, nil, nil)
                }
            }
        } catch {
            return false
        }
        
        return true
    }
}

extension QDataManager: NSCopying, NSCoding {
    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(self)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uuidString, forKey: "uuidString")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(registerStep != nil ? NSNumber(value: registerStep!) : nil, forKey: "registerStep")
        aCoder.encode(surveyAnswers, forKey: "surveyAnswers")
        aCoder.encode(signupData, forKey: "signupData")
        aCoder.encode(deviceToken, forKey: "deviceToken")
        aCoder.encode(fcmToken, forKey: "fcmToken")
        aCoder.encode(NSNumber(value: preferSettingCount), forKey: "preferSettingCount")
        aCoder.encode(preferSettingDate != nil ? NSNumber(value: preferSettingDate!) : nil, forKey: "preferSettingDate")
    }
}
