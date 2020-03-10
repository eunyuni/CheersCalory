//
//  DailySectionHeaderView.swift
//  SwitchRootViewController
//
//  Created by 은영김 on 2020/03/10.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

protocol DailySectionHeaderViewdelegate: class {
    func didTapPlusButton(section: Int)
}

class DailySectionHeaderView: UIView {
  
  //  static let identifier = "DailyTableViewCell"
  
  weak var delegate: DailySectionHeaderViewdelegate?
  var section = 0
  // MARK: -Property
  private let foodLabel = UILabel()
  private let plusButton: UIButton = {
    let button = UIButton(type: .system)
    let plusImage = UIImage(systemName: "plus")
    button.setImage(plusImage, for: .normal)
    button.setPreferredSymbolConfiguration(.init(scale: .default), forImageIn: .normal)
    button.addTarget(self, action: #selector(didplusButton), for: .touchUpInside)
    return button
  }()
  
  // MARK: -init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    @objc private func didplusButton(_ sender: UIButton) {
        delegate?.didTapPlusButton(section: section)
  }
  
  // MARK: - setup
  private func setupUI() {
    [foodLabel, plusButton].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    foodLabel.text = "저녁!!!"
    foodLabel.textColor = .white
    foodLabel.font = .systemFont(ofSize: 16, weight: .light)
  }
  
  private func setupConstraint() {
    NSLayoutConstraint.activate([
      foodLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
      foodLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
    
    NSLayoutConstraint.activate([
      plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
}

