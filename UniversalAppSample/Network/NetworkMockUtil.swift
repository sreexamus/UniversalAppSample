//
//  NetworkMockUtil.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 4/7/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

final class NetworkMockUtil {
    static let shared = NetworkMockUtil()
    
    func dataFromFile(_ filename: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            throw ErrorResult.error("File Not found")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
        return data
    }
    
    func shouldRunInMockContext() -> Bool {
        return true
    }
}

enum ErrorResult: Error {
    case error(String)
    case warning(String)
    case info(String, String)
    case parse(String)
}
