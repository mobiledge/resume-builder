import SwiftUI

struct PersonalInfoForm: View {
    @Binding var personalInfo: PersonalInfo
    @State private var showingSaveConfirmation = false

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("Full Name").font(.subheadline).foregroundColor(.secondary)
                    TextField("Full Name", text: $personalInfo.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.vertical, 4)

                VStack(alignment: .leading) {
                    Text("Email").font(.subheadline).foregroundColor(.secondary)
                    TextField("Email", text: $personalInfo.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                .padding(.vertical, 4)

                VStack(alignment: .leading) {
                    Text("Phone").font(.subheadline).foregroundColor(.secondary)
                    TextField("Phone", text: $personalInfo.phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                }
                .padding(.vertical, 4)

                VStack(alignment: .leading) {
                    Text("City").font(.subheadline).foregroundColor(.secondary)
                    TextField("City", text: $personalInfo.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.vertical, 4)

                HStack {
                    VStack(alignment: .leading) {
                        Text("State/Province").font(.subheadline).foregroundColor(.secondary)
                        TextField("State/Province", text: $personalInfo.state)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    VStack(alignment: .leading) {
                        Text("Country").font(.subheadline).foregroundColor(.secondary)
                        TextField("Country", text: $personalInfo.country)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.vertical, 4)

                VStack(alignment: .leading) {
                    Text("LinkedIn").font(.subheadline).foregroundColor(.secondary)
                    TextField("LinkedIn URL", text: Binding(
                        get: { personalInfo.linkedIn ?? "" },
                        set: { personalInfo.linkedIn = $0.isEmpty ? nil : $0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                }
                .padding(.vertical, 4)

                VStack(alignment: .leading) {
                    Text("Portfolio").font(.subheadline).foregroundColor(.secondary)
                    TextField("Portfolio URL", text: Binding(
                        get: { personalInfo.portfolio ?? "" },
                        set: { personalInfo.portfolio = $0.isEmpty ? nil : $0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                }
                .padding(.vertical, 4)

                VStack(alignment: .leading) {
                    Text("GitHub").font(.subheadline).foregroundColor(.secondary)
                    TextField("GitHub URL", text: Binding(
                        get: { personalInfo.github ?? "" },
                        set: { personalInfo.github = $0.isEmpty ? nil : $0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                }
                .padding(.vertical, 4)

                HStack {
                    Spacer()
                    Button("Save") {
                        // Here you would implement saving functionality
                        showingSaveConfirmation = true
                    }
                    .keyboardShortcut(.return, modifiers: .command)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
        .padding()
        .frame(minWidth: 600, idealWidth: 700, maxWidth: .infinity, minHeight: 600, idealHeight: 700, maxHeight: .infinity)
        .alert("Information Saved", isPresented: $showingSaveConfirmation) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your personal information has been saved successfully.")
        }
    }
}

// MARK: - Preview
struct PersonalInfoForm_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoForm(personalInfo: .constant(PersonalInfo.mock))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
            .padding()
            .frame(width: 700, height: 700)
    }
}
