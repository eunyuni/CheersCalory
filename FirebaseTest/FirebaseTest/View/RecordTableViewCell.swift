//
//  RecordTableViewCell.swift
//  SwitchRootViewController
//
//  Created by 은영김 on 2020/03/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
  
  static let identifier = "RecordTableViewCell"
  
  // MARK: -Property
  private let kcalLabel = UILabel()
  private let dateLabel = UILabel()
  private let cameraButton: UIButton = {
    let button = UIButton(type: .system)
    let cameraImage = UIImage(named: "camera")
    button.setImage(cameraImage, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    //    button.addTarget(self, action: #selector((_:)), for: .touchUpInside)
    return button
  }()
  
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
    [kcalLabel, dateLabel, cameraButton].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    kcalLabel.text = "452 kcal"
    kcalLabel.textColor = .black
    dateLabel.text = "2020. 03. 06 (금)"
    dateLabel.textColor = .lightGray
    dateLabel.font = .systemFont(ofSize: 12, weight: .light)
  }
  
  private func setupConstraint() {
    NSLayoutConstraint.activate([
      kcalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      kcalLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -16),
    ])
    NSLayoutConstraint.activate([
      dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      dateLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 8),
    ])
    NSLayoutConstraint.activate([
      cameraButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
      cameraButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
  
}

