import SwiftUI

typealias DeleteSkillHandler = (Skill) -> Void

//@Observable
//class SkillsViewModel {
//    internal init(skills: Skills) {
//        self.skills = skills
//    }
//    
//
//    var skills: Skills
//
//    func deleteSkill() {
//
//    }
//
//}

struct SkillsForm: View {

    @Bindable var skills: Skills

    var body: some View {
        Form {

            ForEach(skills.items) { skill in
                SkillSection(skill: skill, deleteSkillHandler: deleteSkill(_:))
            }
            AddSkillSection(skill: Skill(category: "", values: ""))
        }
        .formStyle(.grouped)
    }

    func deleteSkill(_ skill: Skill) {
        skills.items.removeAll { $0.id == skill.id }
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

    let deleteSkillHandler: DeleteSkillHandler

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

            Button(action: deleteSkill) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            }

        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.secondary)
    }

    func deleteSkill() {
        deleteSkillHandler(skill)
    }
}

#Preview("SkillSection") {
    SkillSection(skill: Skill(category: "Languages", values: "Swift, Objective-C, C++, C"), deleteSkillHandler: {_ in})
}
