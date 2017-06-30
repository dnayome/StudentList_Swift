//
//  Student.swift
//  StudentList
//
//  Created by nayome.devapriya on  28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class Student: NSObject {
    let id: Int
    let name: String
    let marks: Int
    let status: String
    let subjects: [Subject]
    init(id: Int, name: String, marks: Int,status: String, subjects: [Subject]) {
        self.id = id
        self.name = name
        self.marks = marks
        self.status = status
        self.subjects = subjects
    }
}

class Subject: NSObject {
    let subjectName: String
    let marksObtained: Int
    
    init(subjectName: String, marksObtained: Int) {
        self.subjectName = subjectName
        self.marksObtained = marksObtained
    }
}
