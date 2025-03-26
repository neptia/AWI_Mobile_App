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
            // Deposit Fee Section
            VStack(alignment: .leading) {
                Text("Deposit Fee")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.purple.opacity(0.6))
                    .padding(.leading)

                HStack {
                    TextField("Amount", value: $viewModel.depositFee, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 120)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)

                    Picker("Fee Type", selection: $viewModel.depositState) {
                        Text("$").tag("fixed")
                        Text("%").tag("percentage")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                Button(action: {
                    viewModel.updateDepositFee {}
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.purple.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(30)
            }.padding(.top, 40)
            .background(Color.purple.opacity(0.04))
                .cornerRadius(15)
                .padding(5)


            // Commission Fee Section
            VStack(alignment: .leading){
                Text("Commission Fee")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.orange.opacity(0.8))
                    .padding(.leading)


                HStack {
                    TextField("Amount", value: $viewModel.commissionFee, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 120)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)

                    Picker("Fee Type", selection: $viewModel.commissionState) {
                        Text("$").tag("fixed")
                        Text("%").tag("percentage")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                Button(action: {
                    viewModel.updateCommissionFee {}
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.orange.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(30)
            }.padding(.top, 40)
                .background(Color.purple.opacity(0.04))
                .cornerRadius(15)
                .padding(5)
        }
        .padding()
        .onAppear {
            viewModel.fetchDepositFee() {}
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
        .preferredColorScheme(.light)
        .previewLayout(.sizeThatFits)
}
