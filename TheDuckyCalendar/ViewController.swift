//
//  ViewController.swift
//  TheDuckyCalendar
//
//  Created by Kevin Nguyen on 3/3/19.
//  Copyright © 2019 Kevin Nguyen. All rights reserved.
//

import UIKit

var dateString = ""

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    
    let Months = ["January", "February","March","April","May","June","July","August","September","October","November","December"]
    let DaysOfMonth = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    var NumberOfEmptyBox = Int()
    var NextNumberOfEmptyBox = Int()
    var PreviousNumberOfEmptyBox = 0
    var Direction = 0
    var PositionIndex = 0
    var LeapYearCounter = 2
    var dayCounter = 0
    var highlightDate = -1
    
    var cellsArray: [UICollectionViewCell] = []
    
    var effect:UIVisualEffect!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        if weekday == 0{
            weekday = 7
        }
        getStartDateDayPosition()
        
        Calendar.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        Calendar.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        Calendar.addGestureRecognizer(swipeLeft)
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
    }
    
    func animateIn(){
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        DateLabel.text = dateString
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3,y:1.3)
        addItemView.alpha = 0
        UIView.animate(withDuration:  0.4){
            self.visualEffectView.effect = self.effect
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
            self.addItemView.alpha = 0
            self.visualEffectView.effect = nil
        }) {(success:Bool) in
                self.addItemView.removeFromSuperview()
        }
    }
    
    @IBAction func dismissPopUp(_ sender: Any) {
        animateOut()
    }
    
    @objc func swipeGesture(sendr:UISwipeGestureRecognizer){
        if let swipeGesture = sendr as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                print("Swipe right")
                highlightDate = -1
                switch currentMonth {
                case "January":
                    Direction = -1
                    month = 11
                    year -= 1
                    if LeapYearCounter > 0{
                        LeapYearCounter -= 1
                    }
                    if LeapYearCounter == 0{
                        DaysInMonths[1] = 29
                        LeapYearCounter = 4
                    }else{
                        DaysInMonths[1] = 28
                    }
                    getStartDateDayPosition()
                    MonthLabel.text = "\(currentMonth) \(year)"
                    
                    MoveAnimationBack(Label: MonthLabel, Cal:Calendar)
                    
                    Calendar.reloadData()
                default:
                    
                    Direction = -1
                    month -= 1
                    
                    getStartDateDayPosition()
                    currentMonth = Months[month]
                    MonthLabel.text = "\(currentMonth) \(year)"
                    
                    MoveAnimationBack(Label: MonthLabel, Cal:Calendar)
                    
                    Calendar.reloadData()
                }
            case UISwipeGestureRecognizer.Direction.left:
                print("Swipe left")
                highlightDate = -1
                switch currentMonth{
                case "December":
                    month = 0
                    year += 1
                    Direction = 1
                    if LeapYearCounter < 5{
                        LeapYearCounter += 1
                    }
                    if LeapYearCounter == 4{
                        DaysInMonths[1] = 29
                    }
                    if LeapYearCounter == 5{
                        LeapYearCounter = 1
                        DaysInMonths[1] = 28
                    }
                    getStartDateDayPosition()
                    currentMonth = Months[month]
                    MonthLabel.text = "\(currentMonth) \(year)"
                    
                    MoveAnimationNext(Label: MonthLabel, Cal:Calendar)
                    
                    Calendar.reloadData()
                default:
                    Direction = 1
                    getStartDateDayPosition()
                    month += 1
                    currentMonth = Months[month]
                    MonthLabel.text = "\(currentMonth) \(year)"
                    
                    MoveAnimationNext(Label: MonthLabel, Cal:Calendar)
                    
                    Calendar.reloadData()
                }
                
            default:
                break
            
            }
        }
    }
    
   
    
    func getStartDateDayPosition(){
        switch Direction {
        case 0:
            NumberOfEmptyBox = weekday
            dayCounter = day
            while dayCounter > 0{
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                dayCounter = dayCounter - 1
                if NumberOfEmptyBox == 0{
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7{
                NumberOfEmptyBox = 0
            }
            PositionIndex = NumberOfEmptyBox
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month])%7
            PositionIndex = NextNumberOfEmptyBox
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7{
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction {
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        cell.Circle.isHidden = true
        
        if cell.isHidden{
            cell.isHidden = false
        }
        switch Direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1{
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 0,6,7,13,14,20,21,27,28,34,35:
            if Int(cell.DateLabel.text!)! > 0{
                cell.DateLabel.textColor = UIColor.black
            }
        default:
            break
        }
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == day{
            cell.Circle.isHidden = false
            cell.DrawCircle()
        }
        if highlightDate == indexPath.row{
//            cell.backgroundColor = UIColor.black
            
        }
        cellsArray.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dateString = "\(indexPath.row - PositionIndex + 1) \(currentMonth) \(year)"
//        performSegue(withIdentifier: "NextView", sender: self)
        animateIn()
        
        highlightDate = indexPath.row //refers to the index of the calendar
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        for x in cellsArray{
            let cell: UICollectionViewCell = x
            UIView.animate(withDuration: 1, delay: 0.01 * Double(indexPath.row),options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }
    }


}

