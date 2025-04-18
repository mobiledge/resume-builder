//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {

    @Environment(Resume.self) private var resume
    @State private var selectedSection: SidebarSection = .skills

    var body: some View {
        NavigationSplitView {
            SidebarView(selectedSection: $selectedSection)
                .frame(minWidth: 200)
        } content: {
            NavigationContentView(section: selectedSection)
                .frame(minWidth: 400)
        } detail: {
            PDFViewer(document: resume.pdfDocument)
                .frame(minWidth: 400)
        }
        .frame(minWidth: 1000, minHeight: 800)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
        .environment(Resume.mock)
}

enum SidebarSection: String, CaseIterable, Identifiable {
    case personalInfo
    case skills
    case experience
    case education

    var id: Self { self }

    var title: String {
        switch self {
        case .personalInfo: return "Personal Information"
        case .skills: return "Skills"
        case .experience: return "Experience"
        case .education: return "Education"
        }
    }

    var icon: String {
        switch self {
        case .personalInfo: return "person.crop.circle"
        case .skills: return "star.fill"
        case .experience: return "briefcase"
        case .education: return "graduationcap"
        }
    }

    var description: String {
        switch self {
        case .personalInfo: return "Basic personal and contact information"
        case .skills: return "Technical and soft skills"
        case .experience: return "Work history and professional achievements"
        case .education: return "Academic background and certifications"
        }
    }
}

struct SidebarView: View {
    @Binding var selectedSection: SidebarSection

    var body: some View {
        List(SidebarSection.allCases, selection: $selectedSection) { section in
            NavigationLink(value: section) {
                Label(section.title, systemImage: section.icon)
            }
        }
        .navigationTitle("Resume")
    }
}

struct NavigationContentView: View {
    let section: SidebarSection

    @Environment(Resume.self) private var resume

    var body: some View {

        switch section {

        case .personalInfo:
            PersonalInfoForm()
                .environment(resume.personalInfo)

        case .skills:
            SkillsForm()
                .environment(resume.skills)

        case .experience:
            WorkExperienceForm(collection: resume.workExperienceCollection)

        case .education:
            EducationForm(collection: resume.educationCollection)
        }
    }
}

