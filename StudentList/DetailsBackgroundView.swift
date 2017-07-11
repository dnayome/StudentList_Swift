//
//  DetailsBackgroundView.swift
//  StudentList
//
//  Created by nayome.devapriya on 11/07/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa
class DetailsBackgroundView: NSView {
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
