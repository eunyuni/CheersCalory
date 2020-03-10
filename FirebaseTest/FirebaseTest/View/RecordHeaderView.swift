//
//  RecordView.swift
//  SwitchRootViewController
//
//  Created by 은영김 on 2020/03/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecordHeaderView: UIView {
  
  // MARK: -Property
  private let leftButton: UIButton = {
    let button = UIButton(type: .system)
    let leftImage = UIImage(systemName: "arrowtriangle.left.fill")
    button.setPreferredSymbolConfiguration(.init(pointSize: 10), forImageIn: .normal)
    button.setImage(leftImage, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    //    button.addTarget(self, action: #selector((_:)), for: .touchUpInside)
    return button
  }()
  private let titleLabel = UILabel()
  private let rightButton: UIButton = {
    let button = UIButton(type: .system)
    let rightImage = UIImage(systemName: "arrowtriangle.right.fill")
    button.setPreferredSymbolConfiguration(.init(pointSize: 10), forImageIn: .normal)
    button.setImage(rightImage, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    //    button.addTarget(self, action: #selector((_:)), for: .touchUpInside)
    return button
  }()
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.backgroundColor = .lightGray
      // #colorLiteral(red: 0.8822851777, green: 0.8823911548, blue: 0.8822489381, alpha: 1)
    setupUI()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - setup
  private func setupUI() {
    [leftButton, titleLabel, rightButton].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    titleLabel.textColor = .gray
    titleLabel.text = "3월"
  }
  
  private func setupConstraint() {
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 64)
    ])
    
    NSLayoutConstraint.activate([
      leftButton.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -30),
      leftButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      rightButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 30),
      rightButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
    ])
  }
  
}

