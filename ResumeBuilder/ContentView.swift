//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {

    @State var personalInfo = PersonalInfo.mock

    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
                .frame(minWidth: 200)
        } content: {
            PersonalInfoForm(personalInfo: $personalInfo)
                .frame(minWidth: 350) // Set a minimum width for the content column
        } detail: {
            PDFViewer(attributedString: personalInfo.attributedString())
                .frame(minWidth: 400)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
        .frame(width: 1200, height: 600)
}
