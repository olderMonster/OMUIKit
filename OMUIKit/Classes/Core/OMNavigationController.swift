//
//  BaseNavigationController.swift
//  VoiceProject
//
//  Created by 印聪 on 2023/3/1.
//

import UIKit

public extension UINavigationController {
    
    /// 导航栏文本样式
    var barTextAttributes: [NSAttributedString.Key: Any] {
        set {
            if #available(iOS 13.0, *) {
                let barAppearance = navigationBar.standardAppearance
                barAppearance.titleTextAttributes = newValue
                if #available(iOS 15.0, *) {
                    navigationBar.scrollEdgeAppearance = barAppearance
                }
            } else {
                navigationBar.titleTextAttributes = newValue
            }
        }
        get {
            if #available(iOS 13.0, *) {
                return navigationBar.standardAppearance.titleTextAttributes
            } else {
                return navigationBar.titleTextAttributes ?? [:]
            }
        }
    }
    
}


open class OMNavigationController: UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        
        barTintColor = UIColor.white
        barTextAttributes = [.foregroundColor: UIColor.black]
        view.backgroundColor = .white
    }
    
    public override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    public override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension OMNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        return true
    }
}
