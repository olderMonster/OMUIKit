//
//  BaseWebViewController.swift
//  VoiceProject
//
//  Created by 印聪 on 2023/3/2.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge


public protocol OMWebViewDelegate: NSObjectProtocol {
    
    /// 拦截webView decidePolicyFor方法自定义跳转
    /// - Parameter urlString: 当前Web内部跳转URL
    /// - Returns: 是否允许WebView跳转到该URL
    func canOpenNativePage(urlString: String?) -> Bool
}

open class OMWebViewController: OMViewController {
    
    /// Web内点击重定向
    weak public var customRoute: OMWebViewDelegate?
    
    /// JS交互实现
    public var bridgeImp: WebBridgeImp? {
        didSet {
            //注册JS交互
            registerNativeMethod()
        }
    }
    
    /// 网页URL
    public var urlString: String? {
        didSet {
            if let string = urlString, !string.isEmpty {
                if let url = URL(string: string) {
                    webView.load(URLRequest(url: url))
                }
            }
        }
    }
    

    public lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view.allowsBackForwardNavigationGestures = true
        view.uiDelegate = self
        view.navigationDelegate = self
        return view
    }()
    
    public lazy var javaScriptBridge: WKWebViewJavascriptBridge = {
        let bridge = WKWebViewJavascriptBridge(webView: webView)
        #if DEBUG
        bridge.isLogEnable = true
        #endif
        return bridge
    }()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(webView)
    }

    open override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
    public func call(handlerName: String, paramaters: [String: Any]? = nil, handler: ((Any?) -> ())? = nil) {
        if let target = bridgeImp {
            let request = BridgeRequest(type: .nativeCallJS, handlerName: handlerName, url: urlString, paramaters: paramaters)
            if !target.reformer(request: request) {
                return;
            }
        }
        javaScriptBridge.call(handlerName: handlerName, data: paramaters) { responseData in
            handler?(responseData)
        }
    }
    
}


//MARK: -- WKUIDelegate
extension OMWebViewController: WKUIDelegate {
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController:UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alertController, animated: true) {
            
        }
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController:UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        self.present(alertController, animated: true) {
            
        }
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController:UIAlertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "完成", style: .default, handler: { (action) in
            completionHandler(alertController.textFields?.first?.text)
        }))
    }
    
}


extension OMWebViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载网页")
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网页加载结束")
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("网页加载失败：\(error)")
    }
    

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let target = customRoute {
            let isCustomized = target.canOpenNativePage(urlString: navigationAction.request.url?.absoluteString)
            isCustomized ? decisionHandler(.cancel): decisionHandler(.allow)
            return;
        }
        decisionHandler(.allow)
        return;
    }

//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        //点击富文本跳转到浏览器
//        if let absoluteString = webView.url?.absoluteString, absoluteString.hasPrefix("http"), allowRedirect {
//            if let browserURL = webView.url {
//                if UIApplication.shared.canOpenURL(browserURL) {
//                    UIApplication.shared.open(browserURL)
//                    decisionHandler(.cancel)
//                    return;
//                }
//            }
//        }
//        decisionHandler(.allow)
//    }
}

