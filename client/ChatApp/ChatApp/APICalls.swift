//
//  APICalls.swift
//  ChatApp
//
//  Created by Vanessa Bergen on 2020-12-18.
//  Copyright © 2020 Vanessa Bergen. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case badURL, requestFailed, serverError, keyError, unknown
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("The URL provided is incorrect.", comment: "Bad URL")
        case .requestFailed:
            return NSLocalizedString("The request failed. Please try again", comment: "Request Failed")
        case .serverError:
            return NSLocalizedString("Unknown problem occured with the server. Please try again", comment: "Server Error")
        case .keyError:
            return NSLocalizedString("The Chat name entered already exists. Please enter a new one.", comment: "Duplicate Key")
        case .unknown:
            return NSLocalizedString("Unknown error occured. Please try again.", comment: "Unknown")
        }
    }
}

class APICalls {
    let baseURL = "http://localhost:4000/"
    let session = URLSession.shared
    
    func sendData<T: Fetchable>(_ model: T.Type, for object: T, completion: @escaping (Result<(Data, URLResponse), HTTPError>) -> Void) {
        
        guard let encoded = try? JSONEncoder().encode(object) else {
            print("Failed to encode object")
            return
        }

        guard let url = URL(string: baseURL + model.apiBase) else {
            completion(.failure(.badURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(.requestFailed))
                return
            }
            
            // if there's no errors, unwrap the data and response and return them
            guard let data = data, let response = response else {
                
                completion(.failure(.serverError))
                return
            }
            let httpresponse = response as! HTTPURLResponse
            let status = httpresponse.statusCode
            // check that we get the status code 201 that means the chat was created in the database
            guard status == 201 else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("json return \(json)")
                } catch {
                    print("error decoding data ", error)
                }
                completion(.failure(.keyError))
                return
            }
            
            completion(.success((data, response)))

        }.resume()
    }
    
    func getChat(for chat: String, completion: @escaping (Result<Bool, HTTPError>) -> Void) {
        guard let url = URL(string: baseURL + "chat/" + chat) else {
            completion(.failure(.badURL))
            return
        }
        
        print(url)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError))
            } else if let data = data, let dataString = String(data: data, encoding: .utf8), let response = response {
                print("data ", data)
                print("data response ", dataString)
                print("response ", response)
                completion(.success(dataString.boolValue))
            }
        }
        task.resume()
    }
//    func fetchData<T: Fetchable>(_ model: T.Type, completion: @escaping (Result<[T], HTTPError>) -> Void) {
//
//        // Construct the URLRequest
//        // since the model conforms to Fetchable, it has to have the variable apiBase
//
//        guard let url = URL(string: baseURL + model.apiBase) else {
//            completion(.failure(.badURL))
//            return
//        }
//
//        // Send it to the URLSession
//        let task = session.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                completion(.failure(.serverError))
//            } else if let data = data {
//                let result = Result { try JSONDecoder().decode([T].self, from: data) }
//                completion(.success(result))
//            }
//        }
//        task.resume()
//    }
}

// the generic type T will have to conform to Fetchable and Codable
// the fetchable protocol requires that the model has the apiBase string that will be used for the url
protocol Fetchable: Codable {
    static var apiBase: String { get }
}
