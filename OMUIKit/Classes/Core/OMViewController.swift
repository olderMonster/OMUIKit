//
//  BaseViewController.swift
//  VoiceProject
//
//  Created by 印聪 on 2023/2/20.
//

import UIKit

//private var key: Void?
//extension UIViewController {
//    var isBarHidden: Bool {
//        get {
//            return objc_getAssociatedObject(self, &key) as? Bool ?? false
//        }
//        set {
//            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_ASSIGN)
//        }
//    }
//}

extension UIViewController {

    /// 导航栏背景颜色
    public var barTintColor: UIColor? {
        set {
            guard let navigationController = self is UINavigationController ? (self as! UINavigationController): navigationController else { return }
            if #available(iOS 13.0, *) {
                let appearance = navigationController.navigationBar.standardAppearance
                appearance.backgroundColor = newValue
                if newValue == .clear {
                    appearance.configureWithTransparentBackground()
                }
                appearance.shadowColor = .clear
                navigationController.navigationBar.standardAppearance = appearance
                if #available(iOS 15.0, *) {
                    navigationController.navigationBar.scrollEdgeAppearance = appearance
                }
            } else {
                navigationController.navigationBar.barTintColor = newValue
            }
        }
        get {
            guard let navigationController = navigationController else { return nil }
            return navigationController.navigationBar.barTintColor
        }
    }
}


open class OMViewController: UIViewController {
    
    /// 导航栏显示隐藏
    public var isBarHidden: Bool = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(isBarHidden, animated: animated)
    }
    
}
