//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {

    // US Letter dimensions in points
    private let usLetterWidth: CGFloat = 612
    private let usLetterHeight: CGFloat = 792

    @State var state = Resume()

    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
                .frame(minWidth: 200)
        } content: {
            Form {
                PersonalInfoSection(personalInfo: $state.personalInfo)
                SummarySection(summary: $state.summary)
                WorkExperienceSection(workExperience: $state.workExp)
            }
            .padding()
            .frame(minWidth: usLetterWidth, idealWidth: usLetterWidth)

        } detail: {
            PDFViewer(document: state.pdfDocument)
                .frame(minWidth: usLetterWidth, idealWidth: usLetterWidth)
        }
        .frame(minWidth: usLetterWidth * 2 + 200)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()

}


struct ContactFormView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showAlert: Bool = false
    @State private var isValid: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Your Details").font(.headline)) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
            }

            Section(header: Text("Message").font(.headline)) {
                TextEditor(text: $message)
                    .textEditorStyle(.automatic)
                    .frame(height: 120)

            }

            HStack {
                Spacer()
                Button(action: submitForm) {
                    Text("Send Message")
                        .frame(width: 150, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .disabled(!isValidForm())
            }
        }
        .formStyle(.grouped)
        .frame(width: 400)
    }

    private func submitForm() {
        if isValidForm() {
            showAlert = true
            resetForm()
        }
    }

    private func isValidForm() -> Bool {
        return !name.isEmpty && isValidEmail(email) && !message.isEmpty
    }

    private func validateForm() {
        isValid = isValidForm()
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }

    private func resetForm() {
        name = ""
        email = ""
        message = ""
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormView()
    }
}


struct SettingsFormView: View {
    // Form state variables
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = true
    @State private var theme: Int = 0

    // For dismissing the view if presented in sheet
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {

            Section {
                LabeledContent("Name") {
                    TextField("", text: $username)
                        .textFieldStyle(.roundedBorder)
                }
                LabeledContent("Role") {
                    TextField("", text: $username)
                        .textFieldStyle(.roundedBorder)
                }
            }


            Section(header: Text("Contact Details").font(.headline)) {
                LabeledContent("Street Address") {
                    TextField("", text: $username)
                        .textFieldStyle(.roundedBorder)
                }


                LabeledContent("Address") {
                    TextField("City", text: $username)
                        .textFieldStyle(.roundedBorder)

                    TextField("State", text: $username)
                        .textFieldStyle(.roundedBorder)
                }



                HStack {
                    LabeledContent("City") {
                        TextField("", text: $username)
                            .textFieldStyle(.roundedBorder)
                    }

                    LabeledContent("State") {
                        TextField("", text: $username)
                            .textFieldStyle(.roundedBorder)
                    }
                }

                LabeledContent("Country") {
                    TextField("", text: $username)
                        .textFieldStyle(.roundedBorder)
                }
            }

            Section {
                Toggle("Remember me", isOn: $rememberMe)

                Picker("Theme:", selection: $theme) {
                    Text("System").tag(0)
                    Text("Light").tag(1)
                    Text("Dark").tag(2)
                }
                .pickerStyle(.radioGroup)
            }

            HStack {
                Spacer()
                Button("Save") { saveSettings() }
                    .keyboardShortcut(.defaultAction)
                Button("Cancel", role: .cancel) { dismiss() }
            }
            .padding(.top)
        }
        .formStyle(.grouped)
        .padding()
        //        .frame(minWidth: 200, idealWidth: 2, maxWidth: 300)
        .navigationTitle("Settings")
    }

    private func saveSettings() {
        // Implement your save logic here
        print("Settings saved:")
        print("Username: \(username)")
        print("Remember me: \(rememberMe)")
        print("Theme: \(theme)")

        // Dismiss the view after saving
        dismiss()
    }
}

// Preview provider
struct SettingsFormView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsFormView()
    }
}
