//
//  ApiClient.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation
import Alamofire

class ApiClient {
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    private var sessionManager: Alamofire.Session
    
    class WildcardServerTrustPolicyManager: ServerTrustManager {
        override func serverTrustEvaluator(forHost host: String) throws -> (any ServerTrustEvaluating)? {
            if let policy = evaluators[host] {
                return policy
            }
            var domainComponents = host.split(separator: ".")
            if domainComponents.count > 2 {
                domainComponents[0] = "*"
                let wildcardHost = domainComponents.joined(separator: ".")
                return evaluators[wildcardHost]
            }
            return nil
        }
    }
    
    init() {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            "*.rickandmortyapi.com": PinnedCertificatesTrustEvaluator()
        ]
        
        
        let wildcard = WildcardServerTrustPolicyManager(evaluators: serverTrustPolicies)
        self.sessionManager = Session(configuration: URLSessionConfiguration.default, serverTrustManager: wildcard)
    }
    
    func request(
        endPoint: Endpoints.RawValue,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        success: @escaping (Data?) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let url = baseUrl + endPoint
        sessionManager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .response { response in
                switch response.result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    failure(error.localizedDescription)
                }
                    
            }
    }
    
    
    func charactersRequest(
        success: @escaping (CharactersDTO) -> Void,
        failure: @escaping (String) -> Void
    ) {
        request(endPoint: Endpoints.character.rawValue, success: { data in
            do {
                let characters = try JSONDecoder().decode(CharactersDTO.self, from: data ?? Data())
                print(characters)
                success(characters)
            } catch {
                print("Error decoding characters")
            }
        }, failure: { error in
            failure(error)
        })
    }
    
    func characterDetailRequest(
        id: Int,
        success: @escaping (CharacterDetailDTO) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let endPoint = Endpoints.character
        let url = baseUrl + Endpoints.character.rawValue + String(id)
        
        request(endPoint: Endpoints.character.rawValue, success: <#T##(Data?) -> Void#>, failure: <#T##(String) -> Void#>)
        
//        sessionManager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
//            .response { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let character = try JSONDecoder().decode(CharacterDetailDTO.self, from: data ?? Data())
//                        print(character)
//                        success(character)
//                    } catch {
//                        print("error al descodificar")
//                    }
//                case .failure(let error):
//                    print(error)
//                    failure(error.localizedDescription)
//                }
//                    
//            }
    }
    
    func charactersRequest(
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        success: @escaping (CharactersDTO) -> Void,
        failure: @escaping (String) -> Void
    ) {
        sessionManager.request(baseUrl, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let characters = try JSONDecoder().decode(CharactersDTO.self, from: data ?? Data())
                        print(characters)
                        success(characters)
                    } catch {
                        print("error al descodificar")
                    }
                case .failure(let error):
                    print(error)
                    failure(error.localizedDescription)
                }
                    
            }
    }
    
}
