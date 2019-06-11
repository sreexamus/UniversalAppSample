//
//  CustomURLProtocol.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 4/7/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

class CustomUrlProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        print("Request #: URL = \(request.url?.absoluteString)")
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override  func startLoading() {
        guard let url = request.url else { return }
        
        var mockResponse: MockResponse? = nil
        var mockData: Data?
        if url.absoluteString.contains(Constants.customerProfile), let mockRes = getMockResponse("CustomerProfile"), let mockDat =  mockRes.body {
            mockResponse = mockRes
            mockData = mockDat
        } else if url.absoluteString.contains(Constants.customerContactInfo), let mockRes = getMockResponse("CustomerInfo"),  let mockDat =  mockRes.body  {
            mockResponse = mockRes
           mockData = mockDat
        }
        let httpResponse = HTTPURLResponse(url: mockResponse?.url ?? self.request.url!, statusCode: mockResponse?.statusCode ?? 200, httpVersion: mockResponse?.httpVersion, headerFields: mockResponse?.headers)!
        
       
        
        self.client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: mockData ?? Data())
         client?.urlProtocolDidFinishLoading(self)
    }
    
    func getMockResponse(_ mockFileName: String) ->  MockResponse? {
        guard let responseData = try? NetworkMockUtil.shared.dataFromFile(mockFileName) else { return nil }
       return MockResponse(statusCode: 200, body: responseData, httpVersion: nil, headers: nil, replacements: nil)
    }
    
   override func stopLoading() {
    }
}



struct MockResponse {
    let url: URL?
    let statusCode: Int
    let body: Data?
    let httpVersion: String?
    let headers: [String: String]?
    let replacements: [[String: Any]]?
    
    fileprivate init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else {
            return nil
        }
        if let urlString = dictionary["url"] as? String, let url = URL(string: urlString) {
            self.url = url
        } else {
            self.url = nil
        }
        guard let statusCode = dictionary["statusCode"] as? Int else {
            return nil
        }
        
        self.statusCode = statusCode
        
        if let bodyFile = dictionary["bodyFile"] as? String, let url = Bundle.allBundles.first(where: { $0.url(forResource: bodyFile, withExtension: nil) != nil })?.url(forResource: bodyFile, withExtension: nil), let data = try? Data(contentsOf: url) {
            self.body = data
        }
        else if let bodyString = dictionary["body"] as? String, let data = bodyString.data(using: .utf8) {
            self.body = data
        }
        else {
            self.body = nil
        }
        
        self.httpVersion = dictionary["httpVersion"] as? String
        self.headers = dictionary["headers"] as? [String: String]
        self.replacements = dictionary["replacements"] as? [[String: Any]]
    }
    
    init(statusCode: Int, body:Data?, url:URL? = nil, httpVersion: String? = nil, headers:[String: String]? = nil, replacements:[[String: Any]]? = nil) {
        self.url = url
        self.statusCode = statusCode
        self.body = body
        self.httpVersion = httpVersion
        self.headers = headers
        self.replacements = replacements
    }
}
