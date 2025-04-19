import SwiftUI

struct WorkExperienceForm: View {

    @Environment(Resume.self) var resume

    var body: some View {

        Form {
            ForEach(resume.workExperienceCollection.items) { exp in
                WorkExperienceSection(experience: exp)
            }

            AddExperienceSection()
        }
        .formStyle(.grouped)
    }
}

struct WorkExperienceSection: View {
    @Bindable var experience: WorkExperience
    @Environment(Resume.self) private var resume

    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        Section {
            companyNameField
            positionField
            locationField
            startDatePicker

            if !experience.isCurrentPosition {
                endDatePicker
            }

            currentPositionToggle
            descriptionEditor
            actionButtons
        } header: {
            if resume.canMoveUp(experience: experience) {
                SectionHeaderView(style: .subheader(experience.companyName))
            } else {
                SectionHeaderView(style: .both("Work Experience", experience.companyName))
            }
        }
    }

    var companyNameField: some View {
        TextField("Company Name", text: $experience.companyName)
    }

    var positionField: some View {
        TextField("Position", text: $experience.position)
    }

    var locationField: some View {
        TextField("Location", text: $experience.location)
    }

    var startDatePicker: some View {
        DatePicker(
            "Start Date",
            selection: Binding(
                get: { experience.startDate ?? Date() },
                set: { experience.startDate = $0 }
            ),
            displayedComponents: .date
        )
    }

    var endDatePicker: some View {
        DatePicker(
            "End Date",
            selection: Binding(
                get: { experience.endDate ?? Date() },
                set: { experience.endDate = $0 }
            ),
            displayedComponents: .date
        )
    }

    var currentPositionToggle: some View {
        Toggle("Current Position", isOn: $experience.isCurrentPosition)
    }

    var descriptionEditor: some View {
        TextEditor(text: $experience.description)
            .textEditorStyle(.plain)
            .frame(minHeight: 60)
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
        resume.moveDown(experience: experience)
    }

    private func canMoveDown() -> Bool {
        resume.canMoveDown(experience: experience)
    }

    private func moveUp() {
        resume.moveUp(experience: experience)
    }

    private func canMoveUp() -> Bool {
        resume.canMoveUp(experience: experience)
    }

    private func delete() {
        resume.delete(experience: experience)
    }
}

struct AddExperienceSection: View {

    @Environment(Resume.self) private var resume
    @State private var experience = WorkExperience.empty

    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        Section {
            companyNameField
            positionField
            locationField
            startDatePicker

            if !experience.isCurrentPosition {
                endDatePicker
            }

            currentPositionToggle
            descriptionEditor
            addButtonRow
        } header: {
            if resume.workExperienceCollection.items.isEmpty {
                SectionHeaderView(style: .both("Work Experience", "Add New Work Experience"))
            } else {
                SectionHeaderView(style: .subheader("Add New Work Experience"))
            }
        }
    }

    var companyNameField: some View {
        TextField("Company Name", text: $experience.companyName)
    }

    var positionField: some View {
        TextField("Position", text: $experience.position)
    }

    var locationField: some View {
        TextField("Location", text: $experience.location)
    }

    var startDatePicker: some View {
        DatePicker(
            "Start Date",
            selection: Binding(
                get: { experience.startDate ?? Date() },
                set: { experience.startDate = $0 }
            ),
            displayedComponents: .date
        )
    }

    var endDatePicker: some View {
        DatePicker(
            "End Date",
            selection: Binding(
                get: { experience.endDate ?? Date() },
                set: { experience.endDate = $0 }
            ),
            displayedComponents: .date
        )
    }

    var currentPositionToggle: some View {
        Toggle("Current Position", isOn: $experience.isCurrentPosition)
    }

    var descriptionEditor: some View {
        TextEditor(text: $experience.description)
            .textEditorStyle(.plain)
            .frame(minHeight: 60)
    }

    var addButtonRow: some View {
        HStack(spacing: 20) {
            Spacer()
            addButton
        }
    }

    var addButton: some View {
        Button(action: add) {
            Text("Add")
        }
        .disabled(experience.position.isEmpty)
    }

    // MARK: - Private Action Functions

    private func add() {
        resume.add(experience: experience)
        experience = WorkExperience.empty
    }
}

#Preview {
    WorkExperienceForm()
        .environment(Resume.mock)
}
