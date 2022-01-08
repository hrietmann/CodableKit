//
//  Decodable.swift
//  CodableKit
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import LogKit



extension Decodable {
    
    
    public static func from(data: Data, debug: Bool = false) throws -> Self {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(Self.self, from: data)
        }
        catch let decodingError as DecodingError {
            
            let error: Error
            switch decodingError {
            case .dataCorrupted(let context):
                error = CodableError(message: context.debugDescription + ".\nKey path: \(context.path)")
            case .keyNotFound(let key, let context):
                error = CodableError(message: "\(key.stringValue) was not found, \(context.debugDescription).\nKey path: \(context.path)")
            case .typeMismatch(let type, let context):
                error = CodableError(message: "\(type) was expected, \(context.debugDescription).\nKey path: \(context.path)")
            case .valueNotFound(let type, let context):
                error = CodableError(message: "No value was found for parameter of type \(type) at path \(context.codingPath.map({$0.stringValue}).joined(separator: "/")), \(context.debugDescription)")
            @unknown default:
                error = decodingError
            }
            
            defer { if debug { data.print() } }
            if debug { logError(error) }
            throw error
            
        } catch {
            
            defer { if debug { data.print() } }
            throw error
            
        }
    }
    
    
}



extension DecodingError.Context {
    var path: String { codingPath.map({$0.stringValue}).joined(separator: "/") }
}
