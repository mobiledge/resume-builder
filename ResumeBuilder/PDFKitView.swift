import SwiftUI
import PDFKit

struct PDFViewer: View {
    let document: PDFDocument

    var body: some View {
        PDFKitRepresentedView(document: document)
            .edgesIgnoringSafeArea(.all)
    }
}

extension PDFViewer {
    init?(attributedString: NSAttributedString) {
        guard let document = createPDFDocument(from: attributedString) else { return nil }
        self.document = document
    }
}

// Platform-specific view wrappers
#if os(iOS)
struct PDFKitRepresentedView: UIViewRepresentable {
    let document: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {}
}
#elseif os(macOS)
struct PDFKitRepresentedView: NSViewRepresentable {
    let document: PDFDocument

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateNSView(_ pdfView: PDFView, context: Context) {}
}
#endif

// Function to create a PDFDocument from NSAttributedString
func createPDFDocument(from attributedString: NSAttributedString) -> PDFDocument? {
    let pdfData = NSMutableData()
    let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
    var mediaBox = CGRect(x: 0, y: 0, width: 612, height: 792) // Standard letter size

    guard let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil) else {
        return nil
    }

    pdfContext.beginPDFPage(nil)

    let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
    let framePath = CGPath(rect: mediaBox.insetBy(dx: 20, dy: 20), transform: nil)
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), framePath, nil)

    CTFrameDraw(frame, pdfContext)
    pdfContext.endPDFPage()
    pdfContext.closePDF()

    return PDFDocument(data: pdfData as Data)
}

// Preview with platform-specific code
struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: UIFont.systemFont(ofSize: 18)])
        #elseif os(macOS)
        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: NSFont.systemFont(ofSize: 18)])
        #endif

        if let pdfViewer = PDFViewer(attributedString: sampleText) {
            pdfViewer
        } else {
            Text("Failed to create PDF")
        }
    }
}

// Mock extension with platform-specific code
struct Mock {
    #if os(iOS)
    static var pdfDocument: PDFDocument = {
        let pdfURL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
        let document = PDFDocument(url: pdfURL)!
        return document
    }()

    static var attributedString: NSAttributedString = {
        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: UIFont.systemFont(ofSize: 18)])
        return sampleText
    }()
    #elseif os(macOS)
    static var pdfDocument: PDFDocument = {
        let pdfURL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
        let document = PDFDocument(url: pdfURL)!
        return document
    }()

    static var attributedString: NSAttributedString = {
        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: NSFont.systemFont(ofSize: 18)])
        return sampleText
    }()
    #endif
}
