//
//  SettingsData.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 05/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import Foundation

enum SettingsType: String {
    case RecommendAlert = "010"                     // 추천 알림 받기
    case PokingAlert = "020"                        // 좋아요 알림 받기
    case ChattingAlert = "030"                      // 채팅 알림 받기
    case EventAlert = "040"                         // 이벤트 알림 받기
    case AdminAlert = "050"                         // 운영자 알림 받기
    case InactiveAccount = "060"                    // 휴면회원 전환
    case ChangePassword = "070"                     // 비밀번호 변경
    case Destroy = "080"                            // 서비스 탈퇴
}

class SettingsData: BaseData {
    var type: SettingsType? {
        get {
            guard setup_code != nil else { return nil }
            return SettingsType(rawValue: setup_code!)
        }
    }
    
    var setup_name: String? {
        return rawData["setup_name"] as? String
    }
    
    var setup_code: String? {
        return rawData["setup_code"] as? String
    }
    
    var value: Bool {
        get {
            return (rawData["setup_value"] as? String ?? "n") == "y"
        } set {
            rawData["setup_value"] = newValue ? "y" : "n"
        }
    }
    
    var imageName: String? {
        get {
            guard type != nil else { return  nil }
            
            var name: String?
            
            switch type! {
            case .RecommendAlert:
                name = "img_settings_1"
                break
                
            case .PokingAlert:
                name = "img_settings_3"
                break
                
            case .ChattingAlert:
                name = "img_settings_2"
                break
                
            case .EventAlert:
                name = "img_settings_5"
                break
                
            case .AdminAlert:
                name = "img_settings_4"
                break
                
            case .InactiveAccount:
                name = "img_settings_7"
                break
                
            case .ChangePassword:
                name = "img_settings_8"
                break
                
            case .Destroy:
                name = "img_settings_9"
                break
            }
            
            return name
        }
    }
    
    var toggle: Bool {
        return (type != .Destroy && type != .ChangePassword)
    }
}
