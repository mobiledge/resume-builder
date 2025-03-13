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
    // Add an ID to force refresh when document changes
    private let id = UUID()

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateNSView(_ pdfView: PDFView, context: Context) {
        // Update the document when it changes
        pdfView.document = document
    }

    // Add this to make SwiftUI aware of identity changes
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: PDFKitRepresentedView

        init(_ parent: PDFKitRepresentedView) {
            self.parent = parent
        }
    }
}



//// Preview
//struct PDFViewer_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: NSFont.systemFont(ofSize: 18)])
//
//        if let pdfViewer = PDFViewer(attributedString: sampleText) {
//            pdfViewer
//        } else {
//            Text("Failed to create PDF")
//        }
//    }
//}
//
//// Mock data
//struct Mock {
//    static var pdfDocument: PDFDocument = {
//        let pdfURL = Bundle.main.url(forResource: "sample", withExtension: "pdf")!
//        let document = PDFDocument(url: pdfURL)!
//        return document
//    }()
//
//    static var attributedString: NSAttributedString = {
//        let sampleText = NSAttributedString(string: "Hello, this is a sample PDF document!", attributes: [.font: NSFont.systemFont(ofSize: 18)])
//        return sampleText
//    }()
//}
