//
//  DailyView.swift
//  SwitchRootViewController
//
//  Created by 은영김 on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyView: UIView {
  
  // MARK: -Property
  let label = UILabel()
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.backgroundColor = .cyan
    setupUI()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - setup
  private func setupUI() {
    [label].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.textColor = .gray
    label.text = "목표,음식,운동,나머지..."
    label.textAlignment = .center
  }
  
  private func setupConstraint() {
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 16),
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])

  }
  
  
}
