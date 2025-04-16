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

    @State private var selectedSection: SidebarSection = .skills

    var body: some View {
        NavigationSplitView {
            SidebarView(selectedSection: $selectedSection)
                .frame(minWidth: 200)
        } content: {

            NavigationContentView(section: selectedSection, resume: $state)
                .frame(minWidth: 400)

//            Form {
//                PersonalInfoSection(personalInfo: $state.personalInfo)
//                SummarySection(summary: $state.summary)
//                SkillsView()
//                WorkExperienceSection(workExperience: $state.workExp)
//            }
//            .formStyle(.grouped)
//            .padding()
//            .frame(minWidth: 400)

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
    @Binding var resume: Resume

    var body: some View {

        switch section {

        case .personalInfo:
            PersonalInfoView(personalInfo: $resume.personalInfo)

        case .skills:
            SkillsForm(skills: Skills.mock)

        case .experience:
            VStack(alignment: .leading, spacing: 15) {
                ExperienceItem(
                    role: "Senior iOS Developer",
                    company: "Tech Innovations Inc.",
                    period: "2020-Present",
                    description: "Lead developer for multiple iOS applications with SwiftUI"
                )
                ExperienceItem(
                    role: "iOS Developer",
                    company: "Mobile Solutions LLC",
                    period: "2017-2020",
                    description: "Worked on various client projects using UIKit and Swift"
                )
            }
            .padding()
            .background(.secondary)
            .cornerRadius(10)
        case .education:
            VStack(alignment: .leading, spacing: 15) {
                EducationItem(
                    degree: "M.S. Computer Science",
                    institution: "Tech University",
                    year: "2017",
                    details: "Focus on Mobile Computing"
                )
                EducationItem(
                    degree: "B.S. Computer Science",
                    institution: "State University",
                    year: "2015",
                    details: "Minor in Design"
                )
            }
            .padding()
            .background(.secondary)
            .cornerRadius(10)
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.headline)
                .frame(width: 80, alignment: .leading)
            Text(value)
                .font(.body)
        }
    }
}

struct ExperienceItem: View {
    let role: String
    let company: String
    let period: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(role)
                .font(.headline)
            Text(company)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(period)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(description)
                .font(.body)
                .padding(.top, 2)
        }
    }
}

struct EducationItem: View {
    let degree: String
    let institution: String
    let year: String
    let details: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(degree)
                .font(.headline)
            Text(institution)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(year)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(details)
                .font(.body)
                .padding(.top, 2)
        }
    }
}
