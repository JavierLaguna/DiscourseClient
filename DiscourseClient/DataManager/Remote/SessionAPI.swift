//
//  APIClient.swift
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation
import UIKit

enum SessionAPIError: Error {
    case emptyData
}

/// Clase de utilidad para llamar al API. El método Send recibe una Request que implementa APIRequest y tiene un tipo Response asociado
final class SessionAPI {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    func send<T: APIRequest>(request: T, completion: @escaping(Result<T.Response, Error>) -> ()) {
        let request = request.requestWithBaseUrl()
        
        let task = session.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.emptyData))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
