//
//  ResumeBuilderApp.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

@main
struct ResumeBuilderApp: App {

    @State var resume = Resume.mock

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(resume)
        }
    }
}
