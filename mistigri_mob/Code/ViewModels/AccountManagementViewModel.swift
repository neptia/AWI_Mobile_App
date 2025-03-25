//
//  AccountManagementViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

class AccountManagementViewModel: ObservableObject {
    @Published var managers: [ManagerResponse] = []
    @Published var users: [User] = []
    @Published var searchText: String = "" {
        didSet {
            filterUsers()
        }
    }

    @Published var filteredUsers: [User] = []

    func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { user in
                user.name.lowercased().contains(searchText.lowercased()) ||
                user.role.lowercased().contains(searchText.lowercased()) ||
                user.email.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func filteredManagers(searchText: String) -> [ManagerResponse] {
        if searchText.isEmpty {
            return []
        } else {
            return managers.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func fetchAllUser(completion: @escaping () -> Void) {
        let fetchAction = FetchAllUser()
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                print("----------------------")
                self.users = response.users
                self.filterUsers()
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }
}
