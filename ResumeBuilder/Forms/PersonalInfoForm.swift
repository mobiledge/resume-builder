//
//  PersonalInfoForm.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-04-16.
//

import SwiftUI

struct PersonalInfoForm: View {

    @Environment(Resume.self) private var resume

    var body: some View {
        Form {
            PersonalInfoSection(personalInfo: resume.personalInfo)
            PersonalInfoSummarySection(personalInfo: resume.personalInfo)
        }
        .formStyle(.grouped)
    }

}

struct PersonalInfoSection: View {

    @Bindable var personalInfo: PersonalInfo
    @FocusState private var focusedField: FormField?

    enum FormField {
        case name, title, location, email, phone, summary
    }


    var body: some View {
        Section {

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
        } header: {
            SectionHeaderView(style: .header("Contact"))
        }
    }
}

struct PersonalInfoSummarySection: View {

    @Bindable var personalInfo: PersonalInfo

    var body: some View {
        Section {
            TextEditor(text: $personalInfo.summary)
                .textEditorStyle(.plain)
        } header: {
            SectionHeaderView(style: .header("Summary"))
        }
    }
}

#Preview {
    PersonalInfoForm()
        .environment(PersonalInfo.mock)
}
