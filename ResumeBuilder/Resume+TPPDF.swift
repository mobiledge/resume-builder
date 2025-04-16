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
        try workExp.configure(document: document)
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

extension Skills {

    func configure(document: PDFDocument) {
        document.add(attributedText: attributedHeader)
        document.add(space: 5)
        for attr in attributedSkills {
            document.add(attributedText: attr)
            document.add(space: 5)
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
