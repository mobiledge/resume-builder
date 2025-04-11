import SwiftUI

struct ContentView: View {
    @State private var htmlText = Constant.htmlString

    // US Letter dimensions in points
    private let usLetterWidth: CGFloat = 612
    private let usLetterHeight: CGFloat = 792

    var body: some View {
        HSplitView {
            // Editor panel (flexible width)
            TextEditor(text: $htmlText)
                .font(.system(.body, design: .monospaced))
                .padding()

            // Preview panel fixed to US Letter width
            WebView(htmlContent: htmlText)
                .frame(width: usLetterWidth)
                .padding()
        }
        .frame(minWidth: usLetterWidth + 500, minHeight: usLetterHeight) // Extra width for editor
    }
}
#Preview {
    ContentView()
}
