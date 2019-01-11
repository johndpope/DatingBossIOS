//
//  Defines.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 03/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import Foundation

public enum BuildLevel: Int {
    case UI_TEST = 0
    case DEVELOP = 1
    case CLIENT_TEST = 2
    case DISTRIBUTE = 3
}

public struct ApplicationOptions {
    public struct Build {
        public static let Level = BuildLevel.CLIENT_TEST
    }
    
    public struct TestInfo {
        public static let ID = "kyuil91@gmail.com"
        public static let Password = "mjlove91"
    }
}

public enum Gender: String {
    case male = "m"
    case female = "f"
}

public enum BloodType: String {
    case A = "a"
    case B = "b"
    case AB = "ab"
    case O = "o"
}

public struct NotificationName {
    public struct Cherry {
        public static let Increased = NSNotification.Name(rawValue: "Cherry.Increased")
        public static let Decreased = NSNotification.Name(rawValue: "Cherry.Decreased")
        public static let Changed = NSNotification.Name(rawValue: "Cherry.Changed")
    }
}
