import SwiftUI

struct PersonalInfoForm: View {
    @Bindable var personalInfo: PersonalInfo

    var body: some View {
        Form {
            Section(header: Text("Personal Details")) {
                TextField("Name", text: $personalInfo.name)
                TextField("Title", text: $personalInfo.title)
            }

            Section(header: Text("Location")) {
                TextField("City", text: $personalInfo.city)
                TextField("State/Province", text: $personalInfo.state)
                TextField("Country", text: $personalInfo.country)
            }

            Section(header: Text("Contact Information")) {
                TextField("Email", text: $personalInfo.email)
                    .textFieldStyle(PlainTextFieldStyle())
                TextField("Phone", text: $personalInfo.phone)
            }

            Section(header: Text("Online Profiles")) {
                TextField("LinkedIn", text: $personalInfo.linkedIn)
                TextField("GitHub", text: $personalInfo.github)
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    PersonalInfoForm(personalInfo: PersonalInfo.mock)
}
