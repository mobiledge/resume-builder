import SwiftUI

struct ContentView: View {

    @Environment(Resume.self) private var resume

    var body: some View {
        NavigationSplitView {
            SidebarView()
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

struct SidebarView: View {

    @Environment(Resume.self) private var resume

    var body: some View {
        List {

            Text("Personal Info")
                .font(.headline)

            Text("Summary")
                .font(.headline)

            Text("Skills")
                .font(.headline)

            Text("+ Add New Skill")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)

            Text("Experience")
                .font(.headline)

            ForEach(resume.workExperienceCollection.items) { exp in
                VStack(alignment: .leading) {
                    Text(exp.companyName)
                    Text(exp.position)
                        .font(.caption2)
                        .foregroundStyle(Color.secondary)
                }
            }

            Text("+ Add New Experience")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)

            Text("Education")
                .font(.headline)

            ForEach(resume.educationCollection.items) { edu in
                VStack(alignment: .leading) {
                    Text(edu.degree)
                    Text(edu.institution)
                        .font(.caption2)
                        .foregroundStyle(Color.secondary)
                }
            }

            Text("+ Add New Education")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .navigationTitle("Resume")
    }
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
