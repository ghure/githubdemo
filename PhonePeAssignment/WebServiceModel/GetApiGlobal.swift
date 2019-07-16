//
//  GetApiGlobal.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 12/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import UIKit
import Foundation

struct GetApiGlobal {
    // MARK: - Singleton
    static let shared = GetApiGlobal()
    
    // MARK: - URL
    private let userUrl = ""
    
    // MARK: - Services
    func requestFetchUser(with url: String, completion: @escaping (Data?, Error?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data {
                completion(data, nil)
                return
            }
            }.resume()
    }
}
