//
//  MainSplitViewController.swift
//  StudentList
//
//  Created by nayome.devapriya on 28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa
class MainSplitViewController: NSSplitViewController,StudentsListViewControllerDelegate{

    var listViewController: StudentsListViewController {
        return splitViewItems[0].viewController as! StudentsListViewController
    }
    
    var detailViewController: StudentDetailsViewController {
        return splitViewItems[1].viewController as! StudentDetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        listViewController.delegate = self
        let dataFetcher = DataFetcher()
        dataFetcher.fetchStudentsListFromJSONWithCompletionHandler { (fetcherResponse) -> Void in
            switch fetcherResponse
            {
            case .success(let studentsList):
                self.listViewController.studentsList =  studentsList
                if let studentData = (self.listViewController.studentsListArrayController.arrangedObjects as? [Student]) {
                    self.detailViewController.loadDetails(ofStudent: studentData[0])
                }

            case .failure(let error):
                NSAlert (error:error).runModal()
                self.listViewController.studentsList = []
            }
            
        }

    }
    func showDetailsOf(selectedStudent: Student) {
        detailViewController.loadDetails(ofStudent: selectedStudent)
    }

}
