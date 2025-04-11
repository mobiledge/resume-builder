//
//  ContentView.swift
//  MarkdownToHTML
//
//  Created by Rabin Joshi on 2025-03-27.
//

import SwiftUI
import Ink

struct ContentView: View {
    @State private var markdownText = """
    # Hello, Markdown!
    
    This is a **simple** Markdown editor.
    
    - List item 1
    - List item 2
    
    [Visit Apple](https://www.apple.com)
    """
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Markdown Editor")
                .font(.title)
                .padding()

            TextEditor(text: $markdownText)
                .font(.system(.body, design: .monospaced))
                .padding()
                .border(Color.gray, width: 1)

            Button(action: exportToHTML) {
                Text("Export to HTML")
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .frame(minWidth: 500, minHeight: 600)
        .padding()
        .alert("Export Complete", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    func exportToHTML() {
        do {
            let html = convertMarkdownToHTML(markdownText)
            let fullHTML = wrapInHTMLDocument(html: html)
            try saveToDownloads(fullHTML)
            showSuccessAlert()
        } catch {
            showErrorAlert(error: error)
        }
    }

    // MARK: - Conversion Functions
    private func convertMarkdownToHTML(_ markdown: String) -> String {
        let parser = MarkdownParser()
        return parser.html(from: markdown)
    }

    private func wrapInHTMLDocument(html: String) -> String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8">
            <title>Converted Markdown</title>
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                    line-height: 1.6;
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 20px;
                    color: #333;
                }
                pre {
                    background-color: #f5f5f5;
                    padding: 16px;
                    border-radius: 4px;
                    overflow-x: auto;
                }
                code {
                    font-family: Menlo, Monaco, Consolas, "Courier New", monospace;
                }
            </style>
        </head>
        <body>
        \(html)
        </body>
        </html>
        """
    }

    // MARK: - File Handling Functions
    private func saveToDownloads(_ html: String) throws {

        func downloadsFileURL() throws -> URL {
            guard let downloadsDirectory = FileManager.default.urls(
                for: .downloadsDirectory,
                in: .userDomainMask
            ).first else {
                throw FileError.downloadsDirectoryNotFound
            }

            let filename = "markdown-export-\(Date().timeIntervalSince1970).html"
            return downloadsDirectory.appendingPathComponent(filename)
        }

        let url = try downloadsFileURL()
        try html.write(to: url, atomically: true, encoding: .utf8)
    }

    // MARK: - Alert Functions
    private func showSuccessAlert() {
        alertMessage = "HTML file saved to Downloads directory"
        showingAlert = true
    }

    private func showErrorAlert(error: Error) {
        alertMessage = "Error saving file: \(error.localizedDescription)"
        showingAlert = true
    }

    // MARK: - Error Handling
    enum FileError: Error {
        case downloadsDirectoryNotFound
        case writeFailed(Error)

        var localizedDescription: String {
            switch self {
            case .downloadsDirectoryNotFound:
                return "Could not locate Downloads directory"
            case .writeFailed(let error):
                return "File write failed: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
