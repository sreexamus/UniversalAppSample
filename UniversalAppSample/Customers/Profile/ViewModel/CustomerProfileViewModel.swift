//
//  CustomerProfileViewModel.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/9/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//


struct CustomerProfileViewModel {
    let customerServiceObj = CustomerProfileService()
    func fetchCustomerProfileData(customerId: Int, completion: @escaping (ServiceResult<CustomerData>) -> ()) {
        customerServiceObj.getCustomerProfile { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
