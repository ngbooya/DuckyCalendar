//
//  Date-Extension.swift
//  TheDuckyCalendar
//
//  Created by Kevin Nguyen on 3/11/19.
//  Copyright © 2019 Kevin Nguyen. All rights reserved.
//

import Foundation
import UIKit
extension Date{
    static func calculateTime(hour: Int, minute: Int) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculatedTime = formatter.date(from: "\(hour):\(minute)")
        return calculatedTime!
    }
    func getHourMinuteSecond() -> (hour: Int, minute: Int, second: Int){
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        return(hour,minute,second)
    }
}
