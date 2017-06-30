//
//  DataFetcher.swift
//  StudentList
//
//  Created by nayome.devapriya on  28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class DataFetcher {
    
    func fetchStudentsListFromJSON() -> [Student] {
        let url = Bundle.main.url(forResource: "StudentsList", withExtension: "json")
    
        if let url = url {
            do {
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                //handle the error thrown
                do {
                    return self.parse(theData: data)
                }
            } catch _ {
                return []
            }
        }
        return []
    }

    func parse(theData: Data) -> [Student]
    {
        var studentDetails:NSDictionary?
        do {
            studentDetails = try JSONSerialization.jsonObject(with: theData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
        } catch let error {
            print("\(error.localizedDescription)")
            return []
        }
        
        var listOfStudents: [Student] = []
        if let studentDetails = studentDetails {
            guard let listRetreived = studentDetails[Constants.kStudentList] as? [NSDictionary] else {
                print("Unable retreive data")
                return []
            }
            
            for studentData in listRetreived {
                if let studentId = studentData[Constants.kStudentId] as? Int, let studentName = studentData[Constants.kStudentName] as? String, let marks = studentData[Constants.kStudentMarks] as? Int, let status = studentData[Constants.kStudentStatus] as? String{
                    let details = Student.init(id: studentId,name: studentName, marks: marks, status: status, subjects: studentData[Constants.kStudentSubjects] as! [Subject])
                    listOfStudents.append(details)
                }
            }
            return listOfStudents
        }
        else
        {
            return []
        }
    }
}
