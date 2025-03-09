//
//  LoginScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 08/03/2025.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var alertManager: AlertManager
    @StateObject var router = Router()
    @StateObject var viewModel: LoginViewModel

    init(router: Router) {
        _router = StateObject(wrappedValue: router)
        _viewModel = StateObject(wrappedValue: LoginViewModel(router: router))
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    TextField(
                        "Login.EmailField.Title".localized,
                        text: $viewModel.email
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                    Divider()
                    SecureField(
                        "Login.PasswordField.Title".localized,
                        text: $viewModel.password
                    )
                    .padding(.top, 20)
                    Divider()
                }
                Spacer()
                Button(
                    action: {
                        viewModel.login(alertManager: alertManager)
                    },
                    label: {
                        Text("Login.LoginButton.Title".localized)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                )
                .alert(isPresented: $alertManager.showAlert) {
                    Alert(title:Text("Error"),message:Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding(30)
            .navigationDestination(isPresented:$router.navigateToStoreHomeScreen)
            { StoreHomeScreen().navigationBarBackButtonHidden(true)}
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(router: Router()).environmentObject(AlertManager())
    }
}
