import SwiftUI

struct PersonalInfoForm: View {
    @Binding var personalInfo: PersonalInfo
    @FocusState private var focusedField: FormField?

    enum FormField {
        case name, title, city, state, zipCode, country, email, phone, linkedIn, github
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

                TextField("City", text: $personalInfo.city)
                    .focused($focusedField, equals: .city)
                    .textContentType(.addressCity)

                TextField("State", text: $personalInfo.state)
                    .focused($focusedField, equals: .state)
                    .textContentType(.addressState)

                TextField("Country", text: $personalInfo.country)
                    .focused($focusedField, equals: .country)
                    .textContentType(.countryName)

                TextField("Email", text: $personalInfo.email)
                    .focused($focusedField, equals: .email)
                    .textContentType(.emailAddress)

                TextField("Phone", text: $personalInfo.phone)
                    .focused($focusedField, equals: .phone)
                    .textContentType(.telephoneNumber)

                TextField("LinkedIn", text:  $personalInfo.linkedIn)
                .focused($focusedField, equals: .linkedIn)
                .textContentType(.URL)

                TextField("GitHub", text: $personalInfo.github)
                .focused($focusedField, equals: .github)
                .textContentType(.URL)
            }
        }
        .padding()
        .frame(minWidth: 300)
        .navigationTitle("Personal Information")
    }
}

// MARK: - Preview Provider

struct PersonalInfoFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitView {
            Text("Sidebar")
        } content: {
            PersonalInfoForm(personalInfo: .constant(PersonalInfo.mock))
        } detail: {
            Text("Detail")
        }
    }
}
