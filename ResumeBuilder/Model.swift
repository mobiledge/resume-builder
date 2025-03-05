//
//  Model.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import Foundation

struct Resume {
    let profile: Profile
    let positions: [Position]
    let education: [Education]
    let certifications: [Certification]
    let skills: [Skill]
}

struct Profile {
    let id: String
    let firstName: String
    let lastName: String
    let title: String
    let address: Address
    let phone: String
}

struct Address: Codable {
    var street: String
    var city: String
    var state: String
    var zipCode: String
    var country: String
}

struct Position {
    let id: String
    let company: String
    let role: String
    let description: String
    let technologies: [String]?
    let isCurrent: Bool
    let location: String
    let start: Date
    let end: Date?

}

struct Education {
    let id: String
    let institition: String
    let degree: String
    let fieldOfStudy: String?
    let location: String
    let start: Date
    let end: Date
    let isCurrent: Bool
}

struct Certification {
    let id: String
    let name: String
    let issuingOrganization: String?
    let credentialID: String?
    let credentialURL: URL?
    let issueDate: Date
    let expirationDate: Date?
}

struct Skill {
    let id: String
    let category: String
    let skills: [String]
}

extension Resume {
    static let sampleResume: Resume = {
        // Profile
        let address = Address(
            street: "123 Swift Avenue",
            city: "San Francisco",
            state: "CA",
            zipCode: "94107",
            country: "USA"
        )

        let profile = Profile(
            id: "profile-001",
            firstName: "Alex",
            lastName: "Morgan",
            title: "Senior iOS Developer",
            address: address,
            phone: "(415) 555-1234"
        )

        // Positions
        let positions: [Position] = [
            Position(
                id: "pos-001",
                company: "TechCorp Inc.",
                role: "Senior iOS Developer",
                description: "Lead developer for the company's flagship mobile application. Responsible for architecture decisions, code reviews, and mentoring junior developers. Implemented new features and improved app performance by 40%.",
                technologies: ["Swift", "SwiftUI", "Combine", "Core Data", "CloudKit"],
                isCurrent: true,
                location: "San Francisco, CA",
                start: DateFormatter.yyyyMMdd.date(from: "2020-06-15")!,
                end: nil
            ),
            Position(
                id: "pos-002",
                company: "Mobile Innovations",
                role: "iOS Developer",
                description: "Worked on multiple client projects developing iOS applications from concept to App Store release. Collaborated with design and backend teams to ensure seamless integration.",
                technologies: ["Swift", "UIKit", "Firebase", "RESTful APIs"],
                isCurrent: false,
                location: "Oakland, CA",
                start: DateFormatter.yyyyMMdd.date(from: "2018-03-01")!,
                end: DateFormatter.yyyyMMdd.date(from: "2020-06-01")!
            ),
            Position(
                id: "pos-003",
                company: "AppStart Studio",
                role: "Junior iOS Developer",
                description: "Assisted senior developers with feature implementation and bug fixes. Developed small-scale applications and implemented UI designs.",
                technologies: ["Swift", "Objective-C", "UIKit"],
                isCurrent: false,
                location: "Berkeley, CA",
                start: DateFormatter.yyyyMMdd.date(from: "2016-09-10")!,
                end: DateFormatter.yyyyMMdd.date(from: "2018-02-28")!
            )
        ]

        // Education
        let education: [Education] = [
            Education(
                id: "edu-001",
                institition: "University of California, Berkeley",
                degree: "Bachelor of Science",
                fieldOfStudy: "Computer Science",
                location: "Berkeley, CA",
                start: DateFormatter.yyyyMMdd.date(from: "2012-09-01")!,
                end: DateFormatter.yyyyMMdd.date(from: "2016-05-15")!,
                isCurrent: false
            ),
            Education(
                id: "edu-002",
                institition: "Stanford University",
                degree: "Master of Science",
                fieldOfStudy: "Software Engineering",
                location: "Stanford, CA",
                start: DateFormatter.yyyyMMdd.date(from: "2022-09-01")!,
                end: DateFormatter.yyyyMMdd.date(from: "2024-06-15")!,
                isCurrent: true
            )
        ]

        // Certifications
        let certifications: [Certification] = [
            Certification(
                id: "cert-001",
                name: "Apple Certified iOS Developer",
                issuingOrganization: "Apple Inc.",
                credentialID: "ACID-12345-XYZ",
                credentialURL: URL(string: "https://developer.apple.com/certification/ios"),
                issueDate: DateFormatter.yyyyMMdd.date(from: "2019-04-10")!,
                expirationDate: DateFormatter.yyyyMMdd.date(from: "2025-04-10")!
            ),
            Certification(
                id: "cert-002",
                name: "AWS Certified Developer - Associate",
                issuingOrganization: "Amazon Web Services",
                credentialID: "AWS-DEV-98765",
                credentialURL: URL(string: "https://aws.amazon.com/certification/certified-developer-associate"),
                issueDate: DateFormatter.yyyyMMdd.date(from: "2021-07-15")!,
                expirationDate: DateFormatter.yyyyMMdd.date(from: "2024-07-15")!
            )
        ]

        // Skills
        let skills: [Skill] = [
            Skill(
                id: "skill-001",
                category: "Programming Languages",
                skills: ["Swift", "Objective-C", "Python", "JavaScript"]
            ),
            Skill(
                id: "skill-002",
                category: "iOS Development",
                skills: ["UIKit", "SwiftUI", "Core Data", "CloudKit", "MapKit", "ARKit", "HealthKit"]
            ),
            Skill(
                id: "skill-003",
                category: "Tools & Practices",
                skills: ["Xcode", "Git", "CI/CD", "Test-Driven Development", "SCRUM/Agile", "Code Reviews"]
            ),
            Skill(
                id: "skill-004",
                category: "Backend & Cloud",
                skills: ["Firebase", "AWS", "RESTful APIs", "GraphQL", "Node.js"]
            )
        ]

        return Resume(
            profile: profile,
            positions: positions,
            education: education,
            certifications: certifications,
            skills: skills
        )
    }()
}

