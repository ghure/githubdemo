//
//  UserApiViewModel.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 09/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import UIKit
import Foundation

struct UserApiViewModel {
    // MARK: - Singleton
    static let shared = UserApiViewModel()
    
    // MARK: - URL
    private let userUrl = "https://api.github.com/users/"
    
    // MARK: - Services
    func requestFetchUser(with username: String, completion: @escaping (UserDetail?, Error?, Int?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "\(userUrl)\(username)" )!) { (data, response, error) in
            if let error = error {
                completion(nil, error, 500)
                return
            } else if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode != 200 {
                    completion(nil, error, response.statusCode)
                }
            }
            if let data = data {
                let user = try! JSONDecoder().decode(UserDetail.self, from: data)
                
                completion(user, nil, 200)
                return
            }
        }.resume()
    }
}
