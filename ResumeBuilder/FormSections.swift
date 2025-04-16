import SwiftUI

struct PersonalInfoSection: View {
    @Binding var personalInfo: PersonalInfo
    @FocusState private var focusedField: FormField?

    enum FormField {
        case name, title, city, email, phone
    }

    init(personalInfo: Binding<PersonalInfo>) {
        self._personalInfo = personalInfo
    }

    var body: some View {
        Section("Personal Information") {
            TextField("Name", text: $personalInfo.name)
                .focused($focusedField, equals: .name)
                .textContentType(.name)

            TextField("Title", text: $personalInfo.title)
                .focused($focusedField, equals: .title)
                .textContentType(.jobTitle)

            TextField("Location", text: $personalInfo.location)
                .focused($focusedField, equals: .city)
                .textContentType(.addressCity)

            TextField("Email", text: $personalInfo.email)
                .focused($focusedField, equals: .email)
                .textContentType(.emailAddress)

            TextField("Phone", text: $personalInfo.phone)
                .focused($focusedField, equals: .phone)
                .textContentType(.telephoneNumber)
        }
    }

}

#Preview("PersonalInfoSection") {
    Form {
        PersonalInfoSection(personalInfo: .constant(PersonalInfo.mock))
    }
    .formStyle(.grouped)
}


struct WorkExperienceSection: View {
    @Binding var workExperience: WorkExperience
    @FocusState private var focusedField: FormField?
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false

    enum FormField {
        case companyName, position, location, description
    }

    init(workExperience: Binding<WorkExperience>) {
        self._workExperience = workExperience
    }

    var body: some View {
        Section("Work Experience") {
            TextField("Company Name", text: $workExperience.companyName)
                .focused($focusedField, equals: .companyName)
                .textContentType(.organizationName)

            TextField("Position", text: $workExperience.position)
                .focused($focusedField, equals: .position)
                .textContentType(.jobTitle)

            TextField("Location", text: $workExperience.location)
                .focused($focusedField, equals: .location)
                .textContentType(.location)

            // Date picker for start date
            HStack {
                Text("Start Date")
                Spacer()
                Text(formattedDate(workExperience.startDate))
                    .foregroundColor(.secondary)
                Button(action: {
                    showStartDatePicker.toggle()
                }) {
                    Image(systemName: "calendar")
                }
            }

            if showStartDatePicker {
                DatePicker("", selection: Binding(
                    get: { workExperience.startDate ?? Date() },
                    set: { workExperience.startDate = $0 }
                ), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
            }

            // Toggle for current position
            Toggle("Current Position", isOn: $workExperience.isCurrentPosition)

            // Date picker for end date (only show if not current position)
            if !workExperience.isCurrentPosition {
                HStack {
                    Text("End Date")
                    Spacer()
                    Text(formattedDate(workExperience.endDate))
                        .foregroundColor(.secondary)
                    Button(action: {
                        showEndDatePicker.toggle()
                    }) {
                        Image(systemName: "calendar")
                    }
                }

                if showEndDatePicker {
                    DatePicker("", selection: Binding(
                        get: { workExperience.endDate ?? Date() },
                        set: { workExperience.endDate = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                }
            }

            // Description using TextEditor for multi-line input
            Text("Description").padding(.top, 4)
            TextEditor(text: $workExperience.description)
                .focused($focusedField, equals: .description)
                .frame(minHeight: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                )
        }
    }

    // Helper function to format dates
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "Not set" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview("WorkExperienceSection") {
    Form {
        WorkExperienceSection(workExperience: .constant(WorkExperience.mock))
    }
    .frame(width: 320)
}
