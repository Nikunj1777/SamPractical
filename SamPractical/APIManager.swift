//
//  APIManager.swift
//  SamPractical
//
//  Created by nikunj sareriya on 03/05/22.
//

import Foundation
import Alamofire

let user_api = "https://cafe.shopfast.com/api/v1/catalog/products/app-products"

class ApiManager: NSObject {
    
    // Asynchronous Method
    class func callRequest(_ url: String, withParameters parameters: [String: Any], header: [String: String], requestTimeOut duration: Int, success: @escaping (Any) -> Void, failure: @escaping (Error) -> Void) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(duration)
        AF.request(url, method: .get, parameters: parameters, headers: HTTPHeaders.init(header)).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let data):
                success(data as Any)
            case .failure(let error):
                failure(error as Error)
            }
        })
    }
}


