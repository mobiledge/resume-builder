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
//            NavigationContentView(section: selectedSection)
            NavigationContentView2()
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

        case .skills:
            SkillsForm()

        case .experience:
            WorkExperienceForm()

        case .education:
            EducationForm()
        }
    }
}

struct NavigationContentView2: View {

    @Environment(Resume.self) private var resume

    var body: some View {

        Form {
            PersonalInfoSection(personalInfo: resume.personalInfo)
            PersonalInfoSummarySection(personalInfo: resume.personalInfo)

            ForEach(resume.skills.items) { skill in
                SkillSection(skill: skill)
            }
            AddSkillSection()

            ForEach(resume.workExperienceCollection.items) { exp in
                WorkExperienceSection(experience: exp)
            }
            AddExperienceSection()

            ForEach(resume.educationCollection.items) { edu in
                EducationSection(education: edu)
            }
            AddEducationSection()
        }
        .formStyle(.grouped)
    }
}

struct SectionHeader: View {

    let section: SidebarSection
    let isFirst: Bool
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            if isFirst {
                Text(section.title)
                    .font(.title)
                    .foregroundStyle(Color(nsColor: .headerTextColor))
            }

            Text(title)
                .font(.headline)
                .foregroundStyle(Color(nsColor: .headerTextColor))
        }
    }
}
