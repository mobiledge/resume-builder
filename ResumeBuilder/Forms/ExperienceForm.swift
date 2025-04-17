import SwiftUI

struct WorkExperienceForm: View {

    @Bindable var col: WorkExperienceCollection

    var body: some View {

        Form {
            ForEach(col.items) { exp in
                WorkExperienceSection(experience: exp)
            }
        }
        .formStyle(.grouped)
    }
}

struct WorkExperienceSection: View {
    @Bindable var experience: WorkExperience

    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {

        Section(experience.companyName) {
            TextField("Company Name", text: $experience.companyName)

            TextField("Position", text: $experience.position)

            TextField("Location", text: $experience.location)

            DatePicker(
                "Start Date",
                selection: Binding(
                    get: { experience.startDate ?? Date() },
                    set: { experience.startDate = $0 }
                ),
                displayedComponents: .date
            )

            Toggle("Current Position", isOn: $experience.isCurrentPosition)

            if !experience.isCurrentPosition {
                DatePicker(
                    "End Date",
                    selection: Binding(
                        get: { experience.endDate ?? Date() },
                        set: { experience.endDate = $0 }
                    ),
                    displayedComponents: .date
                )
            }

            TextEditor(text: $experience.description)
                .textEditorStyle(.plain)
                .frame(minHeight: 60)
        }
    }
}

#Preview {
    WorkExperienceForm(col: WorkExperienceCollection.mock)
}

