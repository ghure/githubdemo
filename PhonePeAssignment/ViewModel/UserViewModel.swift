//
//  UserViewModel.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 11/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import Foundation

class UserViewModel {
    private var dataService: UserApiViewModel?
    
    // MARK: - Constructor
    init(dataService: UserApiViewModel) {
        self.dataService = dataService
    }
    
    func fetchUser(withName username: String, completion: @escaping (UserDetail?, Error?, Int?) -> ()) {
        self.dataService?.requestFetchUser(with: username, completion: { (users, error, code) in
            if let error = error {
                completion(nil, error, code)
            }
            if let users = users {
                completion(users, error, code)
            } else {
                completion(nil, error, code)
            }
        })
    }
}
