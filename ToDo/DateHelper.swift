//
//  DateHelper.swift
//  ToDo
//
//  Created by Levi Linchenko on 01/12/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
