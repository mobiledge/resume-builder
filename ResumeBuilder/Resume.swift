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

    var pdfDocument: PDFDocument {
        //PDFDocument(attributedString: attributedString) ?? PDFDocument()
        guard let data = try? pdfData(),
        let doc = PDFDocument(data: data) else {
            return PDFDocument()
        }
        return doc
    }
}

// MARK: - Personal Information
@Observable class PersonalInfo {
    var name: String = ""
    var title: String = ""
    var location: String = ""
    var email: String = ""
    var phone: String = ""
    var summary: String = ""

    internal init(
        name: String = "",
        title: String = "",
        city: String = "",
        email: String = "",
        phone: String = "",
        summary: String = ""
    ) {
        self.name = name
        self.title = title
        self.location = city
        self.email = email
        self.phone = phone
        self.summary = summary
    }


    static var mock: PersonalInfo = PersonalInfo(
        name: "John Doe",
        title: "Software Developer",
        city: "San Francisco",
        email: "john.doe@example.com",
        phone: "555-123-4567",
        summary: "Senior Software Developer with 10+ years of experience architecting scalable applications and leading high-performance engineering teams. Expertise in full-stack development, cloud infrastructure, and delivering enterprise solutions that drive business growth."
    )
}

// MARK: - Summary
@Observable class Summary {

    var text: String

    internal init(text: String) {
        self.text = text
    }

    static let mock = Summary(text:"Senior Software Developer with 10+ years of experience architecting scalable applications and leading high-performance engineering teams. Expertise in full-stack development, cloud infrastructure, and delivering enterprise solutions that drive business growth.")
}

@Observable class Skills {
    var items: [Skill]

    init(items: [Skill]) {
        self.items = items
    }

    static let mock = Skills(items: [
        Skill(category: "Frontend", values: "JavaScript, TypeScript, React, Vue.js, Angular, CSS3, HTML5, Webpack"),
        Skill(category: "Backend", values: "Node.js, Express, Django, Ruby on Rails, REST APIs, GraphQL"),
        Skill(category: "Database", values: "MongoDB, PostgreSQL, MySQL, Redis, Elasticsearch, ORM tools"),
        Skill(category: "DevOps", values: "Docker, Kubernetes, AWS, CI/CD, GitHub Actions, Netlify, Vercel"),
        Skill(category: "Tools", values: "Git, VSCode, npm, Yarn, Jest, Cypress, Storybook, Figma")
    ])

}

@Observable class Skill: Identifiable {
    let id = UUID()
    var category: String
    var values: String

    init(category: String, values: String) {
        self.category = category
        self.values = values
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
}
