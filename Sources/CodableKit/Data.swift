//
//  Data.swift
//  CodableKit
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import LogKit



extension Data {
    
    
    public var prettyJSON: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8)
        else { return String(decoding: self, as: UTF8.self) }
        return prettyPrintedString
    }
    
    func print() { logInfo(prettyJSON) }
    
    
}
