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
        NavigationStack(path: $router.path) {
            Color.CFFF3E2
                .ignoresSafeArea()
                .overlay {
                    VStack {
                        VStack {
                            Image("logo_stars")
                                .resizable()
                                .frame(width: 140, height: 80, alignment: .bottom)
                                .padding(.bottom, 50)
                            AsyncImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/7733/7733264.png")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 40, height: 40)
                            Text("Login.Text.Title".localized)
                                .font(.system(size: 24, weight: .medium, design: .default)).padding(.bottom, 20).foregroundColor(Color.Ce0994d)
                            TextField(
                                "Login.EmailField.Title".localized,
                                text: $viewModel.email
                            )
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(15)
                            .background(Color.Cfffcf0)
                            .cornerRadius(8)
                            Spacer()
                                .frame(height: 20)
                            SecureField(
                                "Login.PasswordField.Title".localized,
                                text: $viewModel.password
                            )
                            .padding(15)
                            .background(Color.Cfffcf0)
                            .cornerRadius(8)
                        }.padding(.bottom, 40.0)
                        Button(
                            action: {
                                viewModel.login(alertManager: alertManager)
                            },
                            label: {
                                Text("Login.LoginButton.Title".localized)
                                    .font(.system(size: 20, design: .default))
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .foregroundColor(Color.white)
                                    .background(Color.Ce0994d)
                                    .cornerRadius(10)
                            }
                        )
                        .alert(isPresented: $alertManager.showAlert) {
                            Alert(
                                title: Text("Error"),
                                message: Text(alertManager.alertMessage),
                                dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 80)
                    .background(Color.CFFF3E2)
                    .navigationDestination(for: String.self) { value in
                        if value == "dashboard" {
                            DashboardScreen(router: router)
                                .toolbar(.hidden, for: .tabBar)
                        }
                    }
                }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(router: Router()).environmentObject(AlertManager())
    }
}
