//
//  DateValue.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/17.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
