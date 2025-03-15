//
//  Auth.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 14/03/2025.
//

import Foundation
import SwiftKeychainWrapper

class Auth: ObservableObject {

    struct Credentials {
        var token: String?
    }

    enum KeychainKey: String {
        case token
    }

    static let shared: Auth = Auth()
    private let keychain: KeychainWrapper = KeychainWrapper.standard

    @Published var loggedIn: Bool = false

    private init() {
        loggedIn = hasToken()
    }

    func getCredentials() -> Credentials {
        return Credentials(
            token: keychain.string(forKey: KeychainKey.token.rawValue)
        )
    }

    func setCredentials(token: String) {
        keychain.set(token, forKey: KeychainKey.token.rawValue)
        loggedIn = true
    }

    func hasToken() -> Bool {
        return getCredentials().token != nil
    }

    func getToken() -> String? {
        return getCredentials().token
    }


    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.token.rawValue)
        loggedIn = false
    }

}
