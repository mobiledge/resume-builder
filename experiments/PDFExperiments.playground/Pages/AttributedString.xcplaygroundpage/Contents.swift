import UIKit
import PDFKit



func pageSize() -> CGRect {
    let pageWidth = 8.5 * 72.0
    let pageHeight = 11 * 72.0
    return CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
}

func format() -> UIGraphicsPDFRendererFormat {
    let documentTitle: String = "DocumentTitle"
    let documentAuthor: String = "DocumentAuthor"
    let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = [
            kCGPDFContextTitle as String: documentTitle,
            kCGPDFContextAuthor as String: documentAuthor
        ]
    return format
}

func save(_ doc: PDFDocument) {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let url = documentsDirectory.appendingPathComponent("output.pdf")
    doc.write(to: url)
    print("\(url.absoluteString)")
}

func attrString() -> NSAttributedString {

    let lorem = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et arcu lorem. Duis vulputate augue sapien, eu rutrum massa eleifend et. Nulla ultricies auctor enim, sed commodo nunc ultricies id. Phasellus sed euismod lacus, non congue eros. Nulla scelerisque est sit amet hendrerit pretium. Pellentesque sollicitudin nisl volutpat dapibus posuere. Cras vulputate, urna eget interdum tempus, erat dui vehicula enim, non gravida leo dolor id lectus. Aliquam leo augue, pharetra eu purus eu, pretium volutpat nunc. Fusce eleifend eget augue fringilla facilisis.

    Morbi posuere nibh erat, id consectetur augue lacinia sed. Quisque consequat mauris eget sapien porta, quis laoreet nisl cursus. Nulla congue blandit luctus. Quisque sed pulvinar velit, eu tincidunt purus. Praesent nibh nibh, euismod at arcu ut, mattis consectetur est. Quisque eu mauris ut orci cursus tincidunt sed a elit. Maecenas mi turpis, pulvinar non augue eget, ornare tristique sem. Curabitur ultricies ex nulla, in sagittis tellus sollicitudin vitae. Nam imperdiet venenatis mauris, vel commodo enim rutrum ut. In fringilla eros id tellus consectetur, ac pretium magna vehicula. Sed nisi dui, porta a accumsan at, faucibus ut elit. Aliquam laoreet dolor leo, at dapibus elit tristique non.

    Morbi laoreet auctor libero ac mollis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam vitae pretium dolor, ut fermentum sem. Nulla facilisi. Phasellus finibus pellentesque dui, eget eleifend urna varius at. Suspendisse sit amet maximus nibh. Donec volutpat fringilla magna ut auctor.

    Donec ut justo ornare, facilisis sem ac, eleifend libero. Pellentesque vel neque erat. Sed non gravida ligula. Vivamus et nisl vitae massa semper porta tristique quis libero. Nam ut lectus eget risus mattis sagittis. Aliquam at pulvinar risus, id varius risus. Cras enim urna, varius ornare varius a, auctor sit amet velit. Ut vehicula rhoncus quam vitae sodales. Aliquam eu risus nisi. Proin aliquet auctor velit vel pellentesque. Nulla facilisi. Aenean viverra lacus ante, commodo rutrum tellus imperdiet non.

    Cras nisl elit, luctus quis gravida sed, vestibulum eu nisi. Nullam nec eros pulvinar, molestie dui consequat, aliquet erat. Etiam pellentesque posuere laoreet. Morbi et est ut neque dictum iaculis. Proin maximus rutrum libero at scelerisque. Nam venenatis lacus ac nisi mollis, ac imperdiet leo imperdiet. Mauris blandit placerat eleifend. Aliquam erat volutpat. Mauris volutpat lacus erat, id consectetur lorem finibus tincidunt. Donec tristique finibus dui non sodales. Sed diam urna, congue eget vestibulum in, ornare a felis.
    """

    let textFont = UIFont.systemFont(ofSize: 24.0, weight: .regular)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping

    let attributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
    ]

    return NSAttributedString(
        string: lorem,
        attributes: attributes
    )
}

func attrString2() -> NSAttributedString {

    let text1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et arcu lorem. Duis vulputate augue sapien, eu rutrum massa eleifend et. Nulla ultricies auctor enim, sed commodo nunc ultricies id. Phasellus sed euismod lacus, non congue eros. Nulla scelerisque est sit amet hendrerit pretium. Pellentesque sollicitudin nisl volutpat dapibus posuere. Cras vulputate, urna eget interdum tempus, erat dui vehicula enim, non gravida leo dolor id lectus. Aliquam leo augue, pharetra eu purus eu, pretium volutpat nunc. Fusce eleifend eget augue fringilla facilisis."

    let text2 = "Morbi posuere nibh erat, id consectetur augue lacinia sed. Quisque consequat mauris eget sapien porta, quis laoreet nisl cursus. Nulla congue blandit luctus. Quisque sed pulvinar velit, eu tincidunt purus. Praesent nibh nibh, euismod at arcu ut, mattis consectetur est. Quisque eu mauris ut orci cursus tincidunt sed a elit. Maecenas mi turpis, pulvinar non augue eget, ornare tristique sem. Curabitur ultricies ex nulla, in sagittis tellus sollicitudin vitae. Nam imperdiet venenatis mauris, vel commodo enim rutrum ut. In fringilla eros id tellus consectetur, ac pretium magna vehicula. Sed nisi dui, porta a accumsan at, faucibus ut elit. Aliquam laoreet dolor leo, at dapibus elit tristique non."


    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping

    let attr1 = NSAttributedString(
        string: text1,
        attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .regular)
        ]
    )

    let attr2 = NSAttributedString(
        string: text1,
        attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0, weight: .regular)
        ]
    )

    var mutable = NSMutableAttributedString()
    mutable.append(attr1)
    mutable.append(attr2)
    return mutable
}

func attrString(size: Int, weight: UIFont.Weight  = .regular) -> NSAttributedString {

    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et arcu lorem. Duis vulputate augue sapien, eu rutrum massa eleifend et. Nulla ultricies auctor enim, sed commodo nunc ultricies id. Phasellus sed euismod lacus, non congue eros. Nulla scelerisque est sit amet hendrerit pretium. Pellentesque sollicitudin nisl volutpat dapibus posuere. Cras vulputate, urna eget interdum tempus, erat dui vehicula enim, non gravida leo dolor id lectus. Aliquam leo augue, pharetra eu purus eu, pretium volutpat nunc. Fusce eleifend eget augue fringilla facilisis."

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping

    return NSAttributedString(
        string: text,
        attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size), weight: weight)
        ]
    )
}

func generate(attrStr: NSAttributedString) -> PDFDocument {

    let renderer = UIGraphicsPDFRenderer(
        bounds: pageSize(),
        format: format()
    )

    let data = renderer.pdfData { (context) in
        context.beginPage()
        attrStr.draw(in: pageSize())
    }

    return PDFDocument(data: data)!
}

/*
save(
    generate(
        attrStr: attrString2()
    )
)
 */

func heightForAttributedString(_ attributedString: NSAttributedString, width: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = attributedString.boundingRect(with: constraintRect,
                                                   options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                   context: nil)
    return ceil(boundingBox.height)
}

func heightForComplexAttributedString(_ attributedString: NSAttributedString, width: CGFloat) -> CGFloat {
    let textStorage = NSTextStorage(attributedString: attributedString)
    let textContainer = NSTextContainer(size: CGSize(width: width, height: .greatestFiniteMagnitude))
    textContainer.lineFragmentPadding = 0

    let layoutManager = NSLayoutManager()
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)

    layoutManager.ensureLayout(for: textContainer)
    return layoutManager.usedRect(for: textContainer).height
}

/*
print(
    heightForAttributedString(
        attrString2(),
        width: 500.0
    )
)

print(
    heightForComplexAttributedString(
        attrString2(),
        width: 500.0
    )
)
 */

func generate(from arr: [NSAttributedString]) -> PDFDocument {

    let renderer = UIGraphicsPDFRenderer(
        bounds: pageSize(),
        format: format()
    )

    let data = renderer.pdfData { (context) in
        context.beginPage()

        var y = CGFloat.zero

        for attrStr in arr {

            let width = pageSize().width
            let height = heightForAttributedString(attrStr, width: width)

            let newRect = CGRect(
                x: 0,
                y: y,
                width: width,
                height: height
            )
            attrStr.draw(in: newRect)
            y += height
        }
    }

    return PDFDocument(data: data)!
}


func generate2(from arr: [NSAttributedString]) -> PDFDocument {

    let renderer = UIGraphicsPDFRenderer(
        bounds: pageSize(),
        format: format()
    )

    let data = renderer.pdfData { (context) in

        var y = CGFloat.zero
        context.beginPage()

        for attrStr in arr {

            let width = pageSize().width
            let height = heightForAttributedString(attrStr, width: width)

            if y + height > pageSize().height {
                y = CGFloat.zero
                context.beginPage()
            }

            attrStr.draw(
                in: CGRect(
                    x: 0,
                    y: y,
                    width: width,
                    height: height
                )
            )

            y += height

        }
    }

    return PDFDocument(data: data)!
}

/*
save(
    generate2(
        from: [

            attrString(size: 12, weight: .light),
            attrString(size: 16, weight: .regular),
            attrString(size: 20, weight: .medium),
            attrString(size: 24, weight: .bold),
            attrString(size: 12, weight: .light),
            attrString(size: 16, weight: .regular),
            attrString(size: 20, weight: .medium),
            attrString(size: 24, weight: .bold)
        ]
    )
)
*/

save(
    generate2(
        from: Resume
            .sampleResume()
            .attributedString()
    )
)

