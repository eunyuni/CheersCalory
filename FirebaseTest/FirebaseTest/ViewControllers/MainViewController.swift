//
//  MainViewController.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let label = UILabel()
    private var userInfo = UserInfo.shared
    private var dao = DAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        label.textAlignment = .center
        label.text = "메인뷰"
        readUserDefault()
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func readUserDefault() {
        guard let data = UserDefaults.standard.data(forKey: "userInfo") else { return }
        if let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data) {
            self.userInfo = userInfo
        }
        label.text = "\(userInfo.gender), \(userInfo.age), \(userInfo.height), \(userInfo.weight)"
    }
}
