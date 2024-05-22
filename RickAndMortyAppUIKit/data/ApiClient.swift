//
//  ApiClient.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation
import Alamofire

class ApiClient {
    
    let baseUrl = "https://rickandmortyapi.com/api/character/"
    
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
    
    func characterDetailRequest(
        id: Int,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        success: @escaping (CharacterDetailDTO) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let url = baseUrl + String(id)
        
        sessionManager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let character = try JSONDecoder().decode(CharacterDetailDTO.self, from: data ?? Data())
                        print(character)
                        success(character)
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
