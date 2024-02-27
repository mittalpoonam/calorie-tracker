//
//  CommonFuncs.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 18/02/24.
//

import Foundation

class CommonFuncs: NSObject {
    
    
    class func dateFormatting(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    
    class func calculateCaloriesOutDuringActivities(metValue: Float, weight: Float, startDate: Date, endDate: Date) -> Float {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
        
        if let durationInMinutes = components.minute {
            let durationInHours = Float(durationInMinutes) / 60.0 // Convert minutes to hours
            let calorieOut = metValue * weight * durationInHours
            return calorieOut
        }
        return 0.0
    }
    
    
}
