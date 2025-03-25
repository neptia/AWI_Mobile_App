import SwiftUI

struct ConfigureFeeView: View {

    @ObservedObject var viewModel: ConfigureFeeViewModel

    init(viewModel: ConfigureFeeViewModel) {
        self.viewModel = viewModel
    }

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Deposit Fee")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading)

            HStack {
                TextField("Nombre", value: $viewModel.depositFee, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)

                /*
                Text(viewModel.depositState == "percentage" ? "%" : "$")
                    .font(.footnote)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                 */

                Picker("Type de frais", selection: $viewModel.depositState) {
                    Text("$").tag("fixed")
                    Text("%").tag("percentage")
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 80)
            }
            .padding(.horizontal)

            Button(action: {
                viewModel.updateDepositFee {}
            }) {
                Text("Save")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.E4D2FB, lineWidth: 12)
                .background(Color.white)
                .cornerRadius(15)
        )
        .padding(5)
        .onAppear {
            viewModel.fetchDepositFee() {}
        }
        .alert(isPresented: $viewModel.showAlert) { 
            Alert(
                title: Text("Mise à jour"),
                message: Text(viewModel.messageAlert),
                dismissButton: .default(Text("OK"))
            )
        }

        VStack(alignment: .leading, spacing: 20) {
            Text("Commission Fee")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading)

            HStack {
                TextField("Nombre", value: $viewModel.commissionFee, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)

                /*
                Text(viewModel.depositState == "percentage" ? "%" : "$")
                    .font(.footnote)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                 */

                Picker("Type de frais", selection: $viewModel.commissionState) {
                    Text("$").tag("fixed")
                    Text("%").tag("percentage")
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 80)
            }
            .padding(.horizontal)

            Button(action: {
                viewModel.updateCommissionFee {}
            }) {
                Text("Save")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.FFFE8A3, lineWidth: 12)
                .background(Color.white)
                .cornerRadius(15)
        )
        .padding(5)
        .onAppear {
            viewModel.fetchCommissionFee() {}
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Mise à jour"),
                message: Text(viewModel.messageAlert),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ConfigureFeeView(viewModel: ConfigureFeeViewModel())
}
