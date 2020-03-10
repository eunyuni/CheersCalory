//
//  RecordGraphView.swift
//  SwitchRootViewController
//
//  Created by 은영김 on 2020/03/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecordGraphView: UIView {
  
  // MARK: -Property
  let label = UILabel()
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.backgroundColor = .brown
    setUI()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - setup
  private func setUI() {
    label.textAlignment = .center
    label.text = "Graph!"
    self.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.bottomAnchor.constraint(equalTo: self.centerYAnchor),
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ])
  }
}
