//
//  CustomerProfileModel.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/9/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

struct CustomerProfile: Decodable {
    let firstName: String
    let lastName: String
    let age: Int
    let country: String
    let city: String
    let id: Int
    let badgeNo: Int
    let bloodGroup: BloodGroup
    
    enum BloodGroup: String, Decodable {
        case bPositive = "BPositive"
        case aPositive = "APositive"
        case aNegative = "ANegative"
        case bNegative = "BNegative"
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
        case age = "Age"
        case country = "Country"
        case city = "City"
        case id = "Id"
        case badgeNo = "BadgeNo"
        case bloodGroup = "BloodGroup"
    }
    
    init(from decoder: Decoder) throws {
         let values =   try decoder.container(keyedBy: CodingKeys.self)
        firstName = (try? values.decode(String?.self, forKey: .firstName) ?? "") ?? ""
        lastName = (try? values.decode(String?.self, forKey: .lastName) ?? "") ?? ""
        city = (try? values.decode(String?.self, forKey: .city) ?? "") ?? ""
        age = (try? values.decode(Int?.self, forKey: .age) ?? 0) ?? 0
        country = (try? values.decode(String?.self, forKey: .country) ?? "") ?? ""
        id = (try? values.decode(Int?.self, forKey: .id) ?? 0) ?? 0
        badgeNo = (try? values.decode(Int?.self, forKey: .badgeNo) ?? 0) ?? 0
        bloodGroup = (try? values.decode(BloodGroup?.self, forKey: .lastName) ?? .bPositive) ?? .bPositive
    }
}


struct CustomerWrapper<T: Decodable>: Decodable {
    let value:[T]
    enum CodingKeys: String, CodingKey { case results = "value" }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decode([T].self, forKey: .results)
    }
    
}

struct CustomerData {
    let profiles: [CustomerProfile]
}
