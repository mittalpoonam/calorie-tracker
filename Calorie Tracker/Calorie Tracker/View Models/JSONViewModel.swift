//
//  JSONViewModel.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 21/02/24.
//

import SwiftUI

class JSONViewModel: ObservableObject {
    @Published var foodCalorie: foodCalorieModel
    @Published var metValues: MetValuesModel
 
    
    init(){
        self.foodCalorie = [FoodCalorieModel(id: 1, name: "poonam", foodGroup: FoodGroup.americanIndian, calories: 12.23, fatG: 12.43, proteinG: 12.43, carbohydrateG: 12.3, servingDescription1G: "hello")]
        
        
        self.metValues = MetValuesModel(sheet1: [Sheet1(activity: ParticularActivity.conditioningExercise, specificMotion: "motion", meTs: 12.12)])
        
       // self.fetchDataFromFoodJSON()
        //self.fetchDataFromActivityJSON()
    }
    
    func fetchDataFromFoodJSON(completion: @escaping (foodCalorieModel?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let url = Bundle.main.url(forResource: "food-calorie", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let foodCalorieModel = try decoder.decode(foodCalorieModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(foodCalorieModel)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                print("JSON file not found")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    
//    func fetchDataFromFoodJSON()  {
//        DispatchQueue.global(qos: .background).async {
//                   if let url = Bundle.main.url(forResource: "food-calorie", withExtension: "json") {
//                       do {
//                           let data = try Data(contentsOf: url)
//                           let decoder = JSONDecoder()
//                           let foodCalorieModel = try decoder.decode(foodCalorieModel.self, from: data)
//                           DispatchQueue.main.async {
//                               self.foodCalorie = foodCalorieModel
//                           }
//
//                           //print(foodCalorieModel)
//
//                       } catch {
//                           print("Error decoding JSON: \(error)")
//                       }
//                   }
////            else {
////                       print("JSON file not found")
////                   }
//               }
//           }
        
    func fetchDataFromActivityJSON(completion: @escaping (MetValuesModel?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let url = Bundle.main.url(forResource: "met-values", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let metValueModel = try decoder.decode(MetValuesModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(metValueModel)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                let error = NSError(domain: "YourAppDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

//    func fetchDataFromActivityJSON() {
//        DispatchQueue.global(qos: .background).async {
//                 if let url = Bundle.main.url(forResource: "met-values", withExtension: "json") {
//                     do {
//                         let data = try Data(contentsOf: url)
//                         let decoder = JSONDecoder()
//                         let metValueModel = try decoder.decode(MetValuesModel.self, from: data)
//                         DispatchQueue.main.async {
//                             self.metValues = metValueModel
//                         }
//
//                         //print(metValueModel)
//                     } catch {
//                         print("Error decoding JSON: \(error)")
//                     }
//                 } else {
//                     print("JSON file not found")
//                 }
//             }
//         }
    
}

