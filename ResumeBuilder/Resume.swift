//
//  State.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-13.
//

import Foundation
import PDFKit

@Observable class Resume {


    var personalInfo: PersonalInfo
    var skills: SkillCollection
    var workExperienceCollection: WorkExperienceCollection
    var educationCollection: EducationCollection

    init(
        personalInfo: PersonalInfo,
        skills: SkillCollection,
        workExperienceCollection: WorkExperienceCollection,
        educationCollection: EducationCollection
    ) {
        self.personalInfo = personalInfo
        self.skills = skills
        self.workExperienceCollection = workExperienceCollection
        self.educationCollection = educationCollection
    }

    var pdfDocument: PDFDocument {
        guard let data = try? pdfData(),
              let doc = PDFDocument(data: data) else {
            return PDFDocument()
        }
        return doc
    }

    static var mock = Resume(
        personalInfo: PersonalInfo.mock,
        skills: SkillCollection.mock,
        workExperienceCollection: WorkExperienceCollection.mock,
        educationCollection: EducationCollection.mock
    )


    // MARK: - Resume + Skills
    func delete(skill: Skill) {
        skills.items.removeAll { $0.id == skill.id }
    }

    func add(skill: Skill) {
        skills.items.append(skill)
    }

    func canMoveUp(skill: Skill) -> Bool {
        // Check if the skill exists in the array and is not the first item
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }) else {
            return false
        }
        return index > 0
    }

    func moveUp(skill: Skill) -> Void {
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }),
              canMoveUp(skill: skill) else {
            return
        }
        skills.items.swapAt(index, index - 1)
    }

    func canMoveDown(skill: Skill) -> Bool {
        // Check if the skill exists in the array and is not the last item
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }) else {
            return false
        }
        return index < skills.items.count - 1
    }

    func moveDown(skill: Skill) -> Void {
        guard let index = skills.items.firstIndex(where: { $0.id == skill.id }),
              canMoveDown(skill: skill) else {
            return
        }
        skills.items.swapAt(index, index + 1)
    }


    // MARK: - Resume + WorkExperience
    func delete(experience: WorkExperience) {
        workExperienceCollection.items.removeAll { $0.id == experience.id }
    }

    func add(experience: WorkExperience) {
        workExperienceCollection.items.append(experience)
    }

    func canMoveUp(experience: WorkExperience) -> Bool {
        // Check if the workExperience exists in the array and is not the first item
        guard let index = workExperienceCollection.items.firstIndex(where: { $0.id == experience.id }) else {
            return false
        }
        return index > 0
    }

    func moveUp(experience: WorkExperience) -> Void {
        guard let index = workExperienceCollection.items.firstIndex(where: { $0.id == experience.id }),
              canMoveUp(experience: experience) else {
            return
        }
        workExperienceCollection.items.swapAt(index, index - 1)
    }

    func canMoveDown(experience: WorkExperience) -> Bool {
        // Check if the workExperience exists in the array and is not the last item
        guard let index = workExperienceCollection.items.firstIndex(where: { $0.id == experience.id }) else {
            return false
        }
        return index < workExperienceCollection.items.count - 1
    }

    func moveDown(experience: WorkExperience) -> Void {
        guard let index = workExperienceCollection.items.firstIndex(where: { $0.id == experience.id }),
              canMoveDown(experience: experience) else {
            return
        }
        workExperienceCollection.items.swapAt(index, index + 1)
    }


    // MARK: - Resume + Education
    func delete(education: Education) {
        educationCollection.items.removeAll { $0.id == education.id }
    }

    func add(education: Education) {
        educationCollection.items.append(education)
    }

    func canMoveUp(education: Education) -> Bool {
        // Check if the workExperience exists in the array and is not the first item
        guard let index = educationCollection.items.firstIndex(where: { $0.id == education.id }) else {
            return false
        }
        return index > 0
    }

    func moveUp(education: Education) -> Void {
        guard let index = educationCollection.items.firstIndex(where: { $0.id == education.id }),
              canMoveUp(education: education) else {
            return
        }
        educationCollection.items.swapAt(index, index - 1)
    }

    func canMoveDown(education: Education) -> Bool {
        // Check if the workExperience exists in the array and is not the last item
        guard let index = educationCollection.items.firstIndex(where: { $0.id == education.id }) else {
            return false
        }
        return index < educationCollection.items.count - 1
    }

    func moveDown(education: Education) -> Void {
        guard let index = educationCollection.items.firstIndex(where: { $0.id == education.id }),
              canMoveDown(education: education) else {
            return
        }
        educationCollection.items.swapAt(index, index + 1)
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

@Observable class SkillCollection {
    var items: [Skill]

    init(items: [Skill]) {
        self.items = items
    }

    static let mock = SkillCollection(items: [
        Skill(category: "Frontend", values: "JavaScript, TypeScript, React, Vue.js, Angular, CSS3, HTML5, Webpack"),
        Skill(category: "Backend", values: "Node.js, Express, Django, Ruby on Rails, REST APIs, GraphQL"),
        Skill(category: "Database", values: "MongoDB, PostgreSQL, MySQL, Redis, Elasticsearch, ORM tools"),
        Skill(category: "DevOps", values: "Docker, Kubernetes, AWS, CI/CD, GitHub Actions, Netlify, Vercel"),
        Skill(category: "Tools", values: "Git, VSCode, npm, Yarn, Jest, Cypress, Storybook, Figma")
    ])
}

// Equatable needed for animation
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

var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()

@Observable class WorkExperienceCollection {
    var items: [WorkExperience]

    internal init(items: [WorkExperience]) {
        self.items = items
    }

    static var mock = WorkExperienceCollection(items: [
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

@Observable class WorkExperience: Identifiable, Equatable {
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

    static var mock: WorkExperience  = WorkExperienceCollection.mock.items[0]

    static var empty: WorkExperience {
        WorkExperience(
            companyName: "",
            position: "",
            location: "",
            startDate: nil,
            endDate: nil,
            isCurrentPosition: false,
            description: ""
        )
    }

    static func == (lhs: WorkExperience, rhs: WorkExperience) -> Bool {
        lhs.id == rhs.id
    }
}



@Observable class EducationCollection {
    var items: [Education]

    // MARK: - Initializers
    init() {
        self.items = []
    }

    init(items: [Education]) {
        self.items = items
    }

    // MARK: - Methods
    func add(_ education: Education) {
        items.append(education)
    }

    func remove(at index: Int) {
        guard index >= 0 && index < items.count else { return }
        items.remove(at: index)
    }

    func getItem(at index: Int) -> Education? {
        guard index >= 0 && index < items.count else { return nil }
        return items[index]
    }

    func count() -> Int {
        return items.count
    }

    func isEmpty() -> Bool {
        return items.isEmpty
    }

    // MARK: - Static Properties
    static var mock: EducationCollection {
        let collection = EducationCollection()
        collection.add(Education.mock)
        collection.add(Education(
            degree: "Master of Science",
            fieldOfStudy: "Computer Science",
            institution: "Stanford University",
            location: "Stanford, CA",
            startDate: Calendar.current.date(from: DateComponents(year: 2018, month: 9, day: 1))!,
            endDate: Calendar.current.date(from: DateComponents(year: 2020, month: 6, day: 15))!
        ))
        collection.add(Education(
            degree: "PhD",
            fieldOfStudy: "Artificial Intelligence",
            institution: "MIT",
            location: "Cambridge, MA",
            startDate: Calendar.current.date(from: DateComponents(year: 2020, month: 9, day: 1))!,
            endDate: nil
        ))
        return collection
    }

    static var empty: EducationCollection {
        return EducationCollection()
    }
}

@Observable class Education: Identifiable {
    let id = UUID()
    var degree: String
    var fieldOfStudy: String
    var institution: String
    var location: String
    var startDate: Date
    var endDate: Date?

    // MARK: - Initializer
    init(
        degree: String,
        fieldOfStudy: String,
        institution: String,
        location: String,
        startDate: Date,
        endDate: Date? = nil
    ) {
        self.degree = degree
        self.fieldOfStudy = fieldOfStudy
        self.institution = institution
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
    }

    // MARK: - Static Properties
    static var mock: Education {
        return Education(
            degree: "Bachelor of Science",
            fieldOfStudy: "Computer Engineering",
            institution: "University of California, Berkeley",
            location: "Berkeley, CA",
            startDate: Calendar.current.date(from: DateComponents(year: 2014, month: 8, day: 20))!,
            endDate: Calendar.current.date(from: DateComponents(year: 2018, month: 5, day: 12))!
        )
    }

    static var empty: Education {
        return Education(
            degree: "",
            fieldOfStudy: "",
            institution: "",
            location: "",
            startDate: Date(),
            endDate: nil
        )
    }
}

