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
        case name, title, location, email, phone, summary
    }

    var body: some View {
        Form {
            Section("Personal Information") {

                TextField(text: $personalInfo.name, prompt: Text("Enter Name")) {
                    Text("Name")
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                }
                .focused($focusedField, equals: .name)
                .textContentType(.name)

                TextField(text: $personalInfo.title, prompt: Text("Enter Title")) {
                    Text("Title")
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                }
                .focused($focusedField, equals: .title)
                .textContentType(.jobTitle)

                TextField(text: $personalInfo.location, prompt: Text("Location")) {
                    Text("Location")
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                }
                .focused($focusedField, equals: .location)
                .textContentType(.addressCity)

                TextField(text: $personalInfo.email, prompt: Text("Email")) {
                    Text("Email")
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                }
                .focused($focusedField, equals: .email)
                .textContentType(.emailAddress)

                TextField(text: $personalInfo.phone, prompt: Text("Phone")) {
                    Text("Phone")
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                }
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
