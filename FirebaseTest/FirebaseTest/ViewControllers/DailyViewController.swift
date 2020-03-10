//
//  DailyViewController.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {
    
    // MARK: -Property
    private let headerView = DailyView()
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.tableFooterView = UIView(frame: CGRect.zero)
      tableview.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
//      tableview.register(DailytableViewCell.self, forCellReuseIdentifier: dai)
//      tableview.register(Dail, forCellReuseIdentifier: <#T##String#>)
        return tableview
    }()
    
//    var mealTime: [[Foods]] = [] // 0: 아침, 1: 점심, 2: 저녁, 3: 간식 => DataSource로 활용, userDefault에 넣고, Date()지나면 삭제
    var breakfast = [Foods]()
    var lunch = [Foods]()
    var dinner = [Foods]()
    var snack = [Foods]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.reloadData()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - setup
    private func setupConstraint() {
        let guide = view.safeAreaLayoutGuide
        [headerView, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: guide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
}

// MARK: -UITableViewDataSource
extension DailyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        switch section {
        case 0:
            return self.breakfast.count
        case 1:
            return self.lunch.count
        case 2:
            return self.dinner.count
        case 3:
            return self.snack.count
        default:
            return 0
        }
  }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
        var name = ""
        var base = ""
        var calory = ""
        
        switch indexPath.section {
        case 0:
            name = breakfast[indexPath.row].foodName
            base = breakfast[indexPath.row].servingSize
            calory = breakfast[indexPath.row].calory
        case 1:
            name = lunch[indexPath.row].foodName
            base = lunch[indexPath.row].servingSize
            calory = lunch[indexPath.row].calory
        case 2:
            name = dinner[indexPath.row].foodName
            base = dinner[indexPath.row].servingSize
            calory = dinner[indexPath.row].calory
        case 3:
            name = snack[indexPath.row].foodName
            base = snack[indexPath.row].servingSize
            calory = snack[indexPath.row].calory
        default:
            break
        }
        
        cell.foodName.text = name
        cell.foodBase.text = calory
        cell.foodBase.text = base
        return cell
    }
    
    
}

extension DailyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DailySectionHeaderView()
        view.section = section
        view.backgroundColor = .orange
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension DailyViewController: DailySectionHeaderViewdelegate {
    func didTapPlusButton(section: Int) {

        let foodVC = FoodSearchViewController()
        foodVC.section = section
        let navi = UINavigationController(rootViewController: foodVC)
        present(navi, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let indexPathValue = indexPath
        print(indexPath)
        return indexPathValue
    }
}

