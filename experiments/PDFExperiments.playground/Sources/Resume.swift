//
//  Untitled.swift
//
//
//  Created by Rabin Joshi on 2025-03-05.
//

import Foundation

// MARK: - Resume
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

    // MARK: - Personal Information
    public struct PersonalInfo: Codable {
        public var firstName: String
        public var lastName: String
        public var email: String
        public var phone: String
        public var address: Address?
        public var linkedIn: String?
        public var portfolio: String?
        public var github: String?
        public var profilePicture: URL?

        public var fullName: String {
            return "\(firstName) \(lastName)"
        }

        public struct Address: Codable {
            public var street: String
            public var city: String
            public var state: String
            public var zipCode: String
            public var country: String

            public var formattedAddress: String {
                return "\(street), \(city), \(state) \(zipCode), \(country)"
            }
        }
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
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "(123) 456-7890",
            address: PersonalInfo.Address(
                street: "123 Main St",
                city: "San Francisco",
                state: "CA",
                zipCode: "94105",
                country: "USA"
            ),
            linkedIn: "linkedin.com/in/johndoe",
            portfolio: "johndoe.com",
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

// MARK: - NSAttributedString Extensions
import UIKit

extension Resume.PersonalInfo {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: fullName, attributes: nameAttributes))
        result.append(NSAttributedString(string: "\n"))

        // Contact Information
        let contactAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]

        result.append(NSAttributedString(string: email, attributes: contactAttributes))
        result.append(NSAttributedString(string: " • ", attributes: contactAttributes))
        result.append(NSAttributedString(string: phone, attributes: contactAttributes))

        // Address
        if let address = address {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: address.formattedAddress, attributes: contactAttributes))
        }

        // Online Profiles
        let onlineProfilesAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.systemBlue
        ]

        if let linkedIn = linkedIn, !linkedIn.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: "LinkedIn: \(linkedIn)", attributes: onlineProfilesAttributes))
        }

        if let portfolio = portfolio, !portfolio.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: "Portfolio: \(portfolio)", attributes: onlineProfilesAttributes))
        }

        if let github = github, !github.isEmpty {
            result.append(NSAttributedString(string: "\n", attributes: contactAttributes))
            result.append(NSAttributedString(string: "GitHub: \(github)", attributes: onlineProfilesAttributes))
        }

        return result
    }
}

extension Resume.PersonalInfo.Address {
    public func attributedString() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        return NSAttributedString(string: formattedAddress, attributes: attributes)
    }
}

extension Resume.WorkExperience {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Position and Company
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: position, attributes: titleAttributes))
        result.append(NSAttributedString(string: " at ", attributes: [.font: UIFont.systemFont(ofSize: 16)]))
        result.append(NSAttributedString(string: companyName, attributes: titleAttributes))

        // Date Range
        let detailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        result.append(NSAttributedString(string: "\n\(dateRange)", attributes: detailAttributes))

        // Location
        if let location = location {
            result.append(NSAttributedString(string: " • \(location)", attributes: detailAttributes))
        }

        // Description
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: "\n\n\(description)", attributes: descriptionAttributes))

        // Achievements
        if !achievements.isEmpty {
            result.append(NSAttributedString(string: "\n\nAchievements:", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]))

            for achievement in achievements {
                result.append(NSAttributedString(string: "\n• \(achievement)", attributes: descriptionAttributes))
            }
        }

        // Technologies
        if let technologies = technologies, !technologies.isEmpty {
            result.append(NSAttributedString(string: "\n\nTechnologies: ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]))
            result.append(NSAttributedString(string: technologies.joined(separator: ", "), attributes: descriptionAttributes))
        }

        return result
    }
}

