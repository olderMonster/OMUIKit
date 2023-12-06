//
//  NativeMethodRegister.swift
//  VoiceProject
//
//  Created by 印聪 on 2023/3/6.
//

import Foundation
import WKWebViewJavascriptBridge

extension OMWebViewController {
    
    func registerNativeMethod() {
        guard let handlerName = self.bridgeImp?.executeKey else { return }
        javaScriptBridge.register(handlerName: handlerName) { [weak self] (parameters, callback) in
            let method = parameters?["methodName"] as? String ?? ""
            let params = parameters?["params"] as? [String: Any]
            let request = BridgeRequest(type: .jsCallNative, handlerName: method, url: self?.urlString, paramaters: params)
            if let element: BridgeExecute = self?.bridgeImp?.getElement(request: request) {
                element.asyncExecute(viewController: self, request: request) { result in
                    let response = BridgeResponse(request: request, result: result)
                    callback?(response.toDictionary())
                    return response
                }
            } else {
                let response = BridgeResponse(request: request, result: .responseValidationFailed(reason: .notImplemented))
                callback?(response.toDictionary())
            }
        }
        
    }
    
}
