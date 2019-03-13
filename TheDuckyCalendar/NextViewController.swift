//
//  NextViewController.swift
//  TheDuckyCalendar
//
//  Created by Kevin Nguyen on 3/8/19.
//  Copyright © 2019 Kevin Nguyen. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet var DateLabel: UILabel!
    
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var Picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        DateLabel.text = dateString
        Picker?.datePickerMode = .time
//        Picker?.minimumDate = Date.calculateTime(hour: 0, minute: 0)
//        Picker?.maximumDate = Date.calculateTime(hour: 24, minute: 59)
        
    }
    
    @IBAction func valueChanged(_ sender: UIDatePicker) {
        
        TimeLabel?.text = "\(sender.date.getHourMinuteSecond().hour):\(sender.date.getHourMinuteSecond().minute)"
        
    }
    
    @IBAction func dismissSchedule(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "GoBack", sender: self)
    }
}
