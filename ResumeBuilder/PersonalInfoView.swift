import SwiftUI

struct PersonalInfoView: View {
    @Binding var personalInfo: PersonalInfo
    @FocusState private var focusedField: FormField?

    enum FormField {
        case name, title, city, email, phone
    }

    init(personalInfo: Binding<PersonalInfo>) {
        self._personalInfo = personalInfo
    }

    var body: some View {
        Form {
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
        .formStyle(.grouped)
    }

}

#Preview {
    PersonalInfoView(personalInfo: .constant(PersonalInfo.mock))
}
