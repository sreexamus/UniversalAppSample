//
//  CustomerProfileService.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 4/7/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

struct CustomerInfoService {
    
    func invokeCustomerInfo(completion: @escaping (ServiceResult<CustomerContactInfoData>) -> ()) {
        AppNetwork.shared.request(target: CustomerService.contactInfo(CustomerService.CustomerInfoParameters.init(custid: "323", tokenId: "354"))) { result in
            switch result {
            case .success(let data):
                if let info: [CustomerInfo] =  try? AppNetwork.shared.wrapCustomerProfile(data) {
                    completion(.success(CustomerContactInfoData(info: info)))
                } else {
                    completion(.failure(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
