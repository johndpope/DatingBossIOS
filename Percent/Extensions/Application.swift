//
//  Application.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 04/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

extension UIApplication {
    class func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
