//
//  AppNetwork.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/10/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResult<T> {
    case success(T)
    case failure(Error?)
}

class AppNetwork {
    
    static let shared = AppNetwork()
    let secureHttp: String = "https://"
    
    static var client: SessionManager = {
               let configuration = URLSessionConfiguration.default
        // If in develop use below condition
        if false {
                    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
                    configuration.requestCachePolicy = .reloadIgnoringCacheData
                    configuration.urlCache = nil
        } else {
            // In Mock Test Mode
            configuration.protocolClasses = [CustomUrlProtocol.self as AnyClass]
        }

        return SessionManager(configuration: configuration, serverTrustPolicyManager: nil)
    }()
    
    func request(target: ServiceTarget, completion: @escaping (ServiceResult<Data>)-> ()) {
        
        let url = secureHttp+target.group+target.route
        
        AppNetwork.client.request(url, method: target.methodType, parameters: target.params, encoding: target.encoding, headers: target.headers).responseData {  response in
            switch response.result {
            case .success(let jsonData):
                 let statusCode = response.response?.statusCode
                 if statusCode == 200 {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                 completion(.failure(error))
            }
        }
    }
    
    func decodeJSONData<T:Decodable>(_ data: Data) throws -> T {
        do {
             return try JSONDecoder().decode(T.self, from: data)
        }
        catch {
            throw error
        }
    }
    
    func wrapCustomerProfile<T:Decodable>(_ data: Data) throws -> [T] {
        do {
            let wrapperResult: CustomerWrapper = try JSONDecoder().decode(CustomerWrapper<T>.self, from: data)
            return wrapperResult.value
        } catch  {
            throw error
        }
    }
}
