import SwiftUI

struct SellerResumeView: View {
    @ObservedObject var viewModel: RecoveryViewModel

    init(viewModel: RecoveryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 25) {
            HStack(spacing: 25) {
                StatCard(title: "Stock available", value: String(viewModel.totalStockQuantity), borderColor: Color.purple.opacity(0.6))
                StatCard(title: "Game Sold", value: String(viewModel.purchaseNumber), borderColor: Color.purple.opacity(0.6))
            }

            HStack(spacing: 25) {
                StatCard(title: "Total Sales", value: String(viewModel.totalUnitPrice), borderColor: Color.orange.opacity(0.6))
                StatCard(title: "Deposit Paid", value: String(viewModel.totalDepositFee), borderColor: Color.orange.opacity(0.6))
            }

            StatCard(title: "Net Earnings", value: String(viewModel.totalUnitPrice - viewModel.totalDepositFee), borderColor: Color.orange.opacity(0.6))

            Button(action: {
                print("Reset tapped")
            }) {
                Text("Reset")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 220)
                    .background(Color.orange.opacity(0.8))
                    .cornerRadius(12)
            }
        }
        .padding()
        .cornerRadius(15)
    }
}

struct StatCard: View {
    var title: String
    var value: String
    var borderColor: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .foregroundColor(borderColor)
                .bold()

            Text(value)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(borderColor)
        }
        .frame(width: 160, height: 130)
        .background(Color.purple.opacity(0.04))
        .cornerRadius(12)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        SellerResumeView(viewModel: RecoveryViewModel())
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
