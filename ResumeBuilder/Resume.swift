//
//  State.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-13.
//

import Foundation
import PDFKit

@Observable class Resume {
    var personalInfo = PersonalInfo.mock
    var summary = Summary.mock
    var workExp = WorkExperience.mock

    var attributedString: NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(personalInfo.attributedString)
        result.append(NSAttributedString(string: "\n\n"))
        result.append(summary.attributedString)
        result.append(NSAttributedString(string: "\n\n"))
        result.append(workExp.attributedString)
        return result
    }

    var pdfDocument: PDFDocument {
        PDFDocument(attributedString: attributedString) ?? PDFDocument()
    }
}

// MARK: - Personal Information
@Observable class PersonalInfo {
    var name: String = ""
    var title: String = ""
    var city: String = ""
    var state: String = ""
    var country: String = ""
    var email: String = ""
    var phone: String = ""
    var linkedIn: String = ""
    var github: String = ""

    internal init(
        name: String = "",
        title: String = "",
        city: String = "",
        state: String = "",
        country: String = "",
        email: String = "",
        phone: String = "",
        linkedIn: String = "",
        github: String = ""
    ) {
        self.name = name
        self.title = title
        self.city = city
        self.state = state
        self.country = country
        self.email = email
        self.phone = phone
        self.linkedIn = linkedIn
        self.github = github
    }


    static var mock: PersonalInfo = PersonalInfo(
        name: "John Doe",
        title: "Software Developer",
        city: "San Francisco",
        state: "CA",
        country: "USA",
        email: "john.doe@example.com",
        phone: "555-123-4567",
        linkedIn: "linkedin.com/in/johndoe",
        github: "github.com/johndoe"
    )

    var attributedString: NSAttributedString {
        let result = NSMutableAttributedString()

        // Name
        result.append(NSAttributedString(string: name, attributes: attributes(style: .headline, alignment: .center)))

        // Title
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: title, attributes: attributes(style: .subheadline, alignment: .center)))

        // Contact Information
        let contactAttributes = attributes(style: .caption1, color: NSColor.darkGray, alignment: .center)

        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: city, attributes: contactAttributes))
        result.append(NSAttributedString(string: ", ", attributes: contactAttributes))
        result.append(NSAttributedString(string: state, attributes: contactAttributes))
        result.append(NSAttributedString(string: " · ", attributes: contactAttributes))
        result.append(NSAttributedString(string: email, attributes: contactAttributes))
        result.append(NSAttributedString(string: " · ", attributes: contactAttributes))
        result.append(NSAttributedString(string: phone, attributes: contactAttributes))

        // Online Profiles
        let onlineProfilesAttributes = attributes(style: .caption1, color: NSColor.systemBlue, alignment: .center)

        if !linkedIn.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: linkedIn, attributes: onlineProfilesAttributes))
        }

        if !github.isEmpty {
            result.append(NSAttributedString(string: " · ", attributes: contactAttributes))
            result.append(NSAttributedString(string: github, attributes: onlineProfilesAttributes))
        }

        return result
    }
}

// MARK: - Summary
@Observable class Summary {

    var text: String

    internal init(text: String) {
        self.text = text
    }

    static let mock = Summary(text:"Senior Software Developer with 10+ years of experience architecting scalable applications and leading high-performance engineering teams. Expertise in full-stack development, cloud infrastructure, and delivering enterprise solutions that drive business growth.")

    var attributedString: NSAttributedString {
        return NSAttributedString(string: text, attributes: attributes(style: .body))
    }
}

// MARK: - Work Experience
@Observable class WorkExperience {
    var companyName: String = ""
    var position: String = ""
    var location: String = ""
    var startDate: Date? = nil
    var endDate: Date? = nil
    var isCurrentPosition: Bool = false
    var description: String = ""

    init(
        companyName: String,
        position: String,
        location: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
        isCurrentPosition: Bool = false,
        description: String = ""
    ) {
        self.companyName = companyName
        self.position = position
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.isCurrentPosition = isCurrentPosition
        self.description = description
    }

    static var mock: WorkExperience {
        let mockExperience = WorkExperience(
            companyName: "Apple Inc.",
            position: "iOS Developer",
            location: "Cupertino, CA",
            startDate: Calendar.current.date(from: DateComponents(year: 2020, month: 6, day: 1)),
            isCurrentPosition: true,
            description: "• Developed and maintained multiple iOS applications using Swift and UIKit\n• Collaborated with design and product teams to create intuitive user interfaces\n• Implemented new features and fixed bugs in existing applications"
        )
        return mockExperience
    }

    var attributedString: NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        let attributedString = NSMutableAttributedString()



        // Company name
        attributedString.append(
            NSAttributedString(
                string: companyName,
                attributes: attributes(style: .headline)
            )
        )

        // Position and location
        attributedString
            .append(
                NSAttributedString(
                    string: "\n\(position) - \(location)",
                    attributes: attributes(
                        style: .subheadline,
                        color: .secondaryLabelColor
                    )
                )
            )

        // Date range
        var dateString = ""
        if let start = startDate {
            dateString = dateFormatter.string(from: start)
            if isCurrentPosition {
                dateString += " - Present"
            } else if let end = endDate {
                dateString += " - " + dateFormatter.string(from: end)
            }
        }
        attributedString.append(
            NSAttributedString(
                string: "\n\(dateString)",
                attributes: attributes(
                    style: .subheadline,
                    color: .secondaryLabelColor
                )
            )
        )



        // Description
        if !description.isEmpty {
            attributedString.append(
                NSAttributedString(
                    string: "\n\(description)",
                    attributes: attributes(style: .body)
                )
            )
        }

        return attributedString
    }
}


// MARK: -
private func attributes(
    style: NSFont.TextStyle = NSFont.TextStyle.body,
    color: NSColor = NSColor.textColor,
    alignment: NSTextAlignment = .left
) -> [NSAttributedString.Key: Any] {

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment

    // Name
    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.preferredFont(forTextStyle: style),
        .foregroundColor: color,
        .paragraphStyle: paragraphStyle
    ]
    return attributes
}
