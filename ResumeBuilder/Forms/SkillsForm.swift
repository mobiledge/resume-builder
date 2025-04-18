import SwiftUI

fileprivate typealias DeleteSkillHandler = (Skill) -> Void
fileprivate typealias AddSkillHandler = (Skill) -> Void
fileprivate typealias CanMoveUpHandler = (Skill) -> Bool
fileprivate typealias MoveUpHandler = (Skill) -> Void
fileprivate typealias CanMoveDownHandler = (Skill) -> Bool
fileprivate typealias MoveDownHandler = (Skill) -> Void

struct SkillsForm: View {
    @Bindable var skills: SkillCollection
    @State private var newSkill = Skill(category: "", values: "")

    var body: some View {
        Form {
            ForEach(skills.items) { skill in
                SkillSection(
                    skill: skill,
                    deleteSkillHandler: deleteSkill(_:),
                    canMoveUpHandler: canMoveUp(_:),
                    moveUpHandler: moveUp(_:),
                    canMoveDownHandler: canMoveDown(_:),
                    moveDownHandler: moveDown(_:)
                )
            }

            AddSkillSection(
                skill: $newSkill,
                addSkillHandler: addSkill(_:)
            )
        }
        .formStyle(.grouped)
        .animation(.spring(duration: 0.3), value: skills.items) // Animate when items array changes
    }

    func deleteSkill(_ skill: Skill) {
        withAnimation {
            skills.items.removeAll { $0.id == skill.id }
        }
    }

    func addSkill(_ skill: Skill) {
        withAnimation {
            skills.items.append(skill)
            // Reset the new skill form after adding
            newSkill = Skill(category: "", values: "")
        }
    }

    func canMoveUp(_ skill: Skill) -> Bool {
        // Check if the skill exists in the array and is not the first item
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }) else {
            return false
        }
        return index > 0
    }

    func moveUp(_ skill: Skill) -> Void {
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }),
              canMoveUp(skill) else {
            return
        }

        // Swap the skill with the one above it
        withAnimation {
            skills.items.swapAt(index, index - 1)
        }
    }

    func canMoveDown(_ skill: Skill) -> Bool {
        // Check if the skill exists in the array and is not the last item
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }) else {
            return false
        }
        return index < skills.items.count - 1
    }

    func moveDown(_ skill: Skill) -> Void {
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }),
              canMoveDown(skill) else {
            return
        }

        // Swap the skill with the one below it
        withAnimation {
            skills.items.swapAt(index, index + 1)
        }
    }
}

struct AddSkillSection: View {
    @Binding var skill: Skill
    fileprivate let addSkillHandler: AddSkillHandler

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
                Button(action: addSkill) {
                    Text("Add")
                }
                .disabled(skill.category.isEmpty || skill.values.isEmpty)
            }
        }
    }

    func addSkill() {
        addSkillHandler(skill)
    }
}

struct SkillSection: View {
    @Bindable var skill: Skill
    fileprivate let deleteSkillHandler: DeleteSkillHandler
    fileprivate let canMoveUpHandler: CanMoveUpHandler
    fileprivate let moveUpHandler: MoveUpHandler
    fileprivate let canMoveDownHandler: CanMoveDownHandler
    fileprivate let moveDownHandler: MoveDownHandler

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

            Button(action: {
                moveDownHandler(skill)
            }, label: {
                Label("Move Down", systemImage: "arrowshape.down")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
            .disabled(!canMoveDownHandler(skill))

            Button(action: {
                moveUpHandler(skill)
            }, label: {
                Label("Move Up", systemImage: "arrowshape.up")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
            .disabled(!canMoveUpHandler(skill))

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

#Preview {
    SkillsForm(skills: SkillCollection.mock)
}

