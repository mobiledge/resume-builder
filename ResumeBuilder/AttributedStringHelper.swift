import Foundation
import AppKit

public class AttributedStringHelper {

    /// Creates an attributed string representation of a PersonalInfo object
    /// - Parameter personalInfo: The PersonalInfo object to convert
    /// - Returns: An NSAttributedString formatted with the person's information
    public static func createAttributedString(from personalInfo: PersonalInfo) -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Create centered paragraph style
        let centerParagraphStyle = NSMutableParagraphStyle()
        centerParagraphStyle.alignment = .center

        // Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: NSColor.black,
            .paragraphStyle: centerParagraphStyle
        ]
        result.append(NSAttributedString(string: personalInfo.fullName, attributes: nameAttributes))
        result.append(NSAttributedString(string: "\n"))

        // Contact Information
        let contactAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: NSColor.darkGray,
            .paragraphStyle: centerParagraphStyle
        ]

        // Address
        if let address = personalInfo.address {
            result.append(NSAttributedString(string: address.formattedAddress, attributes: contactAttributes))
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
        }
        result.append(NSAttributedString(string: personalInfo.email, attributes: contactAttributes))
        result.append(NSAttributedString(string: " • ", attributes: contactAttributes))
        result.append(NSAttributedString(string: personalInfo.phone, attributes: contactAttributes))

        // Online Profiles
        let onlineProfilesAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: NSColor.systemBlue,
            .paragraphStyle: centerParagraphStyle
        ]

        if let linkedIn = personalInfo.linkedIn, !linkedIn.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: "LinkedIn: \(linkedIn)", attributes: onlineProfilesAttributes))
        }

        if let portfolio = personalInfo.portfolio, !portfolio.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: "Portfolio: \(portfolio)", attributes: onlineProfilesAttributes))
        }

        if let github = personalInfo.github, !github.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: "GitHub: \(github)", attributes: onlineProfilesAttributes))
        }

        return result
    }
}

// MARK: - PersonalInfo Extension
public extension PersonalInfo {
    /// Creates an attributed string representation of this PersonalInfo object
    /// - Returns: An NSAttributedString formatted with the person's information
    func attributedString() -> NSAttributedString {
        return AttributedStringHelper.createAttributedString(from: self)
    }
}
