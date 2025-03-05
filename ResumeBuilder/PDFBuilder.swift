import UIKit
import PDFKit

/// A utility class to create PDFs from attributed strings.
class PDFBuilder {
    // MARK: - Properties

    private let pageWidth = 8.5 * 72.0
    private let pageHeight = 11 * 72.0
    lazy var pageSize = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

    private let documentTitle: String = "DocumentTitle"
    private let documentAuthor: String = "DocumentAuthor"
    lazy var format: UIGraphicsPDFRendererFormat = {
        let format = UIGraphicsPDFRendererFormat()
            format.documentInfo = [
                kCGPDFContextTitle as String: documentTitle,
                kCGPDFContextAuthor as String: documentAuthor
            ]
        return format
    }()


    func draw(attributedString: NSAttributedString) {

        let renderer = UIGraphicsPDFRenderer(bounds: pageSize, format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()
//            let rect = CGRect(x: 0, y: 0, width: 500, height: 500)
            attributedString.draw(in: pageSize)
        }

        let pdfDocument = PDFDocument(data: data)!

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("output.pdf")
        pdfDocument.write(to: url)
        print("\(url.absoluteString)")
    }

    static func createSimplePDF() {
        let pdfMetaData = [
            kCGPDFContextCreator: "Flyer Builder",
            kCGPDFContextAuthor: "raywenderlich.com"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]


        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)


        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
            ]
            let text = "I'm a PDF!"
            text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        }

        let pdfDocument = PDFDocument(data: data)!

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("output.pdf")
        pdfDocument.write(to: url)
        print("\(url.absoluteString)")
    }
}





// MARK: - Usage Example

/*
// Example usage:
let attributedString = NSAttributedString(
    string: "Hello, PDF World!",
    attributes: [
        .font: UIFont.systemFont(ofSize: 24),
        .foregroundColor: UIColor.black
    ]
)

let pdfBuilder = PDFBuilder()
    .with(attributedString: attributedString)
    .withTitle("My First PDF")
    .withAuthor("Swift Developer")

// Option 1: Get the PDF document
if let pdfDocument = pdfBuilder.build() {
    // Use the PDF document
}

// Option 2: Save to file
let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let pdfURL = documentsDirectory.appendingPathComponent("output.pdf")
let success = pdfBuilder.buildAndSave(to: pdfURL)

// Option 3: Get PDF data
if let pdfData = pdfBuilder.buildData() {
    // Use the PDF data
}
*/
