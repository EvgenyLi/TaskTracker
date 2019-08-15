//
//  APIRequestBody.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 17/07/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import Alamofire

protocol APIRequestBody {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var cookies: [HTTPCookie] { get }
}

extension APIRequestBody {
    var url: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var cookies: [HTTPCookie] {
        return []
    }
}
