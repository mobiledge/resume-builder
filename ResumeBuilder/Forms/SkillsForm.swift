import SwiftUI

struct SkillsForm: View {

    @Environment(Resume.self) private var resume

    var body: some View {
        Form {
            ForEach(resume.skills.items) { skill in
                SkillSection(skill: skill)
            }

            AddSkillSection()
        }
        .formStyle(.grouped)
    }
}

struct SkillSection: View {
    @Bindable var skill: Skill

    @Environment(Resume.self) private var resume

    var body: some View {
        Section {
            categoryTextField
            skillsTextField
            actionButtons
        }
        .transition(.slide) // Add transition for the whole section
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
            moveDownButton
            moveUpButton
            deleteButton
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.secondary)
    }

    var moveDownButton: some View {
        Button(action: moveDown) {
            Label("Move Down", systemImage: "arrowshape.down")
                .labelStyle(.iconOnly)
                .font(.caption)
        }
        .disabled(!canMoveDown())
    }

    var moveUpButton: some View {
        Button(action: moveUp) {
            Label("Move Up", systemImage: "arrowshape.up")
                .labelStyle(.iconOnly)
                .font(.caption)
        }
        .disabled(!canMoveUp())
    }

    var deleteButton: some View {
        Button(action: delete) {
            Label("Delete", systemImage: "trash")
                .labelStyle(.iconOnly)
                .font(.caption)
        }
    }



    // MARK: - Private Action Functions

    private func moveDown() {
        resume.moveDown(skill: skill)
    }

    private func canMoveDown() -> Bool {
        resume.canMoveDown(skill: skill)
    }

    private func moveUp() {
        resume.moveUp(skill: skill)
    }

    private func canMoveUp() -> Bool {
        resume.canMoveUp(skill: skill)
    }

    private func delete() {
        resume.delete(skill: skill)
    }
}

struct AddSkillSection: View {
    @State private var skill = Skill(category: "", values: "")
    @Environment(Resume.self) private var resume

    var body: some View {
        Section("Add New Skill") {
            categoryTextField
            skillsTextField
            addButtonRow
        }
    }

    var categoryTextField: some View {
        TextField(text: $skill.category, prompt: Text("Enter Skill Category")) {
            Text("Category")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }

    var skillsTextField: some View {
        TextField(text: $skill.values, prompt: Text("Enter comma seperated skills")) {
            Text("Skills")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }

    var addButton: some View {
        Button(action: add) {
            Text("Add")
        }
        .disabled(skill.category.isEmpty)
    }

    var addButtonRow: some View {
        HStack(alignment: .center) {
            Spacer()
            addButton
        }
    }

    // MARK: - Private Action Functions

    private func add() {
        resume.add(skill: skill)
        skill = Skill(category: "", values: "")
    }
}

#Preview {
    SkillsForm()
        .environment(Resume.mock)
        .environment(Resume.mock.skills)
}