extension Resume.Education {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Degree and Institution
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: degree, attributes: titleAttributes))
        result.append(NSAttributedString(string: " in ", attributes: [.font: UIFont.systemFont(ofSize: 16)]))
        result.append(NSAttributedString(string: fieldOfStudy, attributes: titleAttributes))
        result.append(NSAttributedString(string: "\n", attributes: [.font: UIFont.systemFont(ofSize: 16)]))
        result.append(NSAttributedString(string: institution, attributes: titleAttributes))

        // Date Range
        let detailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        result.append(NSAttributedString(string: "\n\(dateRange)", attributes: detailAttributes))

        // Location
        if let location = location {
            result.append(NSAttributedString(string: " • \(location)", attributes: detailAttributes))
        }

        // GPA
        if let formattedGPA = formattedGPA {
            result.append(NSAttributedString(string: " • GPA: \(formattedGPA)", attributes: detailAttributes))
        }

        // Relevant Courses
        if let relevantCourses = relevantCourses, !relevantCourses.isEmpty {
            let coursesAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.black
            ]
            result.append(NSAttributedString(string: "\n\nRelevant Courses: ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]))
            result.append(NSAttributedString(string: relevantCourses.joined(separator: ", "), attributes: coursesAttributes))
        }

        // Achievements
        if let achievements = achievements, !achievements.isEmpty {
            let achievementsAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.black
            ]
            result.append(NSAttributedString(string: "\n\nAchievements:", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]))

            for achievement in achievements {
                result.append(NSAttributedString(string: "\n• \(achievement)", attributes: achievementsAttributes))
            }
        }

        return result
    }
}

extension Resume.Skill {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Skill Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: name, attributes: nameAttributes))

        // Level and Category
        let detailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        result.append(NSAttributedString(string: " (\(level.rawValue)", attributes: detailAttributes))
        result.append(NSAttributedString(string: " - \(category.rawValue))", attributes: detailAttributes))

        return result
    }
}

extension Resume.Certification {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Certification Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: name, attributes: nameAttributes))

        // Organization
        let detailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        result.append(NSAttributedString(string: "\n\(issuingOrganization)", attributes: detailAttributes))

        // Date
        var dateString = " • \(formattedIssueDate)"
        if let expirationDate = formattedExpirationDate {
            dateString += " - \(expirationDate)"
        }
        result.append(NSAttributedString(string: dateString, attributes: detailAttributes))

        // Expired warning
        if isExpired {
            let warningAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.systemRed
            ]
            result.append(NSAttributedString(string: " (Expired)", attributes: warningAttributes))
        }

        // Credential ID
        if let credentialID = credentialID {
            result.append(NSAttributedString(string: "\nID: \(credentialID)", attributes: detailAttributes))
        }

        return result
    }
}

extension Resume.Language {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Language Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: name, attributes: nameAttributes))

        // Proficiency Level
        let levelAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        result.append(NSAttributedString(string: " (\(proficiencyLevel.rawValue))", attributes: levelAttributes))

        return result
    }
}

extension Resume.Project {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Project Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: name, attributes: nameAttributes))

        // Date Range
        let detailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        if let dateRange = dateRange {
            result.append(NSAttributedString(string: "\n\(dateRange)", attributes: detailAttributes))
        }

        // Description
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: "\n\n\(description)", attributes: descriptionAttributes))

        // URL
        if let url = url {
            let urlAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            result.append(NSAttributedString(string: "\n\(url.absoluteString)", attributes: urlAttributes))
        }

        // Technologies
        if let technologies = technologies, !technologies.isEmpty {
            result.append(NSAttributedString(string: "\n\nTechnologies: ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]))
            result.append(NSAttributedString(string: technologies.joined(separator: ", "), attributes: descriptionAttributes))
        }

        // Highlights
        if let highlights = highlights, !highlights.isEmpty {
            result.append(NSAttributedString(string: "\n\nHighlights:", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]))

            for highlight in highlights {
                result.append(NSAttributedString(string: "\n• \(highlight)", attributes: descriptionAttributes))
            }
        }

        return result
    }
}

