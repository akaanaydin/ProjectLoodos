//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

import Alamofire

//MARK: - Service Manager
final class ServiceManager {
    public static let shared: ServiceManager = ServiceManager()
}

//MARK: - Generic Service Function
extension ServiceManager {
    func fetch<T>(path: String, onSuccess: @escaping (T) -> Void, onError: @escaping (AFError) -> Void) where T: Codable {
        AF.request(path,
                   encoding: JSONEncoding.default
        ).validate().responseDecodable(of: T.self) { (response) in
            guard let model = response.value else {
                return
            }
            onSuccess(model)
        }
    }
}
