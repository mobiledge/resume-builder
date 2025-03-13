//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {

    @State var state = AppState()

    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
                .frame(minWidth: 200)
        } content: {
            PersonalInfoForm(personalInfo: $state.personalInfo)
                .frame(minWidth: 200)
        } detail: {
            PDFViewer(document: state.pdfDocument)
                .frame(minWidth: 400)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
        .frame(width: 1200, height: 600)
}
