import SwiftUI

struct SellerResumeView: View {
    @ObservedObject var viewModel: RecoveryViewModel

    init(viewModel: RecoveryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 30) {
                StatCard(title: "Stock available", value: String(viewModel.totalStockQuantity), borderColor: .yellow)
                StatCard(title: "Game Sold", value: String(viewModel.purchaseNumber), borderColor: .yellow)
            }

            HStack(spacing: 30) {
                StatCard(title: "Total Sales", value: String(viewModel.totalUnitPrice), borderColor: .red)
                StatCard(title: "Deposit Paid", value: String(viewModel.totalDepositFee), borderColor: .red)
            }

            StatCard(title: "Net Earnings", value: String(viewModel.totalUnitPrice-viewModel.totalDepositFee), borderColor: .red)

            Button(action: {
                print("Reset tapped")
            }) {
                Text("Reset")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.red)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

// Composant StatCard amélioré (plus grand)
struct StatCard: View {
    var title: String
    var value: String
    var borderColor: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .foregroundColor(borderColor)
                .bold()

            Text(value)
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(borderColor)
        }
        .frame(width: 160, height: 140)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(borderColor, lineWidth: 3)
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        SellerResumeView(viewModel: RecoveryViewModel())
    }
}
