import SwiftUI

struct CurrentSessionView: View {
    @ObservedObject var viewModel: SessionViewModel

    init(viewModel: SessionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("Current Session")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 65)
                .background(Color.customMauve)

            if let dateComponentsStart = convertDateString(dateString: viewModel.current.startDate),
               let dateComponentsEnd = convertDateString(dateString: viewModel.current.endDate) {

                Text(viewModel.current.name ?? "Nom inconnu")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)

                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Start Date:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(verbatim: "\(dateComponentsStart.day)/\(dateComponentsStart.month)/\(dateComponentsStart.year)")
                            .foregroundColor(.gray)
                    }

                    Divider()

                    HStack {
                        Image(systemName: "hourglass")
                        Text("End Date:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(verbatim: "\(dateComponentsEnd.day)/\(dateComponentsEnd.month)/\(dateComponentsEnd.year)")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal, 20)

            } else {
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)

                    Text("🚫 Aucune session en cours")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchCurrentSession() {}
        }


    }

    func convertDateString(dateString: String) -> (day: Int, month: Int, year: Int)? {
        let formatter = DateFormatter()
        // Le format ISO 8601 précis pour MongoDB
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")  // UTC pour le 'Z' à la fin de la date

        if let date = formatter.date(from: dateString) {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)

            return (day, month, year)
        }

        return nil
    }
}

#Preview {
    CurrentSessionView(viewModel: SessionViewModel())
}
