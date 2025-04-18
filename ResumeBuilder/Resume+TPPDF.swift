//
//  Resume+TPPDF.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-28.
//

import Foundation
import TPPDF

extension Resume {

    func pdfData() throws -> Data {
        let document = PDFDocument(format: .a4)
        try configure(document: document)
        let generator = PDFGenerator(document: document)
        let data = try generator.generateData()
        return data
    }

    func configure(document: PDFDocument) throws {
        personalInfo.configure(document: document)
        document.add(space: 20)
        skills.configure(document: document)
        document.add(space: 20)
        try workExperienceCollection.configure(document: document)
        document.add(space: 20)
        try educationCollection.configure(document: document)
    }
}

extension PersonalInfo {
    func configure(document: PDFDocument) {
        document.add(attributedText: attributedname)
        document.add(space: 5)
        document.add(attributedText: attributedtitle)
        document.add(space: 5)
        document.add(attributedText: attributedcity)
        document.add(space: 5)
        document.add(attributedText: attributedemail)
        document.add(space: 5)
        document.add(attributedText: attributedphone)
        document.add(space: 20)
        document.add(attributedText: attributedSummaryHeader)
        document.add(space: 5)
        document.add(attributedText: attributedSummary)
    }
}

extension SkillCollection {

    func configure(document: PDFDocument) {
        document.add(attributedText: attributedHeader)
        document.add(space: 5)
        for attr in attributedSkills {
            document.add(attributedText: attr)
            document.add(space: 5)
        }
    }
}

extension WorkExperienceCollection {

    func configure(document: PDFDocument) throws {
        document.add(attributedText: attributedHeader)
        document.add(space: 20)
        for exp in items {
            try exp.configure(document: document)
            document.add(space: 20)
        }
    }
}

extension WorkExperience {

    func configure(document: PDFDocument) throws {
        // Table
        let table = PDFTable(rows: 2, columns: 2)
        table.style = PDFTableStyle(outline: PDFLineStyle(type: .none, color: .clear))
        table.padding = 0
        table.margin = 0

        // Position
        let positionCell = table[0, 0]
        positionCell.content = try PDFTableContent(content: attributedPosition)
        positionCell.alignment = .left

        // Dates
        let dateCell = table[0, 1]
        dateCell.content = try PDFTableContent(content: attributedDate)
        dateCell.alignment = .right

        // Company
        let companyCell = table[1, 0]
        companyCell.content = try PDFTableContent(content: attributedCompanyName)
        companyCell.alignment = .left

        // Location
        let locationCell = table[1, 1]
        locationCell.content = try PDFTableContent(content: attributedLocation)
        locationCell.alignment = .right

        document.add(table: table)
        document.add(space: 5)
        document.add(attributedText: attributedDescription)
    }
}

extension EducationCollection {

    func configure(document: PDFDocument) throws {
        document.add(attributedText: attributedHeader)
        document.add(space: 20)
        for edu in items {
            try edu.configure(document: document)
            document.add(space: 20)
        }
    }
}

extension Education {

    func configure(document: PDFDocument) throws {
        // Table
        let table = PDFTable(rows: 2, columns: 2)
        table.style = PDFTableStyle(outline: PDFLineStyle(type: .none, color: .clear))
        table.padding = 0
        table.margin = 0

        // Degree
        let degreeCell = table[0, 0]
        degreeCell.content = try PDFTableContent(content: attributedDegree)
        degreeCell.alignment = .left

        // Dates
        let dateCell = table[0, 1]
        dateCell.content = try PDFTableContent(content: attributedDate)
        dateCell.alignment = .right

        // Institution
        let institutionCell = table[1, 0]
        institutionCell.content = try PDFTableContent(content: attributedInstitution)
        institutionCell.alignment = .left

        // Location
        let locationCell = table[1, 1]
        locationCell.content = try PDFTableContent(content: attributedLocation)
        locationCell.alignment = .right

        document.add(table: table)

        // Field of Study
        if !fieldOfStudy.isEmpty {
            document.add(attributedText: attributedFieldOfStudy)
        }
    }
}
