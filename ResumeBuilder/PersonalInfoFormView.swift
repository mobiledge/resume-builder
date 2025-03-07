import SwiftUI

struct PersonalInfoFormView: View {
    @Binding var personalInfo: PersonalInfo
    @State private var hasAddress: Bool
    @State private var profileImageData: Data?
    @FocusState private var focusedField: FormField?

    enum FormField {
        case firstName, lastName, email, phone
        case street, city, state, zipCode, country
        case linkedIn, portfolio, github
    }

    init(personalInfo: Binding<PersonalInfo>) {
        self._personalInfo = personalInfo
        self._hasAddress = State(initialValue: personalInfo.wrappedValue.address != nil)
    }

    var body: some View {
        Form {
            profilePictureSection

            Section(header: Text("Basic Information")) {
                TextField("First Name", text: $personalInfo.firstName)
                    .focused($focusedField, equals: .firstName)
                    #if os(iOS) || os(macOS)
                    .textContentType(.givenName)
                    #endif

                TextField("Last Name", text: $personalInfo.lastName)
                    .focused($focusedField, equals: .lastName)
                    #if os(iOS) || os(macOS)
                    .textContentType(.familyName)
                    #endif

                TextField("Email", text: $personalInfo.email)
                    .focused($focusedField, equals: .email)
                    #if os(iOS) || os(macOS)
                    .textContentType(.emailAddress)
//                    .keyboardType(.emailAddress)
                    #endif
                    #if os(iOS)
                    .autocapitalization(.none)
                    #endif

                TextField("Phone", text: $personalInfo.phone)
                    .focused($focusedField, equals: .phone)
                    #if os(iOS) || os(macOS)
                    .textContentType(.telephoneNumber)
                    #endif
                    #if os(iOS)
                    .keyboardType(.phonePad)
                    #endif
            }

            addressSection

            Section(header: Text("Professional Links")) {
                HStack {
                    Image(systemName: "link")
                    TextField("LinkedIn", text: Binding(
                        get: { personalInfo.linkedIn ?? "" },
                        set: { personalInfo.linkedIn = $0.isEmpty ? nil : $0 }
                    ))
                    .focused($focusedField, equals: .linkedIn)
                    #if os(iOS)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    #endif
                }

                HStack {
                    Image(systemName: "globe")
                    TextField("Portfolio", text: Binding(
                        get: { personalInfo.portfolio ?? "" },
                        set: { personalInfo.portfolio = $0.isEmpty ? nil : $0 }
                    ))
                    .focused($focusedField, equals: .portfolio)
                    #if os(iOS)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    #endif
                }

                HStack {
                    Image(systemName: "terminal")
                    TextField("GitHub", text: Binding(
                        get: { personalInfo.github ?? "" },
                        set: { personalInfo.github = $0.isEmpty ? nil : $0 }
                    ))
                    .focused($focusedField, equals: .github)
                    #if os(iOS)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    #endif
                }
            }
        }
        .navigationTitle("Personal Information")
        #if os(iOS)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
        }
        #endif
    }

    // MARK: - Profile Picture Section

    private var profilePictureSection: some View {
        Section(header: Text("Profile Picture")) {
            HStack {
                profileImageView
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.trailing)

                #if os(iOS) || os(macOS)
                profileImagePicker
                #else
                Text("Change photo in settings")
                    .foregroundColor(.secondary)
                #endif
            }
            .padding(.vertical, 8)
        }
    }

    private var profileImageView: some View {
        Group {
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
    }

    private var profileImage: Image? {
        if let profileImageData = profileImageData {
            #if os(iOS) || os(tvOS)
            if let uiImage = UIImage(data: profileImageData) {
                return Image(uiImage: uiImage)
            }
            #elseif os(macOS)
            if let nsImage = NSImage(data: profileImageData) {
                return Image(nsImage: nsImage)
            }
            #endif
        }

        return nil
    }

    private var profileImagePicker: some View {
        #if os(iOS)
        return Button("Select Photo") {
            // Open image picker based on platform
            // This would integrate with UIImagePickerController or PHPickerViewController
            // For brevity, implementation details omitted
        }
        .buttonStyle(.borderedProminent)
        #elseif os(macOS)
        return Button("Select Photo") {
            // Open NSOpenPanel for selecting images
            // For brevity, implementation details omitted
        }
        .buttonStyle(.borderedProminent)
        #endif
    }

    // MARK: - Address Section

    private var addressSection: some View {
        Section(header: Text("Address")) {
            Toggle("Has Address", isOn: $hasAddress)
                .onChange(of: hasAddress) { newValue in
                    if newValue && personalInfo.address == nil {
                        personalInfo.address = PersonalInfo.Address(
                            street: "", city: "", state: "", zipCode: "", country: ""
                        )
                    } else if !newValue {
                        personalInfo.address = nil
                    }
                }

            if hasAddress {
                TextField("Street", text: Binding(
                    get: { personalInfo.address?.street ?? "" },
                    set: { personalInfo.address?.street = $0 }
                ))
                .focused($focusedField, equals: .street)
                #if os(iOS) || os(macOS)
                .textContentType(.streetAddressLine1)
                #endif

                TextField("City", text: Binding(
                    get: { personalInfo.address?.city ?? "" },
                    set: { personalInfo.address?.city = $0 }
                ))
                .focused($focusedField, equals: .city)
                #if os(iOS) || os(macOS)
                .textContentType(.addressCity)
                #endif

                TextField("State", text: Binding(
                    get: { personalInfo.address?.state ?? "" },
                    set: { personalInfo.address?.state = $0 }
                ))
                .focused($focusedField, equals: .state)
                #if os(iOS) || os(macOS)
                .textContentType(.addressState)
                #endif

                TextField("Zip Code", text: Binding(
                    get: { personalInfo.address?.zipCode ?? "" },
                    set: { personalInfo.address?.zipCode = $0 }
                ))
                .focused($focusedField, equals: .zipCode)
                #if os(iOS) || os(macOS)
                .textContentType(.postalCode)
                #endif
                #if os(iOS)
                .keyboardType(.numberPad)
                #endif

                TextField("Country", text: Binding(
                    get: { personalInfo.address?.country ?? "" },
                    set: { personalInfo.address?.country = $0 }
                ))
                .focused($focusedField, equals: .country)
                #if os(iOS) || os(macOS)
                .textContentType(.countryName)
                #endif
            }
        }
    }
}

// MARK: - Preview Provider

struct PersonalInfoFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitView {
            Text("Sidebar")
        } content: {
            PersonalInfoFormView(personalInfo: .constant(PersonalInfo.mock))
        } detail: {
            Text("Detail")
        }
    }
}
