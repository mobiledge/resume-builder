import Foundation
import WebKit

// Error definition for custom errors
enum ConversionError: Error, LocalizedError {
    case timeout
    case pdfCreationFailed(String)
    case noDataGenerated

    var errorDescription: String? {
        switch self {
        case .timeout:
            return "The HTML to PDF conversion timed out."
        case .pdfCreationFailed(let reason):
            return "Failed to create PDF data. Reason: \(reason)"
        case .noDataGenerated:
            return "No PDF data was generated, although no specific error occurred."
        }
    }
}

class HTMLToPDFConverter: NSObject, WKNavigationDelegate {
    private var webView: WKWebView? // Make optional for cleanup
    private var completion: ((Result<Data, Error>) -> Void)?
    private var timeoutTimer: Timer?
    private let conversionTimeout: TimeInterval

    // Keep track to prevent calling completion multiple times
    private var didComplete = false

    // Initializer allowing configuration
    init(timeout: TimeInterval = 30.0) { // Default timeout 30s
        self.conversionTimeout = timeout
        super.init()

        // WKWebView setup needs to be done on the main thread.
        // Since this might be called from any thread, dispatch explicitly.
        DispatchQueue.main.async {
            let webConfiguration = WKWebViewConfiguration()
            // Ensure content scales to fit the view if needed, though less relevant for PDF size
            webConfiguration.preferences.javaScriptEnabled = true // Ensure JS runs if needed for rendering

            // Define the viewport size for rendering
            let frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // A standard page size, adjust if needed

            self.webView = WKWebView(frame: frame, configuration: webConfiguration)
            self.webView?.navigationDelegate = self

            // Add the webview to a hidden view/window is sometimes required for it
            // to function correctly, especially complex rendering or JS.
            // For simpler command-line tools, this *might* not be strictly necessary,
            // but it's safer. We won't add a full window here for simplicity,
            // but be aware if issues arise.
        }
    }

    func convertHTMLToPDF(html: String, baseURL: URL? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        // Ensure setup is done (might take a moment due to async init)
        guard let webView = self.webView else {
            // If webView isn't ready yet, retry or fail
            // For simplicity, we'll retry once after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self, let webView = self.webView else {
                    completion(.failure(NSError(domain: "HTMLToPDFConverter", code: 0, userInfo: [NSLocalizedDescriptionKey: "WebView not initialized"])))
                    return
                }
                self.startConversion(html: html, baseURL: baseURL, webView: webView, completion: completion)
            }
            return
        }
        startConversion(html: html, baseURL: baseURL, webView: webView, completion: completion)
    }

    private func startConversion(html: String, baseURL: URL?, webView: WKWebView, completion: @escaping (Result<Data, Error>) -> Void) {
        // Dispatch actual webview work to the main thread
        DispatchQueue.main.async { [weak self] in
             guard let self = self else { return }

             // Reset state for a new conversion
             self.completion = completion
             self.didComplete = false
             self.timeoutTimer?.invalidate() // Invalidate previous timer if any

             // Set up timeout timer on the main run loop
             self.timeoutTimer = Timer.scheduledTimer(
                 withTimeInterval: self.conversionTimeout,
                 repeats: false,
                 block: { [weak self] _ in
                     print("Conversion timed out.")
                     self?.handleCompletion(.failure(ConversionError.timeout))
                 }
             )
             RunLoop.main.add(self.timeoutTimer!, forMode: .common) // Ensure timer runs even during other main thread activities

             print("Loading HTML content...")
             webView.loadHTMLString(html, baseURL: baseURL)
        }
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web content finished loading. Creating PDF...")
        // Give a very short delay for any final JS rendering, if needed. Adjust or remove if unnecessary.
        // This is a common workaround for JS-heavy pages.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
             guard let self = self else { return }

             let pdfConfiguration = WKPDFConfiguration()
             // Example: Set paper size (e.g., A4 dimensions in points)
             // let pointsPerInch: CGFloat = 72.0
             // let paperWidth = 8.27 * pointsPerInch // A4 width
             // let paperHeight = 11.69 * pointsPerInch // A4 height
             // pdfConfiguration.rect = CGRect(x: 0, y: 0, width: paperWidth, height: paperHeight)

             // Make sure we still have a webView
             guard let currentWebView = self.webView else {
                 self.handleCompletion(.failure(NSError(domain: "HTMLToPDFConverter", code: 1, userInfo: [NSLocalizedDescriptionKey: "WebView instance lost before PDF creation"])))
                 return
             }

             currentWebView.createPDF(configuration: pdfConfiguration) { [weak self] result in
                 print("PDF creation attempt finished.")
                 // Ensure result is handled on the main thread if needed, though Data is thread-safe
                 DispatchQueue.main.async {
                     switch result {
                     case .success(let data):
                         print("PDF data received successfully (\(data.count) bytes).")
                         self?.handleCompletion(.success(data))
                     case .failure(let error):
                         print("PDF creation failed: \(error.localizedDescription)")
                         self?.handleCompletion(.failure(ConversionError.pdfCreationFailed(error.localizedDescription)))
                     }
                 }
             }
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Ignore "Frame load interrupted" errors which can happen during redirects or rapid loads
        let nsError = error as NSError
        if !(nsError.domain == "WebKitErrorDomain" && nsError.code == 102) {
            print("Navigation failed: \(error.localizedDescription)")
            handleCompletion(.failure(error))
        } else {
            print("Ignoring 'Frame load interrupted' error.")
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Provisional navigation failed: \(error.localizedDescription)")
        handleCompletion(.failure(error))
    }

    private func handleCompletion(_ result: Result<Data, Error>) {
        // Ensure completion runs only once and on the main thread
        DispatchQueue.main.async { [weak self] in
            guard let self = self, !self.didComplete else {
                return // Already completed
            }
            self.didComplete = true // Mark as completed

            print("Handling completion...")
            self.timeoutTimer?.invalidate()
            self.timeoutTimer = nil

            self.completion?(result)
            self.completion = nil // Release closure

            // Optional: Clean up webView to release memory, especially if used multiple times
            // Or manage lifecycle externally if the converter instance is reused.
            // self.webView?.stopLoading()
            // self.webView?.navigationDelegate = nil
            // self.webView = nil
            print("Completion handler called and resources potentially cleaned.")
        }
    }

    // Deinit for cleanup confirmation
    deinit {
        print("HTMLToPDFConverter deinitialized.")
        // Ensure timer is invalidated if the object is deallocated before completion
        timeoutTimer?.invalidate()
        // Ensure webview cleanup happens on main thread if not already nil
        if let webView = webView {
            DispatchQueue.main.async {
                webView.stopLoading()
                webView.navigationDelegate = nil
            }
        }
    }
}

