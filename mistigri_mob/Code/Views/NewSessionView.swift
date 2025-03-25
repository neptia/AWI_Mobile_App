//  NewSessionView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

import SwiftUI

struct NewSessionView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var alertManager: AlertManager = AlertManager()
    // Variables pour le formulaire
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    @State private var startDay: Int = 0
    @State private var startMonth: Int = 0
    @State private var startYear: Int = 0

    @State private var endDay: Int = 0
    @State private var endMonth: Int = 0
    @State private var endYear: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            // Formulaire
            Form {
                // Champ pour le nom
                Section(header: Text("Session Name")) {
                    TextField("Enter session name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .padding()
                    .onChange(of: startDate) { newDate in
                        // Récupérer le jour, mois, année à chaque changement de date
                        let calendar = Calendar.current
                        self.startDay = calendar.component(.day, from: newDate)
                        self.startMonth = calendar.component(.month, from: newDate)
                        self.startYear = calendar.component(.year, from: newDate)
                    }

                // Sélecteur pour la date de fin
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .padding()
                    .onChange(of: endDate) { newDate in
                        let calendar = Calendar.current
                        self.endDay = calendar.component(.day, from: newDate)
                        self.endMonth = calendar.component(.month, from: newDate)
                        self.endYear = calendar.component(.year, from: newDate)
                    }
            }

            // Bouton pour envoyer les données
            Button(action: {
                // Code directement dans l'action du bouton
                print("Session name: \(name), Start Date: \(startDate), End Date: \(endDate)")

                let calendar = Calendar.current
                let startDay = calendar.component(.day, from: startDate)
                let startMonth = calendar.component(.month, from: startDate)
                let startYear = calendar.component(.year, from: startDate)
                let endDay = calendar.component(.day, from: endDate)
                let endMonth = calendar.component(.month, from: endDate)
                let endYear = calendar.component(.year, from: endDate)

                var newSession = newSessionRequest(name: name, startDay: startDay, startMonth: startMonth, startYear: startYear, endDay: endDay, endMonth: endMonth, endYear: endYear)
                let updateUserInfo = FetchNewSession(parameters: newSession)

                print(newSession)

                updateUserInfo.call(onSuccess: { response in
                    print("Réussi")
                    print(response.message)
                    alertManager.showAlertMessage(message: response.message)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }

                }, onError: { errorMessage in
                    print(errorMessage)
                    // Afficher l'alerte en cas d'erreur
                    print(errorMessage)
                    alertManager.showAlertMessage(message: errorMessage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }

                })
            }) {
                Text("Submit")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
    }
}
