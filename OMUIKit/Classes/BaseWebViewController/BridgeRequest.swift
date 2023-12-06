//
//  BridgeRequest.swift
//  MTBaseModule
//
//  Created by 印聪 on 2023/3/9.
//

import Foundation

public enum BridgeCallType {
    case jsCallNative
    case nativeCallJS
}

public class BridgeRequest: NSObject {
//    public let id = NSUUID().uuidString
    public let type: BridgeCallType
    public let handlerName: String
    public let url: String?
    public let paramaters: [String: Any]?
    
    
    init(type: BridgeCallType, handlerName: String, url: String?, paramaters: [String : Any]? = nil) {
        self.type = type
        self.handlerName = handlerName
        self.url = url
        self.paramaters = paramaters
    }
}
