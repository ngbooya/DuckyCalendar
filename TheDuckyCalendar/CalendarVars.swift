//
//  CalendarVars.swift
//  TheDuckyCalendar
//
//  Created by Kevin Nguyen on 3/3/19.
//  Copyright © 2019 Kevin Nguyen. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)

