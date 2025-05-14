//
//  UsersViewModel.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/27/25.
//

import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var userViewModels: [UserViewModel]?
    
    private let searchServices: SearchServices
    
    required init(service: SearchServices) {
        searchServices = service
    }
    
    func fetchRandomUsers() {
        searchServices.fetchRandomUsers { [weak self] result, error in
            if let result,
               let users =  result.users {
                DispatchQueue.main.async {
                    self?.userViewModels = users.map { user in
                        let name = [user.title, user.first, user.last].compactMap { $0 }.joined(separator: " ")
                        let address = [String(user.number ?? 0), user.name, user.city, user.state, user.country, user.postcode].compactMap { $0 }.joined(separator: ", ")
                        return UserViewModel(name: name, address: address, imageURL: user.imageURL ?? "")
                    }
                }
                
//                if let userViewModel = self?.userViewModels {
//                    print("users: ", userViewModel)
//                }
                
//                DispatchQueue.main.async { [weak self] in
//                    self?.searchViewDelegate?.updateUI()
//                }
            }
            
            
            
        }
    }
}

