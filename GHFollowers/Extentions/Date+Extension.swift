//
//  Date+Extension.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 23/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
