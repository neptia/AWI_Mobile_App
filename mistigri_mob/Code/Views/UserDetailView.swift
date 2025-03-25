import SwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode  // Accède à la présentation de la vue

    @StateObject var alertManager: AlertManager = AlertManager()  // Observed object pour la gestion des alertes
    private var user: User
    @State private var name: String
    @State private var email: String
    @State private var role: String

    init(user: User) {
        self.user = user
        _name = State(initialValue: user.name)
        _email = State(initialValue: user.email)
        _role = State(initialValue: user.role)
    }

    var body: some View {
        VStack {
            // Ligne pour le nom
            HStack {
                Text("Name: ")
                    .font(.headline)
                TextField("Enter name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
            }
            .padding()

            // Ligne pour le rôle
            HStack {
                Text("Role: ")
                    .font(.headline)
                Picker("Select role", selection: $role) {
                    Text("Admin").tag("admin")
                    Text("Manager").tag("manager")
                }
                .pickerStyle(SegmentedPickerStyle())  // Style segmenté pour le sélecteur
                .frame(maxWidth: .infinity)
            }
            .padding()

            // Ligne pour l'email
            HStack {
                Text("Email: ")
                    .font(.headline)
                TextField("Enter email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                    .disabled(true)  // Désactive l'édition de l'email
            }
            .padding()

            // Bouton pour sauvegarder les changements
            Button(action: {
                let updatedUser = User(id: user.id, name: name, role: role, email: email, password: user.password)
                let updateUserInfo = UpdateUserInfo(parameters: updatedUser)

                updateUserInfo.call(onSuccess: { response in
                    print("Réussi")
                    // Afficher l'alerte avec la réponse reçue
                    alertManager.showAlertMessage(message: response)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }

                }, onError: { errorMessage in
                    print(errorMessage)
                    // Afficher l'alerte en cas d'erreur
                    alertManager.showAlertMessage(message: errorMessage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }

                })
            }) {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        // Afficher l'alerte en cas de succès ou d'erreur
        .alert(isPresented: $alertManager.showAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertManager.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
