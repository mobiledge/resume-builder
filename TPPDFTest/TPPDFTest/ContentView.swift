//
//  ContentView.swift
//  TPPDFTest
//
//  Created by Rabin Joshi on 2025-03-28.
//

import SwiftUI

struct ContentView: View {
    @State private var personalInfo = PersonalInfo.mock

    var body: some View {
        HStack {
            PersonalInfoForm(personalInfo: personalInfo)

            Divider()

            ScrollView {
                Text(personalInfo.attributedString.string)
                    .textSelection(.enabled)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
