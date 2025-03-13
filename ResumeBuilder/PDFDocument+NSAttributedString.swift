import Foundation
import AppKit
import PDFKit

extension PDFDocument {
    convenience init?(attributedString: NSAttributedString) {
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

        self.init(data: pdfData as Data)
    }
}
