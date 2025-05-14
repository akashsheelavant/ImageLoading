//
//  SearchServices.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/17/25.
//

import Foundation

struct SearchServices {
        
    func fetchRandomUsers(completion: @escaping (UserResult?, Error?) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=25") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(nil, error)
            }
            if let data {
                do {
                    let result = try JSONDecoder().decode(UserResult.self, from: data)
                    completion(result, nil)
                } catch {
                    completion(nil, error)
                }
            }
            
        }.resume()
    }
}
