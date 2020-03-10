//
//  StartViewController.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate {
    
    private let iAmLbl = UILabel()
    private let genderSeg = UISegmentedControl(items: ["남자", "여자"])
    private let birthLbl = UILabel()
    private let birthTf = UITextField()
    private let infoLbl = UILabel()
    private let nextBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthTf.delegate = self
        self.navigationItem.title = "사용자"
        setUI()
        self.birthTf.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    private func setUI() {
        let uiArr = [iAmLbl, genderSeg, birthLbl, birthTf, infoLbl, nextBtn]
        uiArr.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        iAmLbl.text = "저는요"
        iAmLbl.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        iAmLbl.textAlignment = .center
        
        genderSeg.selectedSegmentIndex = 1
        genderSeg.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .ultraLight)], for: .normal)
        genderSeg.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .selected)
        genderSeg.layer.borderWidth = 1
        genderSeg.layer.borderColor = UIColor.black.cgColor
        genderSeg.selectedSegmentTintColor =  #colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1) // 126, 57, 251
//        genderSeg.layer.addBorder([.all], color: .black, width: 1) 안먹힘
        genderSeg.addTarget(self, action: #selector(switchGender(_:)), for: .valueChanged)
        
        birthLbl.text = "생년월일은"
        birthLbl.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        birthLbl.textAlignment = .center
        
        birthTf.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        birthTf.textAlignment = .center
        birthTf.layer.borderWidth = 1
        birthTf.layer.borderColor = UIColor.black.cgColor
        
        infoLbl.text = "이를 토대로 정확한 칼로리 목표가 계산됩니다."
        infoLbl.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        infoLbl.textAlignment = .center
        
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setBackgroundColor(#colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1), for: .normal)
        nextBtn.setBackgroundColor(.lightGray, for: .disabled)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .light)
        nextBtn.addTarget(self, action: #selector(goNext(_:)), for: .touchUpInside)
        nextBtn.isEnabled = false
        
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            iAmLbl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            iAmLbl.topAnchor.constraint(equalTo: guide.topAnchor, constant: 50),
            iAmLbl.widthAnchor.constraint(equalToConstant: 200),
            iAmLbl.heightAnchor.constraint(equalToConstant: 50),
            
            genderSeg.topAnchor.constraint(equalTo: iAmLbl.bottomAnchor, constant: 10),
            genderSeg.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            genderSeg.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            genderSeg.heightAnchor.constraint(equalToConstant: 50),
            
            birthLbl.topAnchor.constraint(equalTo: genderSeg.bottomAnchor, constant: 100),
            birthLbl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            birthLbl.widthAnchor.constraint(equalToConstant: 200),
            birthLbl.heightAnchor.constraint(equalToConstant: 50),
            
            birthTf.topAnchor.constraint(equalTo: birthLbl.bottomAnchor, constant: 10),
            birthTf.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            birthTf.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            birthTf.heightAnchor.constraint(equalToConstant: 50),
            
            infoLbl.topAnchor.constraint(equalTo: birthTf.bottomAnchor, constant: 10),
            infoLbl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            infoLbl.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.7),
            
            nextBtn.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            nextBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            nextBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            nextBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func switchGender(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("남자"); break
        case 1:
            print("여자"); break
        default:
            break
        }
    }
    
    // 다 입력해야만 활성화
    @objc private func goNext(_ sender: UIButton) {
        let physicalVC = PhysicalSettingViewController()
        navigationController?.pushViewController(physicalVC, animated: true)
        
        // 생년월일 텍스트필드 값 Date 타입으로 변환
        let dateStr = birthTf.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        // 오늘 - 생일 = 만 나이 구하기
        let birthDay = dateFormatter.date(from: dateStr)
        let today = Date()
        let different = today.timeIntervalSince(birthDay!)
        let age = Int(different / (86400 * 365))
        
        // 세그먼트에 선택 된 타이틀 값 저장
        let gender = genderSeg.titleForSegment(at: genderSeg.selectedSegmentIndex)!
        
        // 여기서 세그먼트 값(성별)이랑, 생년월일 전역변수에 저장
        physicalVC.gender = gender
        physicalVC.age = age
    }
    
    // 생년월일 확인 버튼
    @objc private func tapDone() {
        // datePicker에서 선택한 날짜 String type으로 textfield에 뿌림
        if let datePicker = self.birthTf.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY년 M월 d일"
            self.birthTf.text = dateformatter.string(from: datePicker.date)
        }
        self.birthTf.resignFirstResponder() // 2-5
    }
    
    // 다음 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard birthTf.text != nil else { return }
        nextBtn.isEnabled = true
    }
}
