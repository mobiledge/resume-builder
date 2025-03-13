//
//  Untitled.swift
//
//
//  Created by Rabin Joshi on 2025-03-05.
//

import Foundation
import AppKit

// MARK: - Personal Information
@Observable class PersonalInfo: Codable {
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

    func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Create centered paragraph style
        let centerParagraphStyle = NSMutableParagraphStyle()
        centerParagraphStyle.alignment = .center

        // Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: NSColor.black,
            .paragraphStyle: centerParagraphStyle
        ]
        result.append(NSAttributedString(string: name, attributes: nameAttributes))


        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.preferredFont(forTextStyle: .subheadline),
            .foregroundColor: NSColor.black,
            .paragraphStyle: centerParagraphStyle
        ]
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: title, attributes: titleAttributes))

        // Contact Information
        let contactAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.preferredFont(forTextStyle: .caption1),
            .foregroundColor: NSColor.darkGray,
            .paragraphStyle: centerParagraphStyle
        ]

        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: city, attributes: contactAttributes))
        result.append(NSAttributedString(string: ", ", attributes: contactAttributes))
        result.append(NSAttributedString(string: state, attributes: contactAttributes))
        result.append(NSAttributedString(string: " · ", attributes: contactAttributes))
        result.append(NSAttributedString(string: email, attributes: contactAttributes))
        result.append(NSAttributedString(string: " · ", attributes: contactAttributes))
        result.append(NSAttributedString(string: phone, attributes: contactAttributes))


        // Online Profiles
        let onlineProfilesAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.preferredFont(forTextStyle: .caption1), //NSFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: NSColor.systemBlue,
            .paragraphStyle: centerParagraphStyle
        ]

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

