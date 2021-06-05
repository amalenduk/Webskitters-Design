//
//  Networking.swift
//  Webskitters
//
//  Created by Amalendu Kar on 05/06/21.
//

import Foundation

class Networking: NSObject {
    
    // MARK: - Properties
    
    func getRoles(completionHandler: @escaping (Result<MenuData, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "http://planningpro.dedicateddevelopers.us/api/role/planning/0")!)
        // Headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer 739|c0DxqQa9nURCa2OSMMgxAdyEMdLre0JCscuXpTYz", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(.failure(error))
                }else if let response = response as? HTTPURLResponse, let data = data {
                    if (200...299).contains(response.statusCode) {
                        do {
                            let roles = try JSONDecoder().decode(MenuData.self, from: data)
                            completionHandler(.success(roles))
                        }catch {
                            completionHandler(.failure(error))
                        }
                    }else {
                        completionHandler(.failure(AKError.emptyResponse))
                    }
                }else {
                    assertionFailure("Need to implement possible threats")
                }
            }
        })
        
        task.resume()
    }
}

enum AKError: Error {
    case emptyResponse
}


extension AKError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Server sent empty response"
        }
    }
}
