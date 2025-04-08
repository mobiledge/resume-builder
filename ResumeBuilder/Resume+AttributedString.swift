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
}
extension Summary {
    var attributedText: NSAttributedString {
        NSAttributedString(string: text, attributes: attributes())
    }
}
extension WorkExperience {
    var attributedPosition: NSAttributedString {
        NSAttributedString(string: position, attributes: attributes(style: .headline))
    }
    var attributedCompanyName: NSAttributedString {
        NSAttributedString(string: companyName, attributes: attributes())
    }
    var attributedLocation: NSAttributedString {
        NSAttributedString(string: location, attributes: attributes(style: .subheadline, color: .secondaryLabelColor))
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
        return NSAttributedString(string: dateString, attributes: attributes(style: .subheadline, color: .secondaryLabelColor))
    }
    var attributedDescription: NSAttributedString {
        NSAttributedString(string: description, attributes: attributes())
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
