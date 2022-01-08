//
//  Encodable.swift
//  CodableKit
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation




extension Encodable {
    
    
    
    public var data: Data {
        get throws {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            return try encoder.encode(self)
        }
    }
    
    public var stringMessage: String {
        get throws { String(decoding: try data, as: UTF8.self) }
    }
    
    public var base64Data: Data {
        get throws { try data.base64EncodedData() }
    }
    
    public var base64String: String {
        get throws { try data.base64EncodedString() }
    }
    
    public var JSONData: Data {
        get throws {
            let json = try JSONDictionary()
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        }
    }
    
    public var prettyJSON: String {
        let data = try! JSONData
        guard let prettyPrintedString = String(data: data, encoding:.utf8)
        else { return String(decoding: data, as: UTF8.self) }
        return prettyPrintedString
    }
    
    public var JSONDictionary: [String: Any] {
        get throws { try JSONDictionary() }
    }
    
    public func JSONDictionary(options: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any] {
        let data = try data
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: options) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
    
    public func useAsQuery(of url: URL) throws -> URL {
        guard var components = URLComponents(string: url.absoluteString) else { return url }
        let dictionary = try JSONDictionary
        let queryItems = dictionary.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        components.queryItems = queryItems
        return components.url ?? url
    }
    
    
    
}
