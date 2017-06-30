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
        listViewController.studentsList =  dataFetcher.fetchStudentsListFromJSON()
        if let studentData = (listViewController.studentsListArrayController.arrangedObjects as? [Student]) {

        detailViewController.loadDetails(ofStudent: studentData[0])
        }

    }
    func showDetailsOf(selectedStudent: Student) {
        print(selectedStudent)
        detailViewController.loadDetails(ofStudent: selectedStudent)
    }

}
