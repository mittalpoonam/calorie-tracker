//
//  FoodDetailViewModel.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 15/02/24.
//

import Foundation
import CoreData

class FoodDetailViewModel: ObservableObject {
    
    @Published var foods: [Food] = [Food]()
    
    var date: Date = Date()
    @Published var foodName: String = "Beans"
    @Published var mealType: String = "Breakfast"
    @Published var foodGroup: String = "Beans"
    var serving: String = ""
    var calorieIn: String = ""
    var userId: String = ""
    
    init(){
        getAllFoods()
    }
    func save() {
        let food = Food(context: CoreDataManager.shared.viewContext)
        food.date = date
        food.foodName = foodName
        food.mealType = mealType
        food.foodGroup = foodGroup
        food.serving = serving
        food.calorieIn = calorieIn
        food.userId = userId
        CoreDataManager.shared.save()
    }
    
    func getAllFoods() {
        foods = CoreDataManager.shared.getAllFoods()
    }
}
