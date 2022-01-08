//
//  CodableError.swift
//  CodableKit
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation




struct CodableError: LocalizedError {
    
    let message: String
    var errorDescription: String? { message }
    
}
