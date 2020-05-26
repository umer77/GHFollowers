//
//  String+Extension.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import Foundation

extension String {

    var isValidEmail: Bool {
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }


    var isValidPassword: Bool {
        //Regex restricts to 8 character minimum, 1 capital letter, 1 lowercase letter, 1 number
        //If you have different requirements a google search for "password requirement regex" will help
        let passwordFormat      = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }


    var isValidPhoneNumber: Bool {
        let phoneNumberFormat   = "^\\d{3}-\\d{3}-\\d{4}$"
        let numberPredicate     = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return numberPredicate.evaluate(with: self)
    }


    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    
    func convertToDate() -> Date? {
        let dateFomratter           = DateFormatter()
        dateFomratter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFomratter.locale        = Locale(identifier: "en_US")
        dateFomratter.timeZone      = .current
        return dateFomratter.date(from: self)
    }
    
    
    func convertToDisplayFomrat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}

