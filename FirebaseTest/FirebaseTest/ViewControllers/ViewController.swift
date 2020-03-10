//
//  ViewController.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/05.
//  Copyright © 2020 sandMan. All rights reserved.
//

//import UIKit
//import Firebase
//
//protocol SendBarcodeDataDelegate {
//    func sendBarcodeData(barcode: String)
//}
//
//class ViewController: UIViewController {
//    var delegate: SendBarcodeDataDelegate?
//    var barcode = "여기에 바코드 정보가 입력됩니다."
//    
//    
//    var ref: DatabaseReference!
//    // 데이터 set
////    let jsonData = readJSONFromFile(fileName: "foods")
//    var arrResult = [String]()
//    
//    let infoLbl = UILabel()
//    let cameraBtn = UIButton()
//    
//    override func viewDidLoad() {
//        view.backgroundColor = .white
//        super.viewDidLoad()
//        self.ref = Database.database().reference()
//
//        setUI()
//    }
//    
//    
//    func setUI() {
//        view.addSubview(infoLbl)
//        view.addSubview(cameraBtn)
//        infoLbl.translatesAutoresizingMaskIntoConstraints = false
//        
////        infoLbl.text = "확인"
//        infoLbl.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
//        infoLbl.textAlignment = .center
//        
//        cameraBtn.translatesAutoresizingMaskIntoConstraints = false
//        cameraBtn.setTitle("바코드", for: .normal)
//        cameraBtn.backgroundColor = .systemYellow
//        cameraBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .light)
//        cameraBtn.addTarget(self, action: #selector(roadCamera(_:)), for: .touchUpInside)
//        
//        NSLayoutConstraint.activate([
//            infoLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            infoLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            infoLbl.widthAnchor.constraint(equalToConstant: 200),
//            infoLbl.heightAnchor.constraint(equalToConstant: 50),
//            
//            cameraBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
//            cameraBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            cameraBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            cameraBtn.heightAnchor.constraint(equalToConstant: 50),
//        ])
//        
//        
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        print(self.arrResult)
////        self.infoLbl.text = barcode
//    }
//    
//    // 딕셔너리 형태로 변환하여 리턴해주는 함수
////    func SaveJsonData() -> [String: [String:String]] {
////        var dic = [String: [String:String]]()
////
////        if let food = try? JSONDecoder().decode(HundredGram.self, from: jsonData) {
////            for i in food.gram {
////                dic.updateValue(
////                    ["1회제공량(g)":i.servingSize,
////                     "칼로리(kcal)":i.calory,
////                     "탄수화물(g)":i.carbohydrate,
////                     "단백질(g)":i.protein,
////                     "지방(g)":i.fat],
////                    forKey: i.foodName)
////            }
////        } else {
////            print("왜 안됨")
////        }
////        return dic
////    }
//    
//    // 데이터 베이스에 적절한 형태로 변환해서 저장
////    static func readJSONFromFile(fileName: String) -> Data {
////        var jsonData: Data?
////        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
////            do {
////                let fileUrl = URL(fileURLWithPath: path)
////                // Getting data from JSON file using the file URL
////                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
////                jsonData = data
////            } catch {
////                print(error)
////            }
////        }
////        return jsonData!
////    }
//    
//    func search() {
//        ref.child("foods").queryOrderedByKey().queryStarting(atValue: "김치").queryEnding(atValue: "김치\u{f8ff}").observe(.childAdded, with: {(DataSnapshot) in
//            guard let value = DataSnapshot.value as? NSDictionary else { print("검색 결과를 찾을 수 없습니다."); return }
//            self.arrResult.append(DataSnapshot.key)
//            // 함수를 만들어서 이 안에다가 넣자
//            print("\(DataSnapshot.key): \(value["칼로리(kcal)"] ?? "")")
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
//    
//    func barcodeSearching(barcode: String) {
//        ref.child("products").child(barcode).observeSingleEvent(of: .value, with: {( DataSnapshot) in
//            let value = DataSnapshot.value as? NSDictionary
//            self.infoLbl.text = value?["제품명"] as? String ?? ""
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
//    
//    @objc func roadCamera(_ sender: UIButton) {
//        let camVC = CameraViewController()
//        camVC.delegate = self
//        navigationController?.pushViewController(camVC, animated: true)
//    }
//}
//
//extension ViewController: SendBarcodeDataDelegate {
//    func sendBarcodeData(barcode: String) {
//        barcodeSearching(barcode: barcode)
//    }
//}
//
//
