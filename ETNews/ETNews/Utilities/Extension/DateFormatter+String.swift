//
//  DateFormatter+String.swift
//  ETNews
//
//  Created by Emre Tanrısever on 18.03.2024.
//

import Foundation

extension String {
    
    func dateFormetter() -> String {
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormetter.date(from: self) else {
            return ""
        }
        let newDateFormetter = DateFormatter()
        newDateFormetter.dateFormat = "dd/MM/yyyy"
        return newDateFormetter.string(from: date)
    }
}