extension Resume {
    func log() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        print("============ RESUME ============")

        // Profile
        print("\n📋 PROFILE")
        print("Name: \(profile.firstName) \(profile.lastName)")
        print("Title: \(profile.title)")
        print("Location: \(profile.address.city), \(profile.address.state)")
        print("Phone: \(profile.phone)")

        // Positions
        print("\n💼 WORK EXPERIENCE")
        for position in positions {
            print("\n🏢 \(position.company) - \(position.role)")
            print("📍 \(position.location)")
            print("📅 \(dateFormatter.string(from: position.start)) - \(position.end != nil ? dateFormatter.string(from: position.end!) : "Present")")
            print("📝 \(position.description)")
            if let technologies = position.technologies {
                print("🔧 Technologies: \(technologies.joined(separator: ", "))")
            }
        }

        // Education
        print("\n🎓 EDUCATION")
        for edu in education {
            print("\n🏫 \(edu.institition)")
            print("📜 \(edu.degree)\(edu.fieldOfStudy != nil ? " in \(edu.fieldOfStudy!)" : "")")
            print("📍 \(edu.location)")
            print("📅 \(dateFormatter.string(from: edu.start)) - \(dateFormatter.string(from: edu.end))")
        }

        // Certifications
        print("\n🏆 CERTIFICATIONS")
        for cert in certifications {
            print("\n📜 \(cert.name)")
            if let org = cert.issuingOrganization {
                print("🏢 \(org)")
            }
            print("📅 Issued: \(dateFormatter.string(from: cert.issueDate))")
            if let expDate = cert.expirationDate {
                print("⏳ Expires: \(dateFormatter.string(from: expDate))")
            }
            if let credID = cert.credentialID {
                print("🔑 ID: \(credID)")
            }
        }

        // Skills
        print("\n🔧 SKILLS")
        for skill in skills {
            print("\n🔹 \(skill.category):")
            print("  \(skill.skills.joined(separator: ", "))")
        }

        print("\n================================")
    }
}

extension DateFormatter {

    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
