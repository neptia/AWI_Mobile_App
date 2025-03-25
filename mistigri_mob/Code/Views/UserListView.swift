import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: AccountManagementViewModel
    @State private var selectedRole: String = "manager"  // Par défaut, on affiche les "managers"

    var body: some View {
        VStack {
            // Bascule pour choisir le rôle (admin ou manager)
            Picker("Select Role", selection: $selectedRole) {
                Text("Managers").tag("manager")
                Text("Admins").tag("admin")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Titre de la liste
            Text("\(selectedRole.capitalized) List")
                .font(.title)
                .padding()

            // Filtrer les utilisateurs en fonction du rôle sélectionné
            List(filteredUsers(), id: \.id) { user in
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text("Role: \(user.role)")
                            .font(.subheadline)
                        Text("Email: \(user.email)")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding(.vertical, 5)
                .swipeActions(edge: .trailing) {
                    // Bouton de modification uniquement si l'utilisateur n'est pas un admin
                    NavigationLink(destination: UserDetailView(user: user)) {
                        Text("Edit")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .tint(.blue)
                    .disabled(user.role == "admin")  // Désactive le bouton si l'utilisateur est un admin
                    .opacity(user.role == "admin" ? 0.5 : 1)  // Grise le bouton si l'utilisateur est un admin
                }
            }
        }
        .onAppear {
            viewModel.fetchAllUser() {}
        }
        .navigationBarTitle("User List", displayMode: .inline)
    }

    // Fonction pour filtrer les utilisateurs en fonction du rôle sélectionné
    private func filteredUsers() -> [User] {
        return viewModel.filteredUsers.filter { user in
            return user.role == selectedRole
        }
    }

    private func refreshData() {
        viewModel.fetchAllUser() {}
    }
}
