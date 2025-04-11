//
//  ContentView.swift
//  TPPDFTest
//
//  Created by Rabin Joshi on 2025-03-28.
//


import Foundation
import TPPDF
import SwiftUI

struct ContentView: View {
    @State private var personalInfo = PersonalInfo.mock

    var body: some View {
        HStack {
            PersonalInfoForm(personalInfo: personalInfo)

            Divider()

            ScrollView {
                VStack {
                    Text(personalInfo.attributedString.string)
                        .textSelection(.enabled)
                    Button(action: exportToPDF) {
                        Text("Export to File")
                    }
                }
            }
        }
        .padding()
    }

    private func exportToPDF() {
        do {
            // 1. Get the target directory (Downloads in this case)
            let downloadsDirectory = try FileManager.default.url(
                for: .downloadsDirectory, // Or .documentDirectory for iOS sandboxed apps
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )

            let fileURL = downloadsDirectory.appendingPathComponent("resume.pdf") // Changed extension to .pdf

            // 2. Create a TPPDF document instance
            //    You can customize the page format (e.g., .a4, .letter) and margins
            let document = PDFDocument(format: .a4)

            let style = PDFTextStyle(name: "bold", font: .boldSystemFont(ofSize: 16))

            // 3. Add content to the document using TPPDF objects
            //    Using PDFSimpleText for basic text lines. Add spacing for readability.

            // --- Personal Information Section ---
            document.add(textObject: PDFSimpleText(text: "Personal Information", style: style)) // Example styling
            document.add(space: 5) // Add some vertical space
            document.add(textObject: PDFSimpleText(text: "Name: \(personalInfo.name)"))
            document.add(textObject: PDFSimpleText(text: "Title: \(personalInfo.title)"))
            document.add(space: 15) // Space before next section

            // --- Location Section ---
            document.add(textObject: PDFSimpleText(text: "Location", style: style))
            document.add(space: 5)
            document.add(textObject: PDFSimpleText(text: "City: \(personalInfo.city)"))
            document.add(textObject: PDFSimpleText(text: "State/Province: \(personalInfo.state)"))
            document.add(textObject: PDFSimpleText(text: "Country: \(personalInfo.country)"))
            document.add(space: 15)

            document.add(PDFContainer.contentLeft, text: personalInfo.city)
            document.add(PDFContainer.contentCenter, text: personalInfo.state)
            document.add(PDFContainer.contentRight, text: personalInfo.country)


            // --- Contact Information Section ---
            document.add(textObject: PDFSimpleText(text: "Contact Information", style: style))
            document.add(space: 5)
            document.add(textObject: PDFSimpleText(text: "Email: \(personalInfo.email)"))
            document.add(textObject: PDFSimpleText(text: "Phone: \(personalInfo.phone)"))
            document.add(space: 15)

            // --- Online Profiles Section ---
            document.add(textObject: PDFSimpleText(text: "Online Profiles", style: style))
            document.add(space: 5)
            document.add(textObject: PDFSimpleText(text: "LinkedIn: \(personalInfo.linkedIn)"))
            document.add(textObject: PDFSimpleText(text: "GitHub: \(personalInfo.github)"))

            let table = PDFTable(rows: 1, columns: 2)

            // Remove all borders and styling
            table.style = PDFTableStyle(outline: PDFLineStyle(type: .none, color: .clear))
            table.padding = 0
            table.margin = 0


            let emailCell = table[0, 0]
            emailCell.content = try PDFTableContent(content: personalInfo.email)
            emailCell.alignment = .left

            let phoneCell = table[0, 1]
            phoneCell.content = try PDFTableContent(content: personalInfo.phone)
            phoneCell.alignment = .right

            document.add(table: table)
            document.add(space: 15)

            let generator = PDFGenerator(document: document)
            let data = try generator.generateData()
            save(data: data, filename: "resume.pdf")

        } catch {
            // Handle errors from FileManager or TPPDF generation
            print("Error saving PDF file: \(error.localizedDescription)")
            // You might want more specific error handling based on the error type
            if let pdfError = error as? PDFError {
                print("TPPDF specific error: \(pdfError)")
            }
        }
    }

    private func save(data: Data, filename: String) {
        do {
            let downloadsDirectory = try FileManager.default.url(
                for: .downloadsDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let url = downloadsDirectory.appendingPathComponent(filename)
            try data.write(to: url, options: .atomic)
            print("Successfully saved to: \(url.path)")
        } catch {
            print("Error saving file: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