// MARK: - Resume
/*
public struct Resume: Codable, Identifiable {
    public var id = UUID()
    public var personalInfo: PersonalInfo
    public var summary: String
    public var workExperience: [WorkExperience]
    public var education: [Education]
    public var skills: [Skill]
    public var certifications: [Certification]
    public var languages: [Language]
    public var projects: [Project]
    public var references: [Reference]
    public var additionalSections: [AdditionalSection]

    public init(personalInfo: PersonalInfo,
                summary: String = "",
                workExperience: [WorkExperience] = [],
                education: [Education] = [],
                skills: [Skill] = [],
                certifications: [Certification] = [],
                languages: [Language] = [],
                projects: [Project] = [],
                references: [Reference] = [],
                additionalSections: [AdditionalSection] = []) {
        self.personalInfo = personalInfo
        self.summary = summary
        self.workExperience = workExperience
        self.education = education
        self.skills = skills
        self.certifications = certifications
        self.languages = languages
        self.projects = projects
        self.references = references
        self.additionalSections = additionalSections
    }


    // MARK: - Work Experience
    public struct WorkExperience: Codable, Identifiable {
        public var id = UUID()
        public var companyName: String
        public var position: String
        public var location: String?
        public var startDate: Date
        public var endDate: Date?
        public var isCurrentPosition: Bool
        public var description: String
        public var achievements: [String]
        public var technologies: [String]?

        public var dateRange: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"

            let startString = dateFormatter.string(from: startDate)
            let endString = endDate != nil ? dateFormatter.string(from: endDate!) : "Present"

            return "\(startString) - \(endString)"
        }
    }

    // MARK: - Education
    public struct Education: Codable, Identifiable {
        public var id = UUID()
        public var institution: String
        public var degree: String
        public var fieldOfStudy: String
        public var location: String?
        public var startDate: Date
        public var endDate: Date?
        public var isCurrentlyEnrolled: Bool
        public var gpa: Double?
        public var relevantCourses: [String]?
        public var achievements: [String]?

        public var dateRange: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"

            let startString = dateFormatter.string(from: startDate)
            let endString = endDate != nil ? dateFormatter.string(from: endDate!) : "Present"

            return "\(startString) - \(endString)"
        }

        public var formattedGPA: String? {
            if let gpa = gpa {
                return String(format: "%.2f", gpa)
            }
            return nil
        }
    }

    // MARK: - Skills
    public struct Skill: Codable, Identifiable {
        public var id = UUID()
        public var name: String
        public var level: SkillLevel
        public var category: SkillCategory

        public enum SkillLevel: String, Codable, CaseIterable {
            case beginner = "Beginner"
            case intermediate = "Intermediate"
            case advanced = "Advanced"
            case expert = "Expert"
        }

        public enum SkillCategory: String, Codable, CaseIterable {
            case technical = "Technical"
            case softSkill = "Soft Skill"
            case language = "Language"
            case tool = "Tool"
            case other = "Other"
        }
    }

    // MARK: - Certifications
    public struct Certification: Codable, Identifiable {
        public var id = UUID()
        public var name: String
        public var issuingOrganization: String
        public var issueDate: Date
        public var expirationDate: Date?
        public var credentialID: String?
        public var credentialURL: URL?

        public var formattedIssueDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"
            return dateFormatter.string(from: issueDate)
        }

        public var formattedExpirationDate: String? {
            guard let expirationDate = expirationDate else { return nil }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"
            return dateFormatter.string(from: expirationDate)
        }

        public var isExpired: Bool {
            guard let expirationDate = expirationDate else { return false }
            return Date() > expirationDate
        }
    }

    // MARK: - Languages
    public struct Language: Codable, Identifiable {
        public var id = UUID()
        public var name: String
        public var proficiencyLevel: ProficiencyLevel

        public enum ProficiencyLevel: String, Codable, CaseIterable {
            case elementary = "Elementary"
            case limited = "Limited Working"
            case professional = "Professional Working"
            case fullProfessional = "Full Professional"
            case native = "Native/Bilingual"
        }
    }

    // MARK: - Projects
    public struct Project: Codable, Identifiable {
        public var id = UUID()
        public var name: String
        public var description: String
        public var startDate: Date?
        public var endDate: Date?
        public var url: URL?
        public var technologies: [String]?
        public var highlights: [String]?

        public var dateRange: String? {
            guard let startDate = startDate else { return nil }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"

            let startString = dateFormatter.string(from: startDate)
            let endString = endDate != nil ? dateFormatter.string(from: endDate!) : "Present"

            return "\(startString) - \(endString)"
        }
    }

    // MARK: - References
    public struct Reference: Codable, Identifiable {
        public var id = UUID()
        public var name: String
        public var company: String
        public var position: String
        public var email: String?
        public var phone: String?
        public var relationship: String
    }

    // MARK: - Additional Sections
    public struct AdditionalSection: Codable, Identifiable {
        public var id = UUID()
        public var title: String
        public var items: [String]
    }

    // MARK: - Helper Extensions
    public static var example: Resume {
        let personalInfo = PersonalInfo(
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

        let workExperiences = [
            WorkExperience(
                companyName: "Tech Solutions Inc.",
                position: "Senior iOS Developer",
                location: "San Francisco, CA",
                startDate: Calendar.current.date(from: DateComponents(year: 2020, month: 3))!,
                endDate: nil,
                isCurrentPosition: true,
                description: "Leading the development of mobile applications.",
                achievements: [
                    "Developed and launched 5 successful iOS apps",
                    "Improved app performance by 40%",
                    "Mentored junior developers"
                ],
                technologies: ["Swift", "SwiftUI", "Core Data", "Firebase"]
            ),
            WorkExperience(
                companyName: "Mobile Innovations LLC",
                position: "iOS Developer",
                location: "San Jose, CA",
                startDate: Calendar.current.date(from: DateComponents(year: 2018, month: 6))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2020, month: 2))!,
                isCurrentPosition: false,
                description: "Developed iOS applications for various clients.",
                achievements: [
                    "Collaborated on 10+ apps",
                    "Implemented CI/CD pipelines"
                ],
                technologies: ["Swift", "Objective-C", "UIKit"]
            )
        ]

        let education = [
            Education(
                institution: "University of California, Berkeley",
                degree: "Bachelor of Science",
                fieldOfStudy: "Computer Science",
                location: "Berkeley, CA",
                startDate: Calendar.current.date(from: DateComponents(year: 2014, month: 9))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2018, month: 5))!,
                isCurrentlyEnrolled: false,
                gpa: 3.8,
                relevantCourses: ["Data Structures", "Algorithms", "Mobile App Development"]
            )
        ]

        let skills = [
            Skill(name: "Swift", level: .expert, category: .technical),
            Skill(name: "SwiftUI", level: .advanced, category: .technical),
            Skill(name: "UIKit", level: .expert, category: .technical),
            Skill(name: "Problem Solving", level: .expert, category: .softSkill)
        ]

        let certifications = [
            Certification(
                name: "Apple Certified iOS Developer",
                issuingOrganization: "Apple",
                issueDate: Calendar.current.date(from: DateComponents(year: 2019, month: 4))!,
                credentialID: "ACID-12345"
            )
        ]

        let languages = [
            Language(name: "English", proficiencyLevel: .native),
            Language(name: "Spanish", proficiencyLevel: .professional)
        ]

        let projects = [
            Project(
                name: "Fitness Tracker",
                description: "A comprehensive fitness tracking app",
                startDate: Calendar.current.date(from: DateComponents(year: 2021, month: 1))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2021, month: 6))!,
                technologies: ["Swift", "HealthKit", "Core Data"],
                highlights: ["100K+ downloads", "4.8 star rating"]
            )
        ]

        return Resume(
            personalInfo: personalInfo,
            summary: "Experienced iOS developer with 5+ years creating innovative mobile solutions.",
            workExperience: workExperiences,
            education: education,
            skills: skills,
            certifications: certifications,
            languages: languages,
            projects: projects
        )
    }
}


*/
