//
//  RecordViewController.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import Firebase

protocol SendBarcodeDataDelegate {
    func sendBarcodeData(barcode: String)
}

class FoodSearchViewController: UIViewController {
    var section = 0
    
    private let dao = DAO()
    private var delegate: SendBarcodeDataDelegate?
    private var ref: DatabaseReference!
    
    private let label = UILabel()
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private var dataArr:[Foods] = []
    
    private var filteredDatas: [Foods] = []
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        view.backgroundColor = .white
        
        print(self.section)
        
        // 유저디폴트 생성 -> decode해서 해당 데이터 배열에 저장
        dao.search()
        setFoodDatas()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "음식을 검색하세요"
        
        definesPresentationContext = true
        
        setNavigationBar()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        tableView.reloadData() 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setFoodDatas() {
        if let savedFoodDatas = UserDefaults.standard.object(forKey: "foodDatas") as? Data {
            let decoder = JSONDecoder()
            if let loadedFoods = try? decoder.decode([Foods].self, from: savedFoodDatas) {
                self.dataArr = loadedFoods
            }
        }
        
    }
    
    func filterContentForSearchText(searchText: String) {
      filteredDatas = dataArr.filter { (food: Foods) -> Bool in
        return food.foodName.contains(searchText)
      }
      tableView.reloadData()
    }
    
    private func setUI() {
//        label.textAlignment = .center
//               label.text = "테이블뷰"
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    private func setNavigationBar() {
//        navigationController?.navigationBar.is®Hidden = true
        
        navigationItem.title = "검색"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(goBack(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "barcode"), style: .plain, target: self, action: #selector(tapBarcodeBtn(_:)))
        navigationItem.searchController = searchController
        
    }
    
    @objc private func tapBarcodeBtn(_ sender: UIBarButtonItem) {
        let camVC = CameraViewController()
        camVC.delegate = self
        present(camVC, animated: true)
//        navigationController?.pushViewController(camVC, animated: true)
    }
    
    @objc private func goBack(_ sender: UIBarButtonItem) {
            dismiss(animated: true)
    //        navigationController?.pushViewController(camVC, animated: true)
        }
    
    func barcodeSearching(barcode: String) {
        ref.child("products").child(barcode).observeSingleEvent(of: .value, with: {( DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.label.text = value?["제품명"] as? String ?? "데이터가 없습니다"
            print(self.label.text!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

extension FoodSearchViewController: SendBarcodeDataDelegate {
    func sendBarcodeData(barcode: String) {
        barcodeSearching(barcode: barcode)
    }
}

extension FoodSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredDatas.count
        }
        
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let food: Foods
        
        if isFiltering {
            food = filteredDatas[indexPath.row]
        } else {
            food = dataArr[indexPath.row]
        }
        cell.textLabel?.text = food.foodName
        return cell
    }
    
}

extension FoodSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let dailyVC = DailyViewController()
        
        dump(presentingViewController)
        
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("0000") }
        guard let navi = tabbar.viewControllers?[1] as? UINavigationController else {return print("1111")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("222")}
        
        
        let food: Foods
        
        if isFiltering {
            food = filteredDatas[indexPath.row]
        } else {
            food = dataArr[indexPath.row]
        }
        
        switch self.section {
        case 0: dailyVC.breakfast.append(food)
        case 1: dailyVC.lunch.append(food)
        case 2: dailyVC.dinner.append(food)
        case 3: dailyVC.snack.append(food)
        default: print("안됨")
        }
        dailyVC.tableView.reloadData()
        
        self.dismiss(animated: true)
        print(food)
    }
}

extension FoodSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
    
}
