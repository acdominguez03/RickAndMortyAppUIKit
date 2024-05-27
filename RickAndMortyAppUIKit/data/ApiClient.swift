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
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        success: @escaping (Data?) -> Void,
        failure: @escaping (String) -> Void
    ) {
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
        parameters: Parameters,
        success: @escaping (CharactersDTO) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let url = baseUrl + Endpoints.character.rawValue
        request(url: url, parameters: parameters, success: { data in
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
        let url = baseUrl + Endpoints.characterDetail.rawValue + String(id)
        
        request(url: url) { data in
            do {
                let character = try JSONDecoder().decode(CharacterDetailDTO.self, from: data ?? Data())
                print(character)
                success(character)
            } catch {
                print("Error decoding characters")
            }
        } failure: { error in
            failure(error)
        }
    }
    
    func locationsRequest(
        parameters: Parameters,
        success: @escaping (LocationsDTO) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let url = baseUrl + Endpoints.location.rawValue
        request(url: url, parameters: parameters, success: { data in
            do {
                let locations = try JSONDecoder().decode(LocationsDTO.self, from: data ?? Data())
                print(locations)
                success(locations)
            } catch {
                print("Error decoding locations")
            }
        }, failure: { error in
            failure(error)
        })
    }
}
