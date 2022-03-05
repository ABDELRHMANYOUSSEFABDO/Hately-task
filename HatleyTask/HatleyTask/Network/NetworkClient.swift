//
//  NetworkClient.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class NetworkClient {
    
    func performRequest<T>(_ object: T.Type, router: APIRouter) -> Single<T> where T : Decodable {
        return Single.create { (observer) -> Disposable in
            AF.request(router)
                .validate()
                .responseJSON{ (response) in
                    switch response.result{
                    case .success:
                        do {
                            guard let data = response.data else { return }
                        
                            let responseModel = try JSONDecoder().decode(T.self, from: response.data!)
                            observer(.success(responseModel))
                            //observer(isResponseSuccessed ?.success(responseModel) :.failure(AppError(message: responseModel.message)))
                            return
                        } catch let error{
                            observer(.failure(error))
                            return
                        }
                    case let .failure(_):
                        if let statusCode = response.response?.statusCode{
                            switch ServiceError.init(rawValue: statusCode){
                            case .badRequest:
                                do {
                                    let failerResponseModel = try JSONDecoder().decode(ServerErrorResponse.self, from: response.data!)
                                    guard let errors = failerResponseModel.errors ,!errors.name.isEmpty else{
                                        // FIXME: Update with Localized message
                                        #warning("Update with Localized message")
                                        observer(.failure(AppError(message: "")))
                                        return
                                    }

                                    observer(.failure(AppError(message: errors.name[0] )))
                                    return
                                } catch let error{
                                    observer(.failure(error))
                                    return
                                }
                            default:
                                if let reason = ServiceError(rawValue: statusCode){
                                    observer(.failure(reason))
                                    return
                                }
                            }
                        }
                        observer(.failure(AppError(message: "No internet connection")))
                    }
                }.resume()
            return Disposables.create()
        }
    }

}