// Command-line interface execution function
func runConversion() {

    let htmlString = Constant.htmlString
    let converter = HTMLToPDFConverter(timeout: 45.0) // Use a slightly longer timeout
    let semaphore = DispatchSemaphore(value: 0)
    var resultData: Data?
    var conversionError: Error?
    let outputFilePath = "output.pdf" // Output file in the current directory
    let outputURL = URL(fileURLWithPath: outputFilePath)

    print("Starting HTML to PDF conversion process...")

    // Use the converter
    converter.convertHTMLToPDF(html: htmlString, baseURL: nil) { result in
        print("Converter completion handler invoked.")
        switch result {
        case .success(let data):
            resultData = data
            print("Successfully received PDF data.")
        case .failure(let error):
            conversionError = error
            print("Conversion failed with error: \(error.localizedDescription)")
        }
        semaphore.signal() // Signal that the async operation has finished
    }

    print("Waiting for conversion to complete (processing RunLoop)...")
    // Keep the main thread alive and process RunLoop events until the semaphore is signaled
    while semaphore.wait(timeout: .now() + 0.1) == .timedOut {
        // Process events scheduled on the main RunLoop, crucial for WKWebView callbacks
        RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0.05))
        // Optional: Add a safety break if it runs too long (e.g., > converter.timeout + grace period)
    }



    if let error = conversionError {
        print("❌ An error occurred during conversion: \(error.localizedDescription)")
        return
    }
    guard let pdfData = resultData else {
        print("❌ Conversion finished without error, but no PDF data was returned.")
        return
    }
    writeToFile(pdfData: pdfData)
}

func writeToFile(pdfData: Data) {
    do {
        let downloadsURL = try FileManager.default.url(for: .downloadsDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: true)

        let outputFileName = "output.pdf"
        let downloadsOutputURL = downloadsURL.appendingPathComponent(outputFileName)
        try pdfData.write(to: downloadsOutputURL)
        print("✅ Successfully generated PDF at: \(downloadsOutputURL.path)")
    } catch {
        print("❌ Failed to writeToFile: \(error.localizedDescription)")
    }
}

// --- Entry Point ---
// Ensure the conversion runs on the main thread as WKWebView requires it.
// If this script is run directly, it should already be on the main thread.
if Thread.isMainThread {
    runConversion()
} else {
    DispatchQueue.main.sync {
        runConversion()
    }
}

// Keep the RunLoop running indefinitely if needed for other async tasks,
// but in this simple case, exit() is called within runConversion.
// If exit() wasn't called, you might need:
// RunLoop.main.run()









