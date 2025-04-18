//
//  Resume+AttributedString.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-28.
//

import Foundation
import AppKit

extension PersonalInfo {
    var attributedname: NSAttributedString {
        return NSAttributedString(string: name, attributes: attributes())
    }
    var attributedtitle: NSAttributedString {
        return NSAttributedString(string: title, attributes: attributes())
    }
    var attributedcity: NSAttributedString {
        return NSAttributedString(string: location, attributes: attributes())
    }
    var attributedemail: NSAttributedString {
        return NSAttributedString(string: email, attributes: attributes())
    }
    var attributedphone: NSAttributedString {
        return NSAttributedString(string: phone, attributes: attributes())
    }
    var attributedSummaryHeader: NSAttributedString {
        NSAttributedString(string: "Summary", attributes: attributes(style: .title1))
    }
    var attributedSummary: NSAttributedString {
        return NSAttributedString(string: summary, attributes: attributes())
    }

}

extension SkillCollection {
    var attributedHeader: NSAttributedString {
        NSAttributedString(string: "Skills", attributes: attributes(style: .title1))
    }
    var attributedSkills: [NSAttributedString] {
        items.map { skill in
            let attr = NSMutableAttributedString()
            attr.append(skill.attributedCategory)
            attr.append(NSAttributedString(string: ": ", attributes: attributes(style: .headline)))
            attr.append(skill.attributedValues)
            return attr
        }
    }
}

extension Skill {
    var attributedCategory: NSAttributedString {
        NSAttributedString(string: category, attributes: attributes(style: .headline))
    }
    var attributedValues: NSAttributedString {
        NSAttributedString(string: values, attributes: attributes())
    }
}

extension WorkExperienceCollection {
    var attributedHeader: NSAttributedString {
        NSAttributedString(string: "Work Experience", attributes: attributes(style: .title1))
    }
}

extension WorkExperience {
    var attributedPosition: NSAttributedString {
        NSAttributedString(string: position, attributes: attributes(style: .headline))
    }
    var attributedCompanyName: NSAttributedString {
        NSAttributedString(string: companyName, attributes: attributes())
    }
    var attributedDate: NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        var dateString = ""
        if let start = startDate {
            dateString = dateFormatter.string(from: start)
            if isCurrentPosition {
                dateString += " - Present"
            } else if let end = endDate {
                dateString += " - " + dateFormatter.string(from: end)
            }
        }
        return NSAttributedString(string: dateString, attributes: attributes(style: .headline))
    }
    var attributedLocation: NSAttributedString {
        NSAttributedString(string: location, attributes: attributes())
    }
    var attributedDescription: NSAttributedString {
        NSAttributedString(string: description, attributes: attributes())
    }
}

extension EducationCollection {
    var attributedHeader: NSAttributedString {
        NSAttributedString(string: "Education", attributes: attributes(style: .title1))
    }
}

extension Education {
    var attributedDegree: NSAttributedString {
        NSAttributedString(string: degree, attributes: attributes(style: .headline))
    }
    var attributedInstitution: NSAttributedString {
        NSAttributedString(string: institution, attributes: attributes())
    }
    var attributedFieldOfStudy: NSAttributedString {
        NSAttributedString(string: fieldOfStudy, attributes: attributes())
    }
    var attributedDate: NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        var dateString = ""
        dateString = dateFormatter.string(from: startDate)
        if let end = endDate {
            dateString += " - " + dateFormatter.string(from: end)
        } else {
            dateString += " - Present"
        }
        return NSAttributedString(string: dateString, attributes: attributes(style: .headline))
    }
    var attributedLocation: NSAttributedString {
        NSAttributedString(string: location, attributes: attributes())
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
