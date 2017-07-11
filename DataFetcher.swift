//
//  DataFetcher.swift
//  StudentList
//
//  Created by nayome.devapriya on  28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class DataFetcher {
    
    enum fetcherResponse {
        case success([Student])
        case failure(NSError)
    }
    func fetchStudentsListFromJSON(completionHandler: @escaping (fetcherResponse) -> Void) {
        var result: fetcherResponse
        let url = Bundle.main.url(forResource: "StudentsList", withExtension: "json")
        if let url = url {
            do {
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                //handle the error thrown
                do {
                    result = try self.parse(theData: data)
                }
                catch let error {
                    result = .failure(error as NSError)
                }
            } catch let error {
                result = .failure(error as NSError)
            }
            OperationQueue.main.addOperation {
                completionHandler(result)
            }
        }
    }

    func parse(theData: Data) throws-> fetcherResponse
    {
        var studentsDetails:NSDictionary?
        do {
            studentsDetails = try JSONSerialization.jsonObject(with: theData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
        } catch let error {
            print("\(error.localizedDescription)")
            return .failure(error as NSError)
        }
        
        var listOfStudents: [Student] = []
        if let studentsDetails = studentsDetails {
            guard let listRetreived = studentsDetails[Constants.kStudentList] as? [NSDictionary] else {
                let error = NSError.init(domain: Constants.domainName, code: 1001, userInfo: nil)
                return .failure(error as NSError)
            }
            
            for studentData in listRetreived {
                if let studentId = studentData[Constants.kStudentId] as? Int, let studentName = studentData[Constants.kStudentName] as? String, let marks = studentData[Constants.kStudentMarks] as? Int, let status = studentData[Constants.kStudentStatus] as? String{
                    let details = Student.init(id: studentId,name: studentName, marks: marks, status: status, subjects: studentData[Constants.kStudentSubjects] as! [Subject])
                    listOfStudents.append(details)
                }
            }
            return .success(listOfStudents)
        }
        return .failure(NSError.init(domain: Constants.domainName, code: 1002, userInfo: nil))
    }
}
