//
//  RestAPITransport.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 17/07/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift
import Alamofire

class RestAPITransport {
    func callServerApi(requestBody: APIRequestBody) -> Observable<Any> {
        return Observable.create { observer in
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 30
            manager.session.configuration.httpCookieStorage?.setCookies(requestBody.cookies, for: URL(string: requestBody.url), mainDocumentURL: nil)
            
            let request = manager.request(requestBody.url,
                                          method: requestBody.method,
                                          parameters: requestBody.parameters,
                                          encoding: requestBody.encoding,
                                          headers: requestBody.headers)
                .validate(statusCode: [200, 201])
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let json):
                        observer.onNext(json)
                        observer.onCompleted()
                    case .failure(let error):
                        let isNetworkProblem = (error as? URLError)?.code == .notConnectedToInternet || (error as? URLError)?.code == .timedOut
                        let message = isNetworkProblem ? "network_problem" : "unknown_error"
                        let problem = Problem(message: message, code: response.response?.statusCode ?? -1, isNetworkProblem: isNetworkProblem)
                        observer.onError(problem)
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
