import UIKit

@MainActor func convertHTMLToPDF(htmlString: String, pdfFileName: String) -> URL? {
    // Create a print formatter with the HTML content
    let printFormatter = UIMarkupTextPrintFormatter(markupText: htmlString)

    // Create a UIPrintPageRenderer instance
    let renderer = UIPrintPageRenderer()
    renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)

    // Define the paper size and margins
    let pageSize = CGSize(width: 595.2, height: 841.8) // A4 size in points (72 dpi)
    let margin: CGFloat = 72.0 // 1 inch margin

    // Set the page size and margins
    let printableRect = CGRect(x: margin, y: margin, width: pageSize.width - margin * 2, height: pageSize.height - margin * 2)
    let paperRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)

    renderer.setValue(NSValue(cgRect: paperRect), forKey: "paperRect")
    renderer.setValue(NSValue(cgRect: printableRect), forKey: "printableRect")

    // Create a PDF context
    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, paperRect, nil)

    for i in 0..<renderer.numberOfPages {
        UIGraphicsBeginPDFPage()
        renderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
    }

    UIGraphicsEndPDFContext()

    // Save the PDF data to a file
    let tempDir = FileManager.default.temporaryDirectory
    let pdfURL = tempDir.appendingPathComponent("\(pdfFileName).pdf")

    do {
        try pdfData.write(to: pdfURL, options: .atomic)
        return pdfURL
    } catch {
        print("Error saving PDF: \(error.localizedDescription)")
        return nil
    }
}

let htmlString = """
<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                color: #333;
                padding: 20px;
            }
            h1 {
                color: #007BFF;
                text-align: center;
            }
            p {
                font-size: 16px;
                line-height: 1.6;
            }
            .highlight {
                background-color: yellow;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <h1>Hello, World!</h1>
        <p>This is a sample HTML content with <span class="highlight">in-line CSS</span>.</p>
    </body>
</html>
"""

if let pdfURL = convertHTMLToPDF(htmlString: htmlString, pdfFileName: "output") {
    print("PDF saved at: \(pdfURL.path)")
} else {
    print("Failed to create PDF.")
}
