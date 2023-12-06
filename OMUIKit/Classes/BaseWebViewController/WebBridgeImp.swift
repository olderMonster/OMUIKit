//
//  WebBridgeImp.swift
//  VoiceProject
//
//  Created by 印聪 on 2023/3/7.
//

import Foundation


public protocol BridgeExecute {
    
    /// 执行JS调用逻辑
    /// - Parameters:
    ///   - viewController: 当前控制器
    ///   - parameters: 参数
    ///   - callback: 返回执行结果
    func asyncExecute(viewController: OMWebViewController?, request: BridgeRequest, callback: (BridgeResult) -> BridgeResponse)
}


public protocol WebBridgeImp {

    /// JS调用Native方法名
    var executeKey: String { get }
    
    /// 获取当前对象
    /// - Parameter handlerName: JS调用方法名
    /// - Returns: 对象
    func getElement(request: BridgeRequest) -> BridgeExecute?
    
    
    /// 原生调用Native方法时可以在这里统一转化处理
    /// - Parameters:
    ///   - method: 方法名称
    ///   - args: 参数
    /// - Returns: 是否调用
    func reformer(request: BridgeRequest) -> Bool
}


public extension WebBridgeImp {
    var executeKey: String {
        return "invoke"
    }
    
    func reformer(request: BridgeRequest) -> Bool { true }
}
