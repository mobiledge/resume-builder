import SwiftUI

enum SectionHeaderStyle {
    case header(String)
    case subheader(String)
    case both(String, String)
    case none
}

struct SectionHeaderView: View {
    let style: SectionHeaderStyle

    var body: some View {
        switch style {
        case .header(let headerText):
            Text(headerText)
                .font(.title) // Increased header font size
                .fontWeight(.medium) // Add slight weight increase
                .padding(.vertical, 8) // Increased padding for larger font

        case .subheader(let subheaderText):
            Text(subheaderText)
                .font(.headline)
                .padding(.vertical, 8)

        case .both(let headerText, let subheaderText):
            VStack(alignment: .leading, spacing: 4) { // Increased spacing
                Text(headerText)
                    .font(.title) // Increased header font size
                    .fontWeight(.medium) // Add slight weight increase

                Text(subheaderText)
                    .font(.headline)
            }
            .padding(.vertical, 8) // Increased padding

        case .none:
            EmptyView()
        }
        // Consider uncommenting this if you consistently need full-width leading alignment
        // outside of standard List/Form headers.
        // .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview
struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Form {
                Section {
                    Text("This content belongs to the first section.")
                } header: {
                    SectionHeaderView(style: .header("Primary Section Header"))
                }

                Section {
                    Text("More content here, related to the subheader.")
                } header: {
                    SectionHeaderView(style: .subheader("Helpful Subheader Hint"))
                }

                Section {
                     Text("Content for the section with both titles.")
                } header: {
                    SectionHeaderView(style: .both("Main Title", "Detailed Explanation Below"))
                }

                Section {
                     Text("This section technically has no header view.")
                } header: {
                     SectionHeaderView(style: .none)
                     // Note: Form/List styling might still add default space here.
                }

                 Section("Standard Text Header") {
                     Text("For visual comparison of spacing.")
                 }
            }
            .formStyle(.grouped)
            .previewDisplayName("Form Preview")
        }
    }
}
