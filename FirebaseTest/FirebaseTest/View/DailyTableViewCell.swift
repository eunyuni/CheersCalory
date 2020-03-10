//
//  DailyTableViewCell.swift
//  SwitchRootViewController
//
//  Created by 은영김 on 2020/03/10.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    static let identifier = "DailyTableViewCell"
     // MARK: -Property
    let foodName = UILabel()
    let foodBase = UILabel()
    let foodkcal = UILabel()
    
     // MARK: -init
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupUI()
       setupConstraint()
     }
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
    
     // MARK: - setup
     private func setupUI() {
       [foodName, foodBase, foodkcal].forEach {
         self.addSubview($0)
         $0.translatesAutoresizingMaskIntoConstraints = false
       }
       
       foodName.font = .systemFont(ofSize: 16, weight: .light)
       foodBase.font = .systemFont(ofSize: 12, weight: .light)
       foodkcal.font = .systemFont(ofSize: 16, weight: .medium)
       foodBase.textColor = .lightGray
     }
    
     private func setupConstraint() {
       NSLayoutConstraint.activate([
         foodName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
         foodName.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -16),
       ])
       NSLayoutConstraint.activate([
         foodBase.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
         foodBase.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 8),
       ])
       NSLayoutConstraint.activate([
         foodkcal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
         foodkcal.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
       ])
     }

}
