import SwiftUI

struct ContentView: View {

    @Environment(Resume.self) private var resume
    @State private var selectedSectionID: SectionID? = nil

    var body: some View {
        NavigationSplitView {
            SidebarView(selectedSectionID: $selectedSectionID)
                .frame(minWidth: 200)
        } content: {
            NavigationContentView()
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

enum SectionID: Hashable {
    case personalInfo
    case summary
    case skillsHeader // ID for the "Skills" header itself
    case addSkill
    case experienceHeader // ID for the "Experience" header
    case experience(UUID)
    case addExperience
    case educationHeader // ID for the "Education" header
    case education(UUID)
    case addEducation

    // We might still need IDs for specific items *in the content view*,
    // but the sidebar only needs to navigate to the *start* of these sections or add items.
    // So, we won't need skill(UUID), experience(UUID), etc., *for sidebar taps* in this simplified approach.
}

struct SidebarView: View {

    @Environment(Resume.self) private var resume
    @Binding var selectedSectionID: SectionID? // Receive the binding

    var body: some View {
        List {
            // --- Personal Info ---
            sidebarButton(
                text: "Personal Info",
                sectionID: .personalInfo,
                isHeadline: true,
                selectedSectionID: $selectedSectionID
            )

            // --- Summary ---
            sidebarButton(
                text: "Summary",
                sectionID: .summary,
                isHeadline: true,
                selectedSectionID: $selectedSectionID
            )

            sidebarButton(
                text: "Skills",
                sectionID: .skillsHeader,
                isHeadline: true,
                selectedSectionID: $selectedSectionID
            )

            sidebarButton(
                text: "Add New Skill",
                sectionID: .addSkill,
                isHeadline: false,
                selectedSectionID: $selectedSectionID
            )
            .foregroundStyle(Color.accentColor)
            .padding(.leading)

            // --- Experience ---
            Section {
                // Tappable Header
                sidebarButton(text: "Experience", sectionID: .experienceHeader, isHeadline: true, selectedSectionID: $selectedSectionID)

                // Non-tappable items in this simplified sidebar version
                ForEach(resume.workExperienceCollection.items) { exp in
                    sidebarButton(
                        text: exp.companyName,
                        sectionID: .experience(exp.id),
                        isHeadline: false,
                        selectedSectionID: $selectedSectionID
                    )
                     .padding(.leading) // Indent slightly
                }

                sidebarButton(
                    text: "Add New Experience",
                    sectionID: .addExperience,
                    isHeadline: false,
                    selectedSectionID: $selectedSectionID
                )
                    .foregroundStyle(Color.accentColor)
                    .padding(.leading) // Indent slightly

             } header: {
                 EmptyView()
             }

            // --- Education ---
            Section {
                 // Tappable Header
                sidebarButton(
                    text: "Education",
                    sectionID: .educationHeader,
                    isHeadline: true,
                    selectedSectionID: $selectedSectionID
                )

                // Non-tappable items in this simplified sidebar version
                ForEach(resume.educationCollection.items) { edu in
                    sidebarButton(
                        text: edu.degree,
                        sectionID: .education(edu.id),
                        isHeadline: false,
                        selectedSectionID: $selectedSectionID
                    )
                     .padding(.leading) // Indent slightly
                }

                // Tappable Add Button
                sidebarButton(
                    text: "+ Add New Education",
                    sectionID: .addEducation,
                    isHeadline: false,
                    selectedSectionID: $selectedSectionID
                )
                    .foregroundStyle(Color.accentColor)
                    .padding(.leading)

             } header: {
                  EmptyView()
             }
        }
        .navigationTitle("Resume")
    }

    // Helper view/function for repeatable button creation
    @ViewBuilder
    private func sidebarButton(text: String, sectionID: SectionID, isHeadline: Bool, selectedSectionID: Binding<SectionID?>) -> some View {
        Button {
            selectedSectionID.wrappedValue = sectionID
        } label: {
            Text(text)
                .font(isHeadline ? .headline : .body)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure full width tap
                .contentShape(Rectangle()) // Make sure the whole area is tappable
        }
        .buttonStyle(.plain) // Use plain style to keep text appearance
    }
}

// Assume Resume, Item structs, ContentView, NavigationContentView, etc., exist as before.
// Make sure the NavigationContentView uses these SectionIDs in its .id() modifiers
// for the corresponding sections/headers/add buttons. For example:
// - PersonalInfoSection(...).id(SectionID.personalInfo)
// - Section("Skills") { ... }.id(SectionID.skillsHeader) // ID on the Section or a view within it
// - AddSkillSection().id(SectionID.addSkill)
// - etc.

#Preview("Sidebar") {
    SidebarView(selectedSectionID: .constant(.addEducation))
}


struct NavigationContentView: View {

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
