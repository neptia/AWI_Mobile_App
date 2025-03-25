//
//  GenerateReceipts.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

//  GeneratePDF.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import PDFKit
import SwiftUI

struct GenerateReceiptsView: View {

    @ObservedObject var financeViewModel: FinanceViewModel = FinanceViewModel()

    init(financeViewModel: FinanceViewModel) {
        self.financeViewModel = financeViewModel
    }

    var body: some View {
        VStack {
            Button(action: {
                if let pdfData = generatePDF(from: financeViewModel.selectedItems) {
                    if let fileURL = savePDF(data: pdfData, fileName: "ItemList") {
                        print("PDF saved at \(fileURL)")
                    }
                }
            }) {
                Image(systemName: "printer.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
        }
    }

    func generatePDF(from items: [SelectableItem]) -> Data? {
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

            for item in items {
                let itemContent = """
                \(item.header)
                \(item.title)
                \(item.subtitle)
                Amount: \(item.amount)
                """

                let attributedString = NSAttributedString(string: itemContent, attributes: textAttributes)
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

struct PDFReceiptsView: View {
    let items: [SelectableItem]

    var body: some View {
        ScrollView {
            ForEach(items) { item in
                VStack(alignment: .leading) {
                    Text("Header: \(item.header)")
                    Text("Title: \(item.title)")
                    Text("Subtitle: \(item.subtitle)")
                    Text("Amount: \(item.amount)")
                }
                .padding(.bottom, 10)
            }
        }
        .padding()
    }
}

#Preview {
    GenerateReceiptsView(financeViewModel: FinanceViewModel())
}
