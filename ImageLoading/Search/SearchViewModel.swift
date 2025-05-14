//
//  Untitled.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/17/25.
//

import Foundation

protocol UserViewModelType {
    var name: String { get }
    var address: String { get }
    var imageURL: String { get }
}

protocol SearchViewDelegate {
    
    func updateUI()
}

protocol SearchViewModelType {
    var totalUsers: Int { get }
    
    func fetchRandomUsers()
    func userViewModel(at index: Int) -> UserViewModelType?
}

class SearchViewModel: SearchViewModelType {
            
    private let searchServices: SearchServices
    var userViewModels: [UserViewModelType]?
    var searchViewDelegate: SearchViewDelegate?
    
    var totalUsers: Int {
        userViewModels?.count ?? 0
    }
    
    required init(service: SearchServices) {
        searchServices = service
    }
    
//    func performSearch(keyword: String) {
//        searchServices.performSearch(keyword: keyword)
//    }
//    
//    func fetchCharacters() {
//        searchServices.fetchCharacters()
//    }
    
    func fetchRandomUsers() {
        searchServices.fetchRandomUsers { [weak self] result, error in
            if let result,
               let users =  result.users {
                self?.userViewModels = users.map { user in
                    let name = [user.title, user.first, user.last].compactMap { $0 }.joined(separator: " ")
                    let address = [String(user.number ?? 0), user.name, user.city, user.state, user.country, user.postcode].compactMap { $0 }.joined(separator: ", ")
                    return UserViewModel(name: name, address: address, imageURL: user.imageURL ?? "")
                }
                if let userViewModel = self?.userViewModels {
                    print("users: ", userViewModel)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.searchViewDelegate?.updateUI()
                }
            }
            
            
            
        }
    }
    
    func userViewModel(at index: Int) -> UserViewModelType? {
        guard let userViewModels = userViewModels,
                index < userViewModels.count else { return nil }
        return userViewModels[index]
    }
}

struct UserViewModel: UserViewModelType, Identifiable {
    var id = UUID()
    let name: String
    let address: String
    let imageURL: String
}
