//
//  CustomerProfileService.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/10/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Alamofire

protocol ServiceTarget {
    var params: [String : Any] { get }
    var methodType: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var mock: String { get }
    var route: String { get }
    var group: String { get }
    var headers: [String: String] { get }
}

extension ServiceTarget {
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var group: String {
        return "customer/profile"
    }
    
    var headers: [String: String] {
        return [:]
    }
}

enum CustomerService: ServiceTarget {
 
    case profile(CustomerProfileParameters)
    case contactInfo(CustomerInfoParameters)
    
    struct CustomerProfileParameters: Encodable {
        let  tokenId: String
        struct ClientSginature {
            let signature: String
        }
    }
    
    struct CustomerInfoParameters: Encodable {
        let  custid: String
        let tokenId: String
    }
    
    var params: [String: Any] {
        
        func parameters<T: Encodable>(_ model: T) -> [String: Any] {
            do {
                return try JSONSerialization.jsonObject(with: (try JSONEncoder().encode(model))) as? [String: Any] ?? [:]
            } catch(let error) {
                print(error)
                return [:]
            }
        }
        switch self {
        case .profile(let model):
            return parameters(model)
        case .contactInfo:
            return ["user":"sree"]
        }
    }
    
    var route: String {
        switch self {
        case .profile:
            return Constants.customerProfile
        case .contactInfo:
            return Constants.customerContactInfo
        }
    }
    
    var methodType: HTTPMethod {
        switch self {
        case .profile:
            return .post
        case .contactInfo:
            return .get
        }
    }
    
    var mock: String {
        return "CustomerProfile"
    }
}

struct CustomerProfileService {
    
    func getCustomerProfile(completion: @escaping (ServiceResult<CustomerData>) -> ()) {
        AppNetwork.shared.request(target: CustomerService.profile(CustomerService.CustomerProfileParameters(tokenId: "32313"))) { result in
            switch result {
            case .success(let data):
                if let profiles: [CustomerProfile] =  try? AppNetwork.shared.wrapCustomerProfile(data) {
                     completion(.success(CustomerData(profiles: profiles)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            }
        }
}
