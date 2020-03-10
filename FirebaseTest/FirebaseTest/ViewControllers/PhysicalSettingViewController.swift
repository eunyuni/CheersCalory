//
//  PhysicalSettingViewController.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

// 여기서 받아서 성별, 생년, 키, 체중을 Struct 타입의 userdefault로 저장
// userDefault가 있으면 화면 넘어갈거고 없으면 안넘어감

class PhysicalSettingViewController: UIViewController {
    var gender = ""
    var age = 0
    var height = 0
    var weight = 0
    
    private let heightLbl = UILabel()
    private let heightTf = UITextField()
    private let weightLbl = UILabel()
    private let weightTf = UITextField()
    private let infoLbl = UILabel()
    private let completeBtn = UIButton()
    
    private let userDefault = UserDefaults.standard
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gender, age)
        heightTf.delegate = self
        weightTf.delegate = self
        
        view.backgroundColor = .white
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func setUI() {
        let uiArr = [heightLbl, heightTf, weightLbl, weightTf, infoLbl, completeBtn]
        uiArr.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        heightLbl.text = "제 키는"
        heightLbl.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        heightLbl.textAlignment = .center
        
        heightTf.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        heightTf.textAlignment = .center
        heightTf.layer.borderWidth = 1
        
        heightTf.layer.borderColor = UIColor.black.cgColor
        heightTf.keyboardType = .numberPad
        
        weightLbl.text = "체중은요"
        weightLbl.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        weightLbl.textAlignment = .center
        
        weightTf.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        weightTf.textAlignment = .center
        weightTf.layer.borderWidth = 1
        weightTf.layer.borderColor = UIColor.black.cgColor
        weightTf.keyboardType = .numberPad
        
        infoLbl.text = ""
        infoLbl.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        infoLbl.textAlignment = .center
        
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setBackgroundColor(#colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1), for: .normal)
        completeBtn.setBackgroundColor(.lightGray, for: .disabled)
//        completeBtn.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.2235294118, blue: 0.9843137255, alpha: 1)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .light)
        completeBtn.addTarget(self, action: #selector(completeBtn(_:)), for: .touchUpInside)
        completeBtn.isEnabled = false
        
        setConstraints()
    }
    
    private func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            heightLbl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            heightLbl.topAnchor.constraint(equalTo: guide.topAnchor, constant: 50),
            heightLbl.widthAnchor.constraint(equalToConstant: 200),
            heightLbl.heightAnchor.constraint(equalToConstant: 50),
            
            heightTf.topAnchor.constraint(equalTo: heightLbl.bottomAnchor, constant: 10),
            heightTf.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            heightTf.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            heightTf.heightAnchor.constraint(equalToConstant: 50),
            
            weightLbl.topAnchor.constraint(equalTo: heightTf.bottomAnchor, constant: 100),
            weightLbl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            weightLbl.widthAnchor.constraint(equalToConstant: 200),
            weightLbl.heightAnchor.constraint(equalToConstant: 50),
            
            weightTf.topAnchor.constraint(equalTo: weightLbl.bottomAnchor, constant: 10),
            weightTf.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            weightTf.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            weightTf.heightAnchor.constraint(equalToConstant: 50),
            
            infoLbl.topAnchor.constraint(equalTo: weightTf.bottomAnchor, constant: 10),
            infoLbl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            infoLbl.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.7),
            
            completeBtn.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            completeBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            completeBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            completeBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // 애초에 다 입력 되면 활성화하자!
    @objc private func completeBtn(_ sender: UIButton) {
        print("완료")
        var userInfo = UserInfo.shared
        userInfo.gender = self.gender
        userInfo.age = self.age
        userInfo.height = self.height
        userInfo.weight = self.weight
        
        // userDefault에 저장
        userDefault.set(try? JSONEncoder().encode(userInfo), forKey: "userInfo")
        setRootView(window: appDelegate.window!)
    }
}

extension PhysicalSettingViewController: UITextFieldDelegate {
    
    // 입력한 값 전역변수에 넘겨주고, (나중에 전역변수를 통해 UserDefault로 저장할 거임) 모든 텍스트필드를 다 입력해야
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let height = heightTf.text, let weight = weightTf.text else { return }
        if textField == weightTf {
            self.weight = Int(weight) ?? 0
            view.endEditing(true)
        } else {
            self.height = Int(height) ?? 0
            view.endEditing(true)
        }
        
        if height != "" && weight != "" {
            completeBtn.isEnabled = true
        } else {
            completeBtn.isEnabled = false
        }
    }
    
    // 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 3
    }
}
