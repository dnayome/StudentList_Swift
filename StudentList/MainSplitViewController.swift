//
//  MainSplitViewController.swift
//  StudentList
//
//  Created by nayome.devapriya on 28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa
class MainSplitViewController: NSSplitViewController{

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
        dataFetcher.fetchStudentsListFromJSON { [weak self] (fetcherResponse) in
            guard let weakSelf = self else {return}
            switch fetcherResponse {
            case .success(let studentsList):
                weakSelf.listViewController.studentsList =  studentsList
                if let studentData = (weakSelf.listViewController.studentsListArrayController.arrangedObjects as? [Student]) {
                    weakSelf.detailViewController.loadDetails(ofStudent: studentData[0])
                }
            case .failure(let error):
                NSAlert (error:error).runModal()
                weakSelf.listViewController.studentsList = []
            }
        }
    }
}

extension MainSplitViewController: StudentsListViewControllerDelegate {
 
    func showDetailsOf(selectedStudent: Student) {
        detailViewController.loadDetails(ofStudent: selectedStudent)
    }

}
