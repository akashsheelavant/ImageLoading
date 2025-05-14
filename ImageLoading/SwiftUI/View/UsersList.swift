//
//  UsersList.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/27/25.
//

import SwiftUI

struct UsersList: View {
    
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        List(content: {
            if let userViewModels = viewModel.userViewModels,
               !userViewModels.isEmpty {
                
                ForEach(userViewModels) { user in
                    UsersListCell(user: user)
                }
            }
        })
        
        .onAppear {
            viewModel.fetchRandomUsers()
        }
        .navigationTitle("Users")
    }
}

struct UsersListCell: View {
    var user: UserViewModel
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: user.imageURL)) { userImage in
                userImage.image?
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.system(size: 14, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 2, trailing: 5))
                Text(user.address)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 2, trailing: 5))
            }
        }
    }
}

#Preview {
    let service = SearchServices()
    let vieWModel = UsersViewModel(service: service)
    
    UsersList(viewModel: vieWModel)
}
