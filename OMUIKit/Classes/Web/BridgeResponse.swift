//
//  BridgeResult.swift
//  VoiceProject
//
//  Created by 印聪 on 2023/3/6.
//

import Foundation

public class BridgeResponse {
    private(set) var request: BridgeRequest
    
    private(set) var status: Int
    private(set) var result: BridgeResponseData? = BridgeResponseData()

    public init(request: BridgeRequest, result: BridgeResult) {
        self.request = request
        switch result {
        case .success(let data):
            self.status = 200
            self.result?.data = data
        case .responseValidationFailed(let reason):
            self.status = reason.rawValue
            self.result = nil
        case .internalError(let code, let data):
            self.status = 200
            self.result?.code = code
            self.result?.data = data
        }
    }
    
    public func toDictionary() -> [String: Any] {
        var result = [String: Any]()
        result["status"] = self.status
        result["data"] = self.result?.toDictionary()
        return result
    }
    
}


class BridgeResponseData {
    var code = "00000000"
    var data: Any?
    
    func toDictionary() -> [String: Any] {
        var paramaters = [String: Any]()
        paramaters["code"] = code
        paramaters["data"] = data
        return paramaters
    }
}
