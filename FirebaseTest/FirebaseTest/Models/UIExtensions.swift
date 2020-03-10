//
//  UIExtensions.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/09.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit

extension UIWindow {
    // rootView 교체 할 때 애니메이션 넣는 기능
    func switchRootViewController(_ viewController: UIViewController,  animated: Bool, duration: TimeInterval, options: UIView.AnimationOptions, completion: (() -> Void)?) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}

extension UITextField {
    // textfield에 키보드 대신 datePicker 넣는 기능
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date
        
        // 나이 제한: 10세부터 100세까지
        datePicker.maximumDate = NSCalendar.current.date(byAdding: .year, value: -10, to: Date())
        datePicker.minimumDate = NSCalendar.current.date(byAdding: .year, value: -100, to: Date())
        datePicker.locale = Locale(identifier: "ko_KR")
        self.inputView = datePicker
        
        // datePicker 위에 확인 취소 버튼 만들기
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "확인", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

extension CALayer {
    
    // 쓰진 않았는데 유용할거 같아서 남겨둠 view Layer 그릴때 일부분만 선택해서 그릴수 있도록 하는 기능
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case .top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case .bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case .left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case .right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension UIButton {
    
    // 버튼 상태별로 백그라운드 컬러 지정 할 수 있는 기능 ex) 버튼의 state가 .normal 일땐 보라색, .disabled 일 땐 회색 등
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
