// 1. Imports - Need SwiftUI, UIKit (for PDF generation & types), PDFKit, PlaygroundSupport
import SwiftUI
import UIKit // Provides UIGraphicsPDFRenderer, NSAttributedString attributes etc.
import PDFKit // Provides PDFView and PDFDocument
import PlaygroundSupport // To display the SwiftUI view live



// 2. PDF Generation Function (Using UIGraphicsPDFRenderer)
//func createPDF(from attributedString: NSAttributedString, pageSize: CGSize = CGSize(width: 612, height: 792)) -> Data? {
//    // Standard US Letter size (8.5x11 inches at 72 points/inch)
//    let pageRect = CGRect(origin: .zero, size: pageSize)
//    let margin: CGFloat = 50.0
//    let textRect = pageRect.insetBy(dx: margin, dy: margin)
//
//    // Create a PDF Renderer
//    let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
//
//    // Render the PDF data
//    let pdfData = renderer.pdfData { (context) in
//        // Start a new PDF page
//        context.beginPage()
//
//        // Draw the attributed string
//        // NOTE: This simple version truncates text that doesn't fit the textRect.
//        // For proper pagination, a more complex Core Text approach is needed.
//        attributedString.draw(in: textRect)
//
//        // You could add more drawing here using context.cgContext
//        // Example: Draw a border around the text area
//        context.cgContext.setStrokeColor(UIColor.red.cgColor)
//        context.cgContext.setLineWidth(1.0)
//        context.cgContext.stroke(textRect)
//    }
//
//    return pdfData
//}

// 3. Create Sample Attributed String
func createSampleAttributedString() -> NSAttributedString {
    let finalAttributedString = NSMutableAttributedString()

//    // Title
//    let titleString = "My PDF Document\n"
//    let titleAttributes: [NSAttributedString.Key: Any] = [
//        .font: UIFont.systemFont(ofSize: 36, weight: .bold),
//        .foregroundColor: UIColor.purple,
//        .paragraphStyle: {
//            let style = NSMutableParagraphStyle()
//            style.alignment = .center
//            style.paragraphSpacing = 20.0 // Space after paragraph
//            return style
//        }()
//    ]
//    finalAttributedString.append(NSAttributedString(string: titleString, attributes: titleAttributes))
//
//    // Body Text
//    let bodyString = """
//    This is an example of generating a PDF from an NSAttributedString within an Xcode Playground.
//    We are using UIGraphicsPDFRenderer to create the PDF data.
//
//    SwiftUI is then used to display the resulting PDF via PDFKit's PDFView, wrapped in a UIViewRepresentable.
//    """
//    let bodyAttributes: [NSAttributedString.Key: Any] = [
//        .font: UIFont.systemFont(ofSize: 14),
//        .foregroundColor: UIColor.darkGray,
//        .paragraphStyle: {
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 5.0
//            style.alignment = .justified
//            style.firstLineHeadIndent = 20.0 // Indent first line
//            return style
//        }()
//    ]
//    finalAttributedString.append(NSAttributedString(string: bodyString, attributes: bodyAttributes))
//
//    // Add some more styled text
//     let styledString = "\n\nMore Styles:"
//     let styledAttributes: [NSAttributedString.Key: Any] = [
//         .font: UIFont.italicSystemFont(ofSize: 16),
//         .foregroundColor: UIColor.blue,
//         .underlineStyle: NSUnderlineStyle.single.rawValue
//     ]
//    finalAttributedString.append(NSAttributedString(string: styledString, attributes: styledAttributes))

    return finalAttributedString
}

/*
// 4. SwiftUI View to host PDFKit's PDFView
struct PDFKitView: UIViewRepresentable {
    let pdfData: Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        // Create PDFDocument from data
        if let pdfDocument = PDFDocument(data: pdfData) {
            pdfView.document = pdfDocument
        }
        pdfView.autoScales = true // Fit content to view size
        // pdfView.displayMode = .singlePage // Optional: Set display mode
        // pdfView.displaysPageBreaks = true // Optional
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the view if data changes (though in this playground, it won't)
        if let pdfDocument = PDFDocument(data: pdfData) {
            // Only update if the document is different, prevents unnecessary reload
            if uiView.document?.dataRepresentation() != pdfData {
                 uiView.document = pdfDocument
            }
        }
    }
}

// 5. Main SwiftUI Content View
struct ContentView: View {
    // State variable to hold the generated PDF data
    @State private var pdfData: Data? = nil
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            if let data = pdfData, !data.isEmpty {
                Text("Generated PDF:")
                    .font(.headline)
                    .padding(.top)
                // Display the PDF using the representable view
                PDFKitView(pdfData: data)
            } else if let errorMsg = errorMessage {
                 Text("Error: \(errorMsg)")
                    .foregroundColor(.red)
                    .padding()
            }
            else {
                // Placeholder while generating
                Text("Generating PDF...")
                    .font(.title)
                    .padding()
                ProgressView() // Show a loading indicator
            }
        }
        .frame(width: 600, height: 700) // Give the view a defined size in the playground
        .onAppear {
            // Generate the PDF when the view appears
            DispatchQueue.global(qos: .userInitiated).async {
                let attributedString = createSampleAttributedString()
                if let generatedData = createPDF(from: attributedString) {
                    // Switch back to main thread to update UI state
                    DispatchQueue.main.async {
                        self.pdfData = generatedData
                        self.errorMessage = nil
                    }
                } else {
                     DispatchQueue.main.async {
                         self.errorMessage = "Failed to generate PDF data."
                         self.pdfData = nil
                     }
                }
            }
        }
    }
}

*/

struct ContentView2: View {
    // State variable to hold the generated PDF data
    @State private var pdfData: Data? = nil
    @State private var errorMessage: String? = nil

    var body: some View {
        Text("ContentView2")
    }
}

// 6. Set the ContentView as the Playground's live view
//PlaygroundPage.current.setLiveView(ContentView2())


let str = createSampleAttributedString()
print(str)
