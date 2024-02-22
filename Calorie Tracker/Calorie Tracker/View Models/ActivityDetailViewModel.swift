//
//  ActivityDetailViewModel.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 15/02/24.
//

import Foundation
import CoreData


class ActivityDetailViewModel: ObservableObject {
    
    @Published var activities: [Activity] = [Activity]()
    
    var date: Date = Date()
    @Published var activityName: String = "Bicycling"
    var activityDesc: String = ""
    var metValue: String = ""
    var startTime: Date = Date()
    var endTime: Date = Date()
    var userId: String = ""
    var calorieOut: String = ""
    
    init(){
        getAllActivities()
    }
    func save() {
        let activity = Activity(context: CoreDataManager.shared.viewContext)
        activity.date = date
        activity.activityName = activityName
        activity.activityDesc = activityDesc
        activity.metValue = metValue
        activity.startTime = startTime
        activity.endTime = endTime
        activity.userId = userId
        activity.calorieOut = calorieOut
        CoreDataManager.shared.save()
    }
    
    func getAllActivities() {
        activities = CoreDataManager.shared.getAllActivities()
    }
}
