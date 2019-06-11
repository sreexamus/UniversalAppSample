//
//  CustomerInfoModel.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 4/7/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

struct CustomerInfo: Decodable {
    let phoneNumber: String
    let firstName: String
    let address: String
    let apartmentNo: Int
    let linkedin: String
    let email: String
    let employer: String
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "PhoneNumber"
        case firstName = "FirstName"
        case address = "Address"
        case apartmentNo = "ApartmentNo"
        case linkedin = "Linkedin"
        case email = "Email"
        case employer = "Employer"
    }
    
    init(from decoder: Decoder) throws {
        let values =   try decoder.container(keyedBy: CodingKeys.self)
        firstName = (try? values.decode(String?.self, forKey: .firstName) ?? "") ?? ""
        phoneNumber = (try? values.decode(String?.self, forKey: .phoneNumber) ?? "") ?? ""
        address = (try? values.decode(String?.self, forKey: .address) ?? "") ?? ""
        apartmentNo = (try? values.decode(Int?.self, forKey: .apartmentNo) ?? 0) ?? 0
        linkedin = (try? values.decode(String?.self, forKey: .linkedin) ?? "") ?? ""
        email = (try? values.decode(String?.self, forKey: .email) ?? "") ?? ""
        employer = (try? values.decode(String?.self, forKey: .employer) ?? "") ?? ""
    }
}

struct CustomerContactInfoData {
    let info: [CustomerInfo]
}
