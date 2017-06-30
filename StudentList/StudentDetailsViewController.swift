//
//  StudentDetailsViewController.swift
//  StudentList
//
//  Created by nayome.devapriya on 28/04/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class StudentDetailsViewController: NSViewController {
    @IBOutlet weak var name: NSTextField!
    @IBOutlet weak var totalMarks: NSTextField!
    dynamic var studentSujectWiseMarks = [Subject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = NSColor.white
    }
    
    func loadDetails(ofStudent: Student) {
        name.stringValue = ofStudent.name
        totalMarks.stringValue = ofStudent.marks.description
        self.studentSujectWiseMarks.removeAll()
        self.studentSujectWiseMarks = ofStudent.subjects
    }

}

extension NSView {
    var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}
