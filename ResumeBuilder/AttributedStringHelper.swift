import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

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
            .font: Font.title.weight(.bold).asNativeFont(),
            .foregroundColor: Color.black.asNativeColor(),
            .paragraphStyle: centerParagraphStyle
        ]
        result.append(NSAttributedString(string: personalInfo.fullName, attributes: nameAttributes))
        result.append(NSAttributedString(string: "\n"))

        // Contact Information
        let contactAttributes: [NSAttributedString.Key: Any] = [
            .font: Font.footnote.asNativeFont(),
            .foregroundColor: Color.gray.asNativeColor(),
            .paragraphStyle: centerParagraphStyle
        ]

        result.append(NSAttributedString(string: personalInfo.email, attributes: contactAttributes))
        result.append(NSAttributedString(string: " • ", attributes: contactAttributes))
        result.append(NSAttributedString(string: personalInfo.phone, attributes: contactAttributes))

        // Address
        if let address = personalInfo.address {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: address.formattedAddress, attributes: contactAttributes))
        }

        // Online Profiles
        let onlineProfilesAttributes: [NSAttributedString.Key: Any] = [
            .font: Font.footnote.asNativeFont(),
            .foregroundColor: Color.blue.asNativeColor(),
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

// MARK: - Font and Color Extensions

// SwiftUI.Font to platform-specific font conversion
extension Font {
    func asNativeFont(size: CGFloat? = nil) -> Any {
        #if canImport(UIKit)
        return self.asUIFont(size: size)
        #elseif canImport(AppKit)
        return self.asNSFont(size: size)
        #endif
    }

    #if canImport(UIKit)
    func asUIFont(size: CGFloat? = nil) -> UIFont {
        switch self {
        case .largeTitle:
            return UIFont.systemFont(ofSize: size ?? 34, weight: .regular)
        case .title:
            return UIFont.systemFont(ofSize: size ?? 24, weight: .regular)
        case .title2:
            return UIFont.systemFont(ofSize: size ?? 22, weight: .regular)
        case .title3:
            return UIFont.systemFont(ofSize: size ?? 20, weight: .regular)
        case .headline:
            return UIFont.systemFont(ofSize: size ?? 17, weight: .semibold)
        case .body:
            return UIFont.systemFont(ofSize: size ?? 17, weight: .regular)
        case .callout:
            return UIFont.systemFont(ofSize: size ?? 16, weight: .regular)
        case .subheadline:
            return UIFont.systemFont(ofSize: size ?? 15, weight: .regular)
        case .footnote:
            return UIFont.systemFont(ofSize: size ?? 13, weight: .regular)
        case .caption:
            return UIFont.systemFont(ofSize: size ?? 12, weight: .regular)
        case .caption2:
            return UIFont.systemFont(ofSize: size ?? 11, weight: .regular)
        default:
            return UIFont.systemFont(ofSize: size ?? 17, weight: .regular)
        }
    }
    #elseif canImport(AppKit)
    func asNSFont(size: CGFloat? = nil) -> NSFont {
        switch self {
        case .largeTitle:
            return NSFont.systemFont(ofSize: size ?? 34, weight: .regular)
        case .title:
            return NSFont.systemFont(ofSize: size ?? 24, weight: .regular)
        case .title2:
            return NSFont.systemFont(ofSize: size ?? 22, weight: .regular)
        case .title3:
            return NSFont.systemFont(ofSize: size ?? 20, weight: .regular)
        case .headline:
            return NSFont.systemFont(ofSize: size ?? 17, weight: .semibold)
        case .body:
            return NSFont.systemFont(ofSize: size ?? 17, weight: .regular)
        case .callout:
            return NSFont.systemFont(ofSize: size ?? 16, weight: .regular)
        case .subheadline:
            return NSFont.systemFont(ofSize: size ?? 15, weight: .regular)
        case .footnote:
            return NSFont.systemFont(ofSize: size ?? 13, weight: .regular)
        case .caption:
            return NSFont.systemFont(ofSize: size ?? 12, weight: .regular)
        case .caption2:
            return NSFont.systemFont(ofSize: size ?? 11, weight: .regular)
        default:
            return NSFont.systemFont(ofSize: size ?? 17, weight: .regular)
        }
    }
    #endif
}

// Handle font weights
extension Font.Weight {
    #if canImport(UIKit)
    var uiFontWeight: UIFont.Weight {
        switch self {
        case .black: return .black
        case .bold: return .bold
        case .heavy: return .heavy
        case .light: return .light
        case .medium: return .medium
        case .regular: return .regular
        case .semibold: return .semibold
        case .thin: return .thin
        case .ultraLight: return .ultraLight
        default: return .regular
        }
    }
    #elseif canImport(AppKit)
    var nsFontWeight: NSFont.Weight {
        switch self {
        case .black: return .black
        case .bold: return .bold
        case .heavy: return .heavy
        case .light: return .light
        case .medium: return .medium
        case .regular: return .regular
        case .semibold: return .semibold
        case .thin: return .thin
        case .ultraLight: return .ultraLight
        default: return .regular
        }
    }
    #endif
}

// SwiftUI.Color to platform-specific color conversion
extension Color {
    func asNativeColor() -> Any {
        #if canImport(UIKit)
        return self.asUIColor()
        #elseif canImport(AppKit)
        return self.asNSColor()
        #endif
    }

    #if canImport(UIKit)
    func asUIColor() -> UIColor {
        // For standard colors, return the UIKit equivalent directly
        if self == .black { return .black }
        if self == .blue { return .systemBlue }
        if self == .gray { return .darkGray }
        if self == .green { return .systemGreen }
        if self == .orange { return .systemOrange }
        if self == .pink { return .systemPink }
        if self == .purple { return .systemPurple }
        if self == .red { return .systemRed }
        if self == .white { return .white }
        if self == .yellow { return .systemYellow }

        // For custom colors, use UIColor from SwiftUI Color
        return UIColor(self)
    }
    #elseif canImport(AppKit)
    func asNSColor() -> NSColor {
        // For standard colors, return the AppKit equivalent directly
        if self == .black { return .black }
        if self == .blue { return .systemBlue }
        if self == .gray { return .darkGray }
        if self == .green { return .systemGreen }
        if self == .orange { return .systemOrange }
        if self == .pink { return .systemPink }
        if self == .purple { return .systemPurple }
        if self == .red { return .systemRed }
        if self == .white { return .white }
        if self == .yellow { return .systemYellow }

        // For custom colors, use NSColor from SwiftUI Color
        return NSColor(self)
    }
    #endif
}

// MARK: - PersonalInfo Extension
public extension PersonalInfo {
    /// Creates an attributed string representation of this PersonalInfo object
    /// - Returns: An NSAttributedString formatted with the person's information
    func attributedString() -> NSAttributedString {
        return AttributedStringHelper.createAttributedString(from: self)
    }
}
