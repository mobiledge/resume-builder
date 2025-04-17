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
    var skills = Skills.mock
    var workExperienceCollection = WorkExperienceCollection.mock

    var pdfDocument: PDFDocument {
        guard let data = try? pdfData(),
              let doc = PDFDocument(data: data) else {
            return PDFDocument()
        }
        return doc
    }
}

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

@Observable class Skill: Identifiable, Equatable {
    let id = UUID()
    var category: String
    var values: String

    init(category: String, values: String) {
        self.category = category
        self.values = values
    }

    static func == (lhs: Skill, rhs: Skill) -> Bool {
        lhs.id == rhs.id
    }
}

@Observable class WorkExperienceCollection {
    var items: [WorkExperience]

    internal init(items: [WorkExperience]) {
        self.items = items
    }

    static var mock: WorkExperienceCollection {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return WorkExperienceCollection(items: [
            WorkExperience(
                companyName: "Tech Innovations Inc.",
                position: "Senior Software Engineer",
                location: "San Francisco, CA",
                startDate: dateFormatter.date(from: "2022-03-15"),
                endDate: nil,
                isCurrentPosition: true,
                description: "Leading a team of 5 engineers developing iOS applications. Implemented CI/CD pipelines that reduced deployment time by 40%. Architected and developed a new feature that increased user engagement by 25%."
            ),
            WorkExperience(
                companyName: "Mobile Solutions Ltd.",
                position: "iOS Developer",
                location: "Austin, TX",
                startDate: dateFormatter.date(from: "2019-06-01"),
                endDate: dateFormatter.date(from: "2022-03-01"),
                isCurrentPosition: false,
                description: "Developed and maintained multiple iOS applications using Swift and UIKit. Collaborated with design team to implement user-friendly interfaces. Reduced app crash rate by 75% through comprehensive testing and debugging."
            ),
            WorkExperience(
                companyName: "StartUp Ventures",
                position: "Junior Developer",
                location: "Boston, MA",
                startDate: dateFormatter.date(from: "2017-09-12"),
                endDate: dateFormatter.date(from: "2019-05-15"),
                isCurrentPosition: false,
                description: "Assisted in the development of iOS and Android applications. Implemented RESTful API integrations. Participated in daily scrums and bi-weekly sprint planning meetings."
            ),
            WorkExperience(
                companyName: "Code Academy",
                position: "Intern",
                location: "Remote",
                startDate: dateFormatter.date(from: "2017-01-10"),
                endDate: dateFormatter.date(from: "2017-08-30"),
                isCurrentPosition: false,
                description: "Assisted senior developers with bug fixes and testing. Learned Swift programming and iOS development principles. Created a small utility application as a final project."
            )
        ])
    }
}

@Observable class WorkExperience: Identifiable {
    let id = UUID()
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
