//: A macOS based Playground for presenting user interface and generating PDF

import PlaygroundSupport
//import SwiftUI // Not strictly needed for PDF generation part
import PDFKit // Provides PDFDocument
import AppKit // Provides NSFont, NSColor, NSAttributedString, NSGraphicsContext etc.

// SwiftUI View (can be kept for display if needed, but not directly used by PDF builder)
// struct MyExperimentalView: View {
//     var body: some View {
//         Text("MyExperimentalView")
//             .font(.largeTitle)
//             .foregroundStyle(.white) // Note: foregroundStyle is SwiftUI, use NSColor for PDF
//     }
// }
//
// let view = MyExperimentalView()
// PlaygroundPage.current.setLiveView(view) // Needs UIHostingController on macOS if you use SwiftUI view


// Helper struct to store the data for each text element internally
private struct PDFElement {
    let string: String
    let style: NSFont.TextStyle
    let color: NSColor
    let alignment: NSTextAlignment
}

class PDFDocumentBuilder {
    private var elements: [PDFElement] = []
    private let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792) // US Letter
    private let margin: CGFloat = 50

    @discardableResult
    func addText(_ string: String, style: NSFont.TextStyle = .body, color: NSColor = .black, alignment: NSTextAlignment = .left) -> PDFDocumentBuilder {
        let element = PDFElement(string: string, style: style, color: color, alignment: alignment)
        elements.append(element)
        return self
    }

    func build() -> PDFDocument? {
        let pdfData = NSMutableData()
        var mediaBox = pageRect

        guard let consumer = CGDataConsumer(data: pdfData),
              let context = CGContext(consumer: consumer, mediaBox: &mediaBox, nil) else {
            return nil
        }

        var currentY = pageRect.height - margin // Start from top (PDF coordinates)

        context.beginPDFPage(nil)

        defer {
            context.endPDFPage()
            context.closePDF()
        }

        let drawingWidth = pageRect.width - (margin * 2)

        for element in elements {
            let font = NSFont.preferredFont(forTextStyle: element.style)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = element.alignment

            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: element.color,
                .paragraphStyle: paragraphStyle
            ]

            let attributedString = NSAttributedString(string: element.string, attributes: attributes)

            let textRect = attributedString.boundingRect(
                with: CGSize(width: drawingWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading]
            )

            let requiredHeight = ceil(textRect.height)

            // Check for page break
            if currentY - requiredHeight < margin {
                context.endPDFPage()
                context.beginPDFPage(nil)
                currentY = pageRect.height - margin
            }

            let drawRect = CGRect(
                x: margin,
                y: currentY - requiredHeight,
                width: drawingWidth,
                height: requiredHeight
            )

            // Save and restore graphics state for each element
            context.saveGState()
            attributedString.draw(in: drawRect)
            context.restoreGState()

            currentY -= requiredHeight + 5 // Add spacing
        }

        return PDFDocument(data: pdfData as Data)
    }
}

import AppKit
import PlaygroundSupport
import PDFKit

// Create a PDF document with various text elements
let pdfBuilder = PDFDocumentBuilder()
    .addText("Monthly Report", style: .title1, color: .systemBlue, alignment: .center)
    .addText("Generated on \(Date())", style: .subheadline, color: .systemGray, alignment: .center)
    .addText("\nExecutive Summary", style: .title2, color: .black, alignment: .left)
    .addText("This quarter showed significant growth in all key metrics. Revenue increased by 15% compared to last quarter, while expenses were reduced by 8%. Customer satisfaction scores reached an all-time high of 92%.", style: .body, alignment: .left)
    .addText("\nFinancial Highlights", style: .title2, color: .black, alignment: .left)
    .addText("Revenue: $1,250,000", style: .body, color: .systemGreen, alignment: .left)
    .addText("Expenses: $850,000", style: .body, color: .systemRed, alignment: .left)
    .addText("Profit: $400,000", style: .headline, color: .systemPurple, alignment: .left)
    .addText("\nKey Metrics", style: .title2, color: .black, alignment: .left)
    .addText("1. Customer Acquisition: 1,250 new customers", style: .body, alignment: .left)
    .addText("2. Retention Rate: 88%", style: .body, alignment: .left)
    .addText("3. Average Order Value: $125", style: .body, alignment: .left)
    .addText("\nThis is a long paragraph that should demonstrate automatic wrapping and page breaking. " +
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nisl eget ultricies tincidunt, " +
            "nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl. Nullam auctor, nisl eget ultricies tincidunt, " +
            "nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl. This text should flow naturally across " +
            "multiple lines and potentially multiple pages if needed.",
            style: .body, alignment: .justified)

// Generate the PDF document
if let pdfDocument = pdfBuilder.build() {
    // Save to a temporary file for preview
    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("GeneratedDocument.pdf")
    pdfDocument.write(to: tempURL)

    // Display in Playground live view
    let pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: 600, height: 800))
    pdfView.document = pdfDocument
    pdfView.autoScales = true

    // For saving to desktop (optional)
    let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    let saveURL = desktopURL.appendingPathComponent("GeneratedDocument.pdf")
    pdfDocument.write(to: saveURL)
    print("PDF saved to: \(saveURL.path)")

    PlaygroundPage.current.liveView = pdfView
} else {
    print("Failed to generate PDF document")
}
