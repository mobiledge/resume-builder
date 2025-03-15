//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {

    @State var state = Resume()

    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
                .frame(minWidth: 200)
        } content: {
            ScrollView {
                Form {
                    PersonalInfoSection(personalInfo: $state.personalInfo)
                    SummarySection(summary: $state.summary)
                    WorkExperienceSection(workExperience: $state.workExp)
                }
                .padding()
            }
            .frame(minWidth: 240)

        } detail: {
            PDFViewer(document: state.pdfDocument)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
        .frame(width: 1200, height: 600)
}
