//
//  SessionListView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

import SwiftUI

struct SessionListView: View {
    @ObservedObject var viewModel: SessionViewModel

    init(viewModel: SessionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                Text("Sessions")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                NavigationLink(destination: NewSessionView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, minHeight:60)
            .background(Color.customMauve)

            List(viewModel.sessions, id: \.id) { session in
                VStack(alignment: .leading) {
                    Text(session.name ?? "[No name]")
                        .font(.headline)
                    if let dateComponents = convertDateString(dateString: session.startDate) {
                        Text(verbatim: "Start Date: \(dateComponents.day)/\(dateComponents.month)/\(dateComponents.year)")
                            .font(.subheadline)
                    }
                    if let dateComponents = convertDateString(dateString: session.endDate) {
                        Text(verbatim: "End Date: \(dateComponents.day)/\(dateComponents.month)/\(dateComponents.year)")
                            .font(.subheadline)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchAllSession(){}
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
    SessionListView(viewModel: SessionViewModel())
}
