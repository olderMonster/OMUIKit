//
//  BridgeError.swift
//  MTBaseModule
//
//  Created by 印聪 on 2023/3/9.
//

import Foundation

//typealias BridgeResult = Result<Any?, BridgeError>

public enum BridgeResult: Error {
 
    public enum ResponseValidationFailureReason: Int {
        case notImplemented = 501
        case notFound = 404
        case badRequest = 400
    }
    
    case success(Any?)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case internalError(code: String, data: Any? = nil)
}
