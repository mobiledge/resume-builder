//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {

    // US Letter dimensions in points
    private let usLetterWidth: CGFloat = 612
    private let usLetterHeight: CGFloat = 792

    @State var state = Resume()

    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
                .frame(minWidth: 200)
        } content: {
            Form {
                PersonalInfoSection(personalInfo: $state.personalInfo)
                SummarySection(summary: $state.summary)
                WorkExperienceSection(workExperience: $state.workExp)
            }
            .formStyle(.grouped)
            .padding()
            .frame(minWidth: 400)

        } detail: {
            PDFViewer(document: state.pdfDocument)
                .frame(minWidth: usLetterWidth, idealWidth: usLetterWidth)
        }
        .frame(minWidth: usLetterWidth * 2 + 200, minHeight: usLetterHeight)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
}
