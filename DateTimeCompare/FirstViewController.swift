//
//  FirstViewController.swift
//  DateTimeCompare
//
//  Created by TAKESHI SHIMADA on 2019/05/16.
//  Copyright © 2019 TAKESHI SHIMADA. All rights reserved.
//

import UIKit
import SwiftDate

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        temp()
    }
    
    func temp() {
        
        ///
        let _ = {
            guard let date1 = Date.ex.fromISO8601(string: "2019-05-01T15:00:00+00:00"),
                let date2 = Date.ex.fromISO8601(string: "2019-05-01T15:43:00+00:00") else { return }
            let isSame = dateHourComp(date: date2, baseDate: date1)
            print("issame \(isSame)")
        }()

        
        ///
        let _ = {
            let calendar = Calendar.init(identifier: .gregorian)
            let timeZone = TimeZone.init(identifier: "Asia/Tokyo")
            
            let dateComponests = DateComponents.init(calendar: calendar, timeZone: timeZone, year: 2019, month: 5, day: 15, hour: 11, minute: 0, second: 0 ,nanosecond: 0)
            
            let dateComponests2 = DateComponents.init(calendar: calendar, timeZone: timeZone, year: 2019, month: 5, day: 15, hour: 11, minute: 45, second: 0 ,nanosecond: 0)
            
            guard let date1 = dateComponests.date,
                let date2 = dateComponests2.date else { return }

            let isSame = dateHourComp(date: date2, baseDate: date1)
            
            print("issame \(isSame)")
        }()
        
        

    }

    func dateHourComp(date: Date, baseDate: Date) -> Bool {
        let dateUT = date.timeIntervalSince1970
        let baseDateUT = baseDate.timeIntervalSince1970
        let isSameHour = (baseDateUT <= dateUT && dateUT < baseDateUT + 3600)
        return isSameHour
    }
    
    
}

