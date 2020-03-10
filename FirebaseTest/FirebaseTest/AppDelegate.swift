//
//  AppDelegate.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/05.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setRootView(window: window!)
        FirebaseApp.configure()
        return true
    }

    
}

