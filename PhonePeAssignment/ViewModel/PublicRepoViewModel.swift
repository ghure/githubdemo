//
//  PublicRepoViewModel.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 12/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import Foundation

class  PublicRepoViewModel {
    private var dataService:  GetApiGlobal?
    
    // MARK: - Constructor
    init(dataService:  GetApiGlobal) {
        self.dataService = dataService
    }
    
    func fetchUser(withName url: String, completion: @escaping ([UserDetail]?, Error?) -> ()) {
        self.dataService?.requestFetchUser(with: url, completion: { (data, error) in
            if let data = data {
                let user = try! JSONDecoder().decode([UserDetail].self, from: data)
                completion(user, error)
            }
        })
    }
}
