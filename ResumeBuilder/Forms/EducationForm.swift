import SwiftUI

struct EducationForm: View {

    @Environment(Resume.self) var resume

    var body: some View {

        Form {
            ForEach(resume.educationCollection.items) { edu in
                EducationSection(education: edu)
            }

            AddEducationSection()
        }
        .formStyle(.grouped)
    }
}

struct EducationSection: View {
    @Bindable var education: Education
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
            institutionField
            degreeField
            fieldOfStudyField
            locationField
            startDatePicker

            if education.endDate != nil {
                endDatePicker
            }

            currentlyStudyingToggle
            actionButtons
        } header: {
            if resume.canMoveUp(education: education) {
                SectionHeaderView(style: .subheader(education.degree))
            } else {
                SectionHeaderView(style: .both("Education", education.degree))
            }
        }
    }

    var institutionField: some View {
        TextField("Institution", text: $education.institution)
    }

    var degreeField: some View {
        TextField("Degree", text: $education.degree)
    }

    var fieldOfStudyField: some View {
        TextField("Field of Study", text: $education.fieldOfStudy)
    }

    var locationField: some View {
        TextField("Location", text: $education.location)
    }

    var startDatePicker: some View {
        DatePicker(
            "Start Date",
            selection: $education.startDate,
            displayedComponents: .date
        )
    }

    var endDatePicker: some View {
        DatePicker(
            "End Date",
            selection: Binding(
                get: { education.endDate ?? Date() },
                set: { education.endDate = $0 }
            ),
            displayedComponents: .date
        )
    }

    var currentlyStudyingToggle: some View {
        Toggle("Currently Studying", isOn: Binding(
            get: { education.endDate == nil },
            set: { isCurrentlyStudying in
                education.endDate = isCurrentlyStudying ? nil : Date()
            }
        ))
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
        resume.moveDown(education: education)
    }

    private func canMoveDown() -> Bool {
        resume.canMoveDown(education: education)
    }

    private func moveUp() {
        resume.moveUp(education: education)
    }

    private func canMoveUp() -> Bool {
        resume.canMoveUp(education: education)
    }

    private func delete() {
        resume.delete(education: education)
    }
}

struct AddEducationSection: View {
    @Environment(Resume.self) private var resume
    @State private var education = Education.empty

    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        Section {
            institutionField
            degreeField
            fieldOfStudyField
            locationField
            startDatePicker

            if education.endDate != nil {
                endDatePicker
            }

            currentlyStudyingToggle
            addButtonRow
        } header: {
            if resume.educationCollection.items.isEmpty {
                SectionHeaderView(style: .both("Education", "Add New Education"))
            } else {
                SectionHeaderView(style: .subheader("Add New Education"))
            }
        }
    }

    var institutionField: some View {
        TextField("Institution", text: $education.institution)
    }

    var degreeField: some View {
        TextField("Degree", text: $education.degree)
    }

    var fieldOfStudyField: some View {
        TextField("Field of Study", text: $education.fieldOfStudy)
    }

    var locationField: some View {
        TextField("Location", text: $education.location)
    }

    var startDatePicker: some View {
        DatePicker(
            "Start Date",
            selection: $education.startDate,
            displayedComponents: .date
        )
    }

    var endDatePicker: some View {
        DatePicker(
            "End Date",
            selection: Binding(
                get: { education.endDate ?? Date() },
                set: { education.endDate = $0 }
            ),
            displayedComponents: .date
        )
    }

    var currentlyStudyingToggle: some View {
        Toggle("Currently Studying", isOn: Binding(
            get: { education.endDate == nil },
            set: { isCurrentlyStudying in
                education.endDate = isCurrentlyStudying ? nil : Date()
            }
        ))
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
        .disabled(education.degree.isEmpty)
    }


    // MARK: - Private Action Functions

    private func add() {
        resume.add(education: education)
        education = Education.empty
    }
}

#Preview {
    EducationForm()
        .environment(Resume.mock)
}
