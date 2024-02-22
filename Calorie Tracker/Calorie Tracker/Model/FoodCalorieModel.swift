//
//  FoodCalorieModel.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 21/02/24.
//

import SwiftUI

struct FoodCalorieModel: Decodable{
    
        let id: Int
        let name: String
        let foodGroup: FoodGroup
        let calories, fatG, proteinG, carbohydrateG: Double
        let servingDescription1G: String?

        enum CodingKeys: String, CodingKey {
            case id = "ID"
            case name
            case foodGroup = "Food Group"
            case calories = "Calories"
            case fatG = "Fat (g)"
            case proteinG = "Protein (g)"
            case carbohydrateG = "Carbohydrate (g)"
            case servingDescription1G = "Serving Description 1 (g)"
        }
    }

enum FoodGroup: String, Decodable {
    case americanIndian = "American Indian"
    case babyFoods = "Baby Foods"
    case bakedFoods = "Baked Foods"
    case beansAndLentils = "Beans and Lentils"
    case beverages = "Beverages"
    case breakfastCereals = "Breakfast Cereals"
    case dairyAndEggProducts = "Dairy and Egg Products"
    case fastFoods = "Fast Foods"
    case fatsAndOils = "Fats and Oils"
    case fish = "Fish"
    case foodGroupDairyAndEggProducts = "Dairy and Egg Products "
    case fruits = "Fruits"
    case grainsAndPasta = "Grains and Pasta"
    case meats = "Meats"
    case null = "NULL"
    case nutsAndSeeds = "Nuts and Seeds"
    case preparedMeals = "Prepared Meals"
    case restaurantFoods = "Restaurant Foods"
    case snacks = "Snacks"
    case soupsAndSauces = "Soups and Sauces"
    case spicesAndHerbs = "Spices and Herbs"
    case sweets = "Sweets"
    case vegetables = "Vegetables"

}
typealias foodCalorieModel = [FoodCalorieModel]



//    var id: Int
//    var name: String
//    var foodGroup: String
//    var calories: Float
//    var fat: Float
//    var protein: Float
//    var carbohydarates: Float
//    var serving: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "ID"
//        case name = "name"
//        case foodGroup = "Food Group"
//        case serving = "Serving Description 1 (g)"
//        case calories = "Calories"
//        case fat = "Fat (g)"
//        case protein = "Protein (g)"
//        case carbohydarates = "Carbohydrate (g)"
//    }