extension Resume.Reference {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Reference Name
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: name, attributes: nameAttributes))

        // Position and Company
        let positionAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: "\n\(position) at \(company)", attributes: positionAttributes))

        // Relationship
        let detailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ]
        result.append(NSAttributedString(string: "\nRelationship: \(relationship)", attributes: detailAttributes))

        // Contact Information
        if let email = email {
            result.append(NSAttributedString(string: "\nEmail: \(email)", attributes: detailAttributes))
        }

        if let phone = phone {
            result.append(NSAttributedString(string: "\nPhone: \(phone)", attributes: detailAttributes))
        }

        return result
    }
}

extension Resume.AdditionalSection {
    public func attributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()

        // Section Title
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        result.append(NSAttributedString(string: title, attributes: titleAttributes))

        // Items
        let itemAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        for item in items {
            result.append(NSAttributedString(string: "\n• \(item)", attributes: itemAttributes))
        }

        return result
    }
}

public extension Resume {
    func attributedString() -> [NSAttributedString] {
        var result = [NSAttributedString]()

        // Personal Information
        result.append(personalInfo.attributedString())
        result.append(NSAttributedString(string: "\n\n"))

        // Summary
        let sectionTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        let sectionContentAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        result.append(NSAttributedString(string: "SUMMARY", attributes: sectionTitleAttributes))
        result.append(NSAttributedString(string: "\n\(summary)", attributes: sectionContentAttributes))
        result.append(NSAttributedString(string: "\n\n"))

        // Work Experience
        if !workExperience.isEmpty {
            result.append(NSAttributedString(string: "WORK EXPERIENCE", attributes: sectionTitleAttributes))

            for (index, experience) in workExperience.enumerated() {
                result.append(NSAttributedString(string: "\n\n"))
                result.append(experience.attributedString())

                if index < workExperience.count - 1 {
                    result.append(NSAttributedString(string: "\n\n"))
                    result.append(NSAttributedString(string: "--------------------"))
                }
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // Education
        if !education.isEmpty {
            result.append(NSAttributedString(string: "EDUCATION", attributes: sectionTitleAttributes))

            for (index, edu) in education.enumerated() {
                result.append(NSAttributedString(string: "\n\n"))
                result.append(edu.attributedString())

                if index < education.count - 1 {
                    result.append(NSAttributedString(string: "\n\n"))
                    result.append(NSAttributedString(string: "--------------------"))
                }
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // Skills
        if !skills.isEmpty {
            result.append(NSAttributedString(string: "SKILLS", attributes: sectionTitleAttributes))

            for (index, skill) in skills.enumerated() {
                result.append(NSAttributedString(string: "\n• "))
                result.append(skill.attributedString())
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // Certifications
        if !certifications.isEmpty {
            result.append(NSAttributedString(string: "CERTIFICATIONS", attributes: sectionTitleAttributes))

            for (index, certification) in certifications.enumerated() {
                result.append(NSAttributedString(string: "\n\n"))
                result.append(certification.attributedString())

                if index < certifications.count - 1 {
                    result.append(NSAttributedString(string: "\n\n"))
                    result.append(NSAttributedString(string: "--------------------"))
                }
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // Languages
        if !languages.isEmpty {
            result.append(NSAttributedString(string: "LANGUAGES", attributes: sectionTitleAttributes))
            result.append(NSAttributedString(string: "\n"))

            for (index, language) in languages.enumerated() {
                result.append(NSAttributedString(string: "\n• "))
                result.append(language.attributedString())
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // Projects
        if !projects.isEmpty {
            result.append(NSAttributedString(string: "PROJECTS", attributes: sectionTitleAttributes))

            for (index, project) in projects.enumerated() {
                result.append(NSAttributedString(string: "\n\n"))
                result.append(project.attributedString())

                if index < projects.count - 1 {
                    result.append(NSAttributedString(string: "\n\n"))
                    result.append(NSAttributedString(string: "--------------------"))
                }
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // References
        if !references.isEmpty {
            result.append(NSAttributedString(string: "REFERENCES", attributes: sectionTitleAttributes))

            for (index, reference) in references.enumerated() {
                result.append(NSAttributedString(string: "\n\n"))
                result.append(reference.attributedString())

                if index < references.count - 1 {
                    result.append(NSAttributedString(string: "\n\n"))
                    result.append(NSAttributedString(string: "--------------------"))
                }
            }

            result.append(NSAttributedString(string: "\n\n"))
        }

        // Additional Sections
        for (index, section) in additionalSections.enumerated() {
            result.append(NSAttributedString(string: section.title.uppercased(), attributes: sectionTitleAttributes))
            result.append(NSAttributedString(string: "\n"))
            result.append(section.attributedString())

            if index < additionalSections.count - 1 {
                result.append(NSAttributedString(string: "\n\n"))
            }
        }

        return result
    }
}

extension Resume {
    public static func sampleResume() -> Resume {
        // Personal Information
        let personalInfo = PersonalInfo(
            firstName: "Sarah",
            lastName: "Johnson",
            email: "sarah.johnson@example.com",
            phone: "(415) 555-1234",
            address: PersonalInfo.Address(
                street: "456 Tech Avenue",
                city: "San Francisco",
                state: "CA",
                zipCode: "94107",
                country: "USA"
            ),
            linkedIn: "linkedin.com/in/sarahjohnson",
            portfolio: "sarahjohnson.dev",
            github: "github.com/sarahjohnson"
        )

        // Work Experience
        let workExperiences = [
            WorkExperience(
                companyName: "Innovation Labs",
                position: "Senior Software Engineer",
                location: "San Francisco, CA",
                startDate: Calendar.current.date(from: DateComponents(year: 2021, month: 3))!,
                endDate: nil,
                isCurrentPosition: true,
                description: "Lead developer for cloud-based enterprise solutions focusing on scalability and security.",
                achievements: [
                    "Architected and implemented microservices architecture reducing system latency by 40%",
                    "Led a team of 5 engineers in delivering a major platform upgrade on time and under budget",
                    "Implemented CI/CD pipeline reducing deployment time from days to hours",
                    "Mentored junior developers through peer programming and code review sessions"
                ],
                technologies: ["Swift", "SwiftUI", "AWS", "Docker", "Kubernetes", "GraphQL"]
            ),
            WorkExperience(
                companyName: "TechStart Inc.",
                position: "Software Engineer",
                location: "Oakland, CA",
                startDate: Calendar.current.date(from: DateComponents(year: 2018, month: 6))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2021, month: 2))!,
                isCurrentPosition: false,
                description: "Full-stack developer for consumer-facing mobile applications with millions of users.",
                achievements: [
                    "Developed and shipped 3 iOS applications from concept to App Store",
                    "Reduced app crash rate by 75% through comprehensive unit and integration testing",
                    "Optimized database queries resulting in 60% faster load times",
                    "Collaborated with UX team to implement accessibility features"
                ],
                technologies: ["Swift", "UIKit", "Core Data", "Firebase", "REST APIs"]
            ),
            WorkExperience(
                companyName: "Digital Solutions LLC",
                position: "Junior Developer",
                location: "Portland, OR",
                startDate: Calendar.current.date(from: DateComponents(year: 2016, month: 8))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2018, month: 5))!,
                isCurrentPosition: false,
                description: "Contributed to web and mobile application development for small business clients.",
                achievements: [
                    "Assisted in developing 10+ client projects from requirements to delivery",
                    "Implemented responsive designs for cross-platform compatibility",
                    "Created automated testing scripts to improve code quality"
                ],
                technologies: ["JavaScript", "React", "Swift", "HTML/CSS"]
            )
        ]

        // Education
        let education = [
            Education(
                institution: "Stanford University",
                degree: "Master of Science",
                fieldOfStudy: "Computer Science",
                location: "Stanford, CA",
                startDate: Calendar.current.date(from: DateComponents(year: 2014, month: 9))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2016, month: 6))!,
                isCurrentlyEnrolled: false,
                gpa: 3.92,
                relevantCourses: [
                    "Advanced Algorithms",
                    "Distributed Systems",
                    "Machine Learning",
                    "Mobile Application Development",
                    "Database Systems"
                ],
                achievements: [
                    "Graduate Research Assistant - AI and Machine Learning Lab",
                    "Published paper on efficient mobile computing at SIGCHI conference",
                    "Teaching Assistant for Introduction to Computer Science"
                ]
            ),
            Education(
                institution: "University of Washington",
                degree: "Bachelor of Science",
                fieldOfStudy: "Computer Engineering",
                location: "Seattle, WA",
                startDate: Calendar.current.date(from: DateComponents(year: 2010, month: 9))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2014, month: 5))!,
                isCurrentlyEnrolled: false,
                gpa: 3.85,
                relevantCourses: [
                    "Data Structures",
                    "Computer Architecture",
                    "Software Engineering",
                    "Operating Systems",
                    "Computer Networks"
                ],
                achievements: [
                    "Dean's List all semesters",
                    "Winner, Annual Hackathon 2013",
                    "Computer Science Club President"
                ]
            )
        ]

        // Skills
        let skills = [
            Skill(name: "Swift", level: .expert, category: .technical),
            Skill(name: "SwiftUI", level: .advanced, category: .technical),
            Skill(name: "UIKit", level: .expert, category: .technical),
            Skill(name: "Objective-C", level: .intermediate, category: .technical),
            Skill(name: "Python", level: .advanced, category: .technical),
            Skill(name: "JavaScript", level: .intermediate, category: .technical),
            Skill(name: "Git", level: .expert, category: .tool),
            Skill(name: "CI/CD", level: .advanced, category: .tool),
            Skill(name: "Agile/Scrum", level: .advanced, category: .softSkill),
            Skill(name: "Problem Solving", level: .expert, category: .softSkill),
            Skill(name: "Technical Leadership", level: .advanced, category: .softSkill),
            Skill(name: "Public Speaking", level: .intermediate, category: .softSkill)
        ]

        // Certifications
        let certifications = [
            Certification(
                name: "AWS Certified Solutions Architect",
                issuingOrganization: "Amazon Web Services",
                issueDate: Calendar.current.date(from: DateComponents(year: 2022, month: 4))!,
                expirationDate: Calendar.current.date(from: DateComponents(year: 2025, month: 4))!,
                credentialID: "AWS-CSA-123456",
                credentialURL: URL(string: "https://aws.amazon.com/verification")
            ),
            Certification(
                name: "Certified Kubernetes Administrator",
                issuingOrganization: "Cloud Native Computing Foundation",
                issueDate: Calendar.current.date(from: DateComponents(year: 2021, month: 8))!,
                expirationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 8))!,
                credentialID: "CKA-1234567",
                credentialURL: URL(string: "https://www.cncf.io/certification/cka/")
            ),
            Certification(
                name: "Apple Certified iOS Developer",
                issuingOrganization: "Apple",
                issueDate: Calendar.current.date(from: DateComponents(year: 2019, month: 5))!,
                credentialID: "ACID-98765"
            )
        ]

        // Languages
        let languages = [
            Language(name: "English", proficiencyLevel: .native),
            Language(name: "Spanish", proficiencyLevel: .professional),
            Language(name: "French", proficiencyLevel: .limited)
        ]

        // Projects
        let projects = [
            Project(
                name: "HealthTrack Pro",
                description: "A comprehensive health and fitness tracking app with ML-powered insights and recommendations.",
                startDate: Calendar.current.date(from: DateComponents(year: 2022, month: 1))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2022, month: 8))!,
                url: URL(string: "https://apps.apple.com/healthtrackpro"),
                technologies: ["Swift", "SwiftUI", "HealthKit", "Core ML", "CloudKit"],
                highlights: [
                    "Over 200K downloads within first 3 months",
                    "Featured on App Store's Health & Fitness category",
                    "4.8 star average rating from 15K+ reviews",
                    "Implemented privacy-focused data handling with local processing"
                ]
            ),
            Project(
                name: "SmartBudget",
                description: "Personal finance management application with automated expense categorization and budget recommendations.",
                startDate: Calendar.current.date(from: DateComponents(year: 2020, month: 5))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2020, month: 12))!,
                url: URL(string: "https://github.com/sarahjohnson/smartbudget"),
                technologies: ["Swift", "UIKit", "Core Data", "Charts", "Plaid API"],
                highlights: [
                    "Open source project with 1.2K GitHub stars",
                    "Implemented secure banking integration with Plaid API",
                    "Created custom visualization components for financial insights"
                ]
            ),
            Project(
                name: "TaskFlow",
                description: "Team productivity and project management tool with real-time collaboration features.",
                startDate: Calendar.current.date(from: DateComponents(year: 2019, month: 3))!,
                endDate: Calendar.current.date(from: DateComponents(year: 2019, month: 9))!,
                url: URL(string: "https://taskflow.app"),
                technologies: ["JavaScript", "React", "Node.js", "MongoDB", "Socket.io"],
                highlights: [
                    "Built and shipped complete web application in 6 months",
                    "Implemented real-time collaboration using WebSockets",
                    "Onboarded 50+ teams during beta testing phase"
                ]
            )
        ]

        // References
        let references = [
            Reference(
                name: "Dr. Michael Chen",
                company: "Stanford University",
                position: "Professor of Computer Science",
                email: "michael.chen@stanford.edu",
                phone: "(650) 555-1234",
                relationship: "Graduate Advisor"
            ),
            Reference(
                name: "Jennifer Lee",
                company: "Innovation Labs",
                position: "Director of Engineering",
                email: "jennifer.lee@innovationlabs.com",
                phone: "(415) 555-6789",
                relationship: "Current Manager"
            ),
            Reference(
                name: "Robert Park",
                company: "TechStart Inc.",
                position: "CTO",
                email: "robert.park@techstart.com",
                phone: "(510) 555-4321",
                relationship: "Former Manager"
            )
        ]

        // Additional Sections
        let additionalSections = [
            AdditionalSection(
                title: "Publications",
                items: [
                    "Johnson, S., & Chen, M. (2016). \"Efficient Machine Learning Models for Mobile Devices.\" Proceedings of CHI 2016.",
                    "Johnson, S. (2018). \"Best Practices for iOS Development at Scale.\" Swift Conference Proceedings.",
                    "Johnson, S., et al. (2022). \"Microservices Architecture in Mobile-First Applications.\" Journal of Software Engineering."
                ]
            ),
            AdditionalSection(
                title: "Speaking Engagements",
                items: [
                    "WWDC 2022 - \"Building Performant SwiftUI Applications\"",
                    "SwiftConf 2021 - \"From UIKit to SwiftUI: Lessons Learned\"",
                    "Women in Tech Summit 2020 - \"Breaking Barriers in Software Engineering\"",
                    "Mobile Dev Conference 2019 - \"The Future of Mobile Development\""
                ]
            ),
            AdditionalSection(
                title: "Volunteer Experience",
                items: [
                    "Code for America - Volunteer Developer (2018-Present)",
                    "Girls Who Code - Mentor (2019-Present)",
                    "STEM Education Outreach - Workshop Leader (2017-2020)"
                ]
            )
        ]

        // Summary
        let summary = "Senior Software Engineer with 7+ years of experience building innovative mobile and cloud solutions. " +
        "Specializing in iOS development with Swift and SwiftUI, with expertise in designing scalable microservices architecture. " +
        "Passionate about creating elegant, performant applications that solve real-world problems. " +
        "Proven track record of leading technical teams and mentoring junior developers."

        // Create and return the complete Resume
        return Resume(
            personalInfo: personalInfo,
            summary: summary,
            workExperience: workExperiences,
            education: education,
            skills: skills,
            certifications: certifications,
            languages: languages,
            projects: projects,
            references: references,
            additionalSections: additionalSections
        )
    }
}
