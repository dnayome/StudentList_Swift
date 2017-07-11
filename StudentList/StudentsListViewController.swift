//
//  StudentsListViewController.swift
//  StudentList
//
//  Created by nayome.devapriya on  28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

protocol StudentsListViewControllerDelegate: class {
    func showDetailsOf(selectedStudent: Student)
}

class StudentsListViewController: NSViewController {
    weak var delegate: StudentsListViewControllerDelegate? = nil
    dynamic var studentsList = [Student]()
    @IBOutlet var studentsListArrayController: NSArrayController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectStudent(_ sender: NSTableView) {
        if let studentData = (studentsListArrayController.arrangedObjects as? [Student]) {
            let selectedStudent = studentData[sender.selectedRow]
            self.delegate?.showDetailsOf(selectedStudent: selectedStudent)
        }
    }
    
}

extension StudentsListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
        if tableColumn?.identifier == Constants.kStudentStatus
        {
            let cell: NSTextFieldCell = cell as! NSTextFieldCell
            if let studentData = (studentsListArrayController.arrangedObjects as? [Student]) {
                if studentData[row].status == Constants.kStudentStatusFail {
                    cell.textColor = NSColor.red
                } else {
                    cell.textColor = NSColor.black
                }
            }
        }
    }
}
