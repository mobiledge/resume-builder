//
//  State.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-13.
//

import Foundation
import PDFKit

@Observable class AppState {
    var pdfDocument: PDFDocument {
        PDFDocument(attributedString: personalInfo.attributedString()) ?? PDFDocument()
    }
    var personalInfo = PersonalInfo.mock
}
