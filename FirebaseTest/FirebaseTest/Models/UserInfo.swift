//
//  UserInfo.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    static let shared = UserInfo()
    private init(){}
    
    var gender: String = ""
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
}
