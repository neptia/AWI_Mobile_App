//
//  GeneratePDF.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import PDFKit
import SwiftUI

struct PDFView: View {
    let people = [
        Person(name: "John Doe", number: "123-456-7890", address: "123 Main St"),
        Person(name: "Jane Smith", number: "987-654-3210", address: "456 Elm St"),
        Person(name: "Sam Johnson", number: "555-123-4567", address: "789 Oak St"),
        Person(name: "Alice Brown", number: "123-987-6543", address: "101 Maple St"),
        Person(name: "Bob White", number: "456-321-7890", address: "202 Pine St"),
        Person(name: "John Doe", number: "123-456-7890", address: "123 Main St"),
        Person(name: "Jane Smith", number: "987-654-3210", address: "456 Elm St"),
        Person(name: "Sam Johnson", number: "555-123-4567", address: "789 Oak St"),
        Person(name: "Alice Brown", number: "123-987-6543", address: "101 Maple St"),
        Person(name: "Bob White", number: "456-321-7890", address: "202 Pine St"),
        Person(name: "John Doe", number: "123-456-7890", address: "123 Main St")
    ]

    var body: some View {
        VStack {
            PDFContentView(people: people)
            Button("Generate PDF") {
                if let pdfData = generatePDF(from: people) {
                    if let fileURL = savePDF(data: pdfData, fileName: "PeopleList") {
                        print("PDF saved at \(fileURL)")
                    }
                }
            }
            .padding()
        }
    }

    func generatePDF(from people: [Person]) -> Data? {
        let pageWidth: CGFloat = 612
        let pageHeight: CGFloat = 792
        let margin: CGFloat = 50
        let contentWidth = pageWidth - 2 * margin
        let contentHeight = pageHeight - 2 * margin

        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))

        var currentY: CGFloat = margin
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .paragraphStyle: NSMutableParagraphStyle()
        ]

        let data = pdfRenderer.pdfData { context in
            context.beginPage()

            for person in people {
                let personContent = """
                Name: \(person.name)
                Number: \(person.number)
                Address: \(person.address)
                """

                let attributedString = NSAttributedString(string: personContent, attributes: textAttributes)
                let textHeight = attributedString.boundingRect(with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).height + 30

                if currentY + textHeight > contentHeight + margin {
                    context.beginPage()
                    currentY = margin
                }

                attributedString.draw(in: CGRect(x: margin, y: currentY, width: contentWidth, height: textHeight))
                currentY += textHeight
            }
        }

        return data
    }

    func savePDF(data: Data, fileName: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).pdf")

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving PDF: \(error.localizedDescription)")
            return nil
        }
    }


}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let address: String
}
struct PDFContentView: View {
    let people: [Person]

    var body: some View {
        ScrollView{
            ForEach(people) { person in
                VStack(alignment: .leading) {
                    Text("Name: \(person.name)")
                    Text("Number: \(person.number)")
                    Text("Address: \(person.address)")
                }
                .padding(.bottom, 10)
            }
        }
        .padding()
    }
}

#Preview {
    PDFView()
}
