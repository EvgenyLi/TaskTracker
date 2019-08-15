//
//  RestAPI.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 17/07/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift

protocol RestAPI {}

extension RestAPI {
    static func request(with body: APIRequestBody) -> Observable<Any> {
        return RestAPITransport().callServerApi(requestBody: body)
    }
    
    static func requestWithoutResponse(with body: APIRequestBody) -> Observable<Void> {
        return request(with: body).flatMap { _ -> Observable<Void> in
            return Observable<Void>.create(with: Void())
        }
    }
    
    static func requestArrayResponse<E>(with body: APIRequestBody, map: @escaping ([[String: AnyObject]]) -> ([E])) -> Observable<[E]> {
        return request(with: body).flatMap { response -> Observable<[E]> in
            guard let array = response as? [[String: AnyObject]] else {
                return .empty()
            }
            
            let result = map(array)
            
            return Observable<[E]>.create(with: result)
        }
    }
    
    static func requestSingleResponse<E>(with body: APIRequestBody, map: @escaping ([String: AnyObject]) -> (E)) -> Observable<E> {
        return request(with: body).flatMap { response -> Observable<E> in
            guard let dict = response as? [String: AnyObject] else {
                return .empty()
            }
            
            let result = map(dict)
            
            return Observable<E>.create(with: result)
        }
    }
}
