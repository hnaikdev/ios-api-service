//
//  ViewModel.swift
//  Example
//
//  Created by Hiral Naik on 7/28/25.
//

import Foundation

struct UserElement: Identifiable, Hashable {
    let id: Int
    let name: String
    let company: String
    let email: String
    let phone: String
    let avatar: String
    var selected: Bool = false
}

class UserViewModel: ObservableObject {
    
    let service: APIServiceProtocol
    @Published var users: [UserElement] = []
    var pppp = [UserElement]()
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            let result = try await service.fetchData()
            let elements = result.map({ generateViewModel(user: $0) })
            await MainActor.run {
                users = elements
            }
        } catch {
            await MainActor.run {
                users = []
            }
        }
    }
    
    private func generateViewModel(user: User) -> UserElement {
        return UserElement(id: user.id!, name: user.name ?? "", company: user.company ?? "", email: user.email ?? "", phone: user.phone ?? "", avatar: user.photo ?? "")
    }
}
