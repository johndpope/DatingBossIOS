//
//  Urls.swift
//  Wishpoke
//
//  Created by Jun-kyu Jeon on 21/11/2018.
//  Copyright © 2018 Wishpoke. All rights reserved.
//

import Foundation

struct RequestUrl {
    public struct Account {
        public static let Signup = "http://www.lovecenthome.com/ios/member"
        public static let Login = "http://www.lovecenthome.com/ios/login"
        public static let ChangeStatus = "http://www.lovecenthome.com/ios/status/"
        public static let Validate = "http://www.lovecenthome.com/ios/duplicate"
        public static let Check = "http://www.lovecenthome.com/ios/check"
        public static let GetInfo = "http://www.lovecenthome.com/ios/member/"
        public static let GetProfileEntries = "http://www.lovecenthome.com/ios/member/view/"
        public static let GetStats = "http://www.lovecenthome.com/ios/graph/"
        public static let Update = "http://www.lovecenthome.com/ios/member/"
        public static let Unregister = "http://www.lovecenthome.com/ios/member/"
        public static let Find = "http://www.lovecenthome.com/ios/find"
    }
    
    public struct Service {
        public static let GetTerms = "http://www.lovecenthome.com/ios/terms"
        public static let Settings = "http://www.lovecenthome.com/ios/setup/"
        public static let Notice = "http://www.lovecenthome.com/ios/board/"
        public static let Board = "http://www.lovecenthome.com/ios/board/"
    }
    
    public static let Survey = "http://www.lovecenthome.com/ios/survey/"
    
    public struct FavorLooks {
        public static let Pictrues = "http://www.lovecenthome.com/ios/looks/"
        public static let Tag = "http://www.lovecenthome.com/ios/tag/"
        public static let AddTag = "http://www.lovecenthome.com/ios/looks/"
    }
    
    public struct Main {
        public static let Recommends = "http://www.lovecenthome.com/ios/recom/"
    }
    
    public struct Notification {
        public static let UpdateToken = "http://www.lovecenthome.com/ios/fcm/"
    }
    
    public struct Image {
        public static let File = "https://s3.ap-northeast-2.amazonaws.com/datingboss.com/profile/"
        public static let Info = "http://www.lovecenthome.com/ios/picture/"
    }
    
    public struct Category {
        public static let GetList = "http://www.lovecenthome.com/ios/category/"
    }
    
    public static let Chat = "http://www.lovecenthome.com/ios/chat/"
    
    public static let Like = "http://www.lovecenthome.com/ios/like/"
    
    public static let Report = "http://www.lovecenthome.com/ios/report/"
}
