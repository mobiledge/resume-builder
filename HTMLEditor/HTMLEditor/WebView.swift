import SwiftUI
import WebKit

// A SwiftUI view that wraps a WKWebView from AppKit for macOS
struct WebView: NSViewRepresentable {
    // The HTML content string to display
    let htmlContent: String

    // Creates the initial WKWebView
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        // Basic configuration (optional)
        webView.configuration.preferences.javaScriptEnabled = true // Enable JS if needed
        return webView
    }

    // Updates the WKWebView when the htmlContent changes
    func updateNSView(_ nsView: WKWebView, context: Context) {
        // Load the HTML string into the web view
        // Using a nil baseURL assumes no external resources need resolving relative to a base path
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

// Optional preview provider for Xcode Previews
#if DEBUG
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(htmlContent: "<h1>Hello Preview</h1><p>This is a preview.</p>")
            .frame(width: 300, height: 200)
    }
}
#endif
