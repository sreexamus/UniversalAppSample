//
//  CustomerInfoViewModel.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/9/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

struct CustomerInfoViewModel {
    let service = CustomerInfoService()
    func getCustomerContactInfo(completion: @escaping (ServiceResult<CustomerContactInfoData>) -> ()) {
        service.invokeCustomerInfo { result in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
