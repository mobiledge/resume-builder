//
//  PersonalInfoForm.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-04-16.
//

import SwiftUI

struct PersonalInfoForm: View {
    @Bindable var personalInfo: PersonalInfo
    @FocusState private var focusedField: FormField?

    enum FormField {
        case name, title, city, email, phone, summary
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

            Section("Summary") {
                TextEditor(text: $personalInfo.summary)
                    .focused($focusedField, equals: .summary)
                    .textEditorStyle(.plain)
            }
        }
        .formStyle(.grouped)
    }

}

#Preview {
    PersonalInfoForm(personalInfo: PersonalInfo.mock)
}
