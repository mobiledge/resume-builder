import SwiftUI

struct SkillsForm: View {

    @Bindable var skills: Skills

    var body: some View {
        Form {

            ForEach(skills.items) { skill in
                SkillSection(skill: skill)
            }
            AddSkillSection(skill: Skill(category: "", values: ""))
        }
        .formStyle(.grouped)
    }
}

#Preview("SkillsForm") {
    SkillsForm(skills: Skills.mock)
}

struct AddSkillSection: View {

    @Bindable var skill: Skill

    var body: some View {

        Section("Add New Skill") {

            TextField(text: $skill.category, prompt: Text("Enter Skill Category")) {
                Text("Category")
                    .font(.headline)
                    .foregroundColor(.secondary)

            }

            TextField(text: $skill.values, prompt: Text("Enter comma seperated skills")) {
                Text("Skills")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            HStack(alignment: .center) {
                Spacer()
                Button("Add") {
                    print("Add")
                }
            }
        }
    }
}

struct SkillSection: View {

    @Bindable var skill: Skill

    var body: some View {
        Section {
            categoryTextField
            skillsTextField
            actionButtons
        }
    }

    var categoryTextField: some View {
        TextField(text: $skill.category, prompt: Text("Enter Skill Category")) {
            Text("Category")
                .font(.body)
                .foregroundStyle(Color.secondary)
        }
    }

    var skillsTextField: some View {
        TextField(text: $skill.values, prompt: Text("Enter comma seperated skills")) {
            Text("Skills")
                .font(.body)
                .foregroundStyle(Color.secondary)
        }
    }

    var actionButtons: some View {

        HStack(spacing: 20) {

            Spacer()

            Button(action: {
                print("Move Down!")
            }, label: {
                Label("Move Down!", systemImage: "arrowshape.down")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })

            Button(action: {
                print("Move Up!")
            }, label: {
                Label("Move Up!", systemImage: "arrowshape.up")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })

            Button(action: {
                print("Delete")
            }, label: {
                Label("Delete", systemImage: "trash")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })

        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.secondary)
    }
}

#Preview("SkillSection") {
        SkillSection(skill: Skill(category: "Languages", values: "Swift, Objective-C, C++, C"))
}
