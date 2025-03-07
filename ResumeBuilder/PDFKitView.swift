import SwiftUI
import UniformTypeIdentifiers
import PDFKit

struct PDFViewer: View {
    let document: PDFDocument
    @State private var showingExportSheet = false

    var body: some View {
        PDFKitRepresentedView(document: document)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingExportSheet = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .fileExporter(
                isPresented: $showingExportSheet,
                document: PDFExportDocument(document: document),
                contentType: .pdf,
                defaultFilename: "Resume"
            ) { result in
                // Handle export completion if needed
            }
    }
}

// macOS-specific FileDocument implementation
struct PDFExportDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.pdf] }

    let document: PDFDocument

    init(document: PDFDocument) {
        self.document = document
    }

    init(configuration: ReadConfiguration) throws {
        // This initializer is required but won't be used for export
        self.document = PDFDocument()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        guard let data = document.dataRepresentation() else {
            throw CocoaError(.fileWriteUnknown)
        }

        return FileWrapper(regularFileWithContents: data)
    }
}

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

extension PDFViewer {
    init?(attributedString: NSAttributedString) {
        guard let document = createPDFDocument(from: attributedString) else { return nil }
        self.document = document
    }
}

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

// Preview
struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: NSFont.systemFont(ofSize: 18)])

        if let pdfViewer = PDFViewer(attributedString: sampleText) {
            pdfViewer
        } else {
            Text("Failed to create PDF")
        }
    }
}

// Mock data
struct Mock {
    static var pdfDocument: PDFDocument = {
        let pdfURL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
        let document = PDFDocument(url: pdfURL)!
        return document
    }()

    static var attributedString: NSAttributedString = {
        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: NSFont.systemFont(ofSize: 18)])
        return sampleText
    }()
}
