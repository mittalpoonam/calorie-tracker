//
//  UserListViewModel.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 14/02/24.
//

import Foundation
import CoreData

class UserDetailViewModel: ObservableObject {
    
    @Published var users: [User] = [User]()
    
    var name: String = ""
    var weight: String = ""
    var height: String = ""
    var bmr: String = ""
    @Published var sex: String = "Male"
    var age: String = ""
    
    init(){
        getAllUsers()
    }
    func save() {
        let user = User(context: CoreDataManager.shared.viewContext)
        user.name = name
        user.height = height
        user.weight = weight
        user.sex = sex
        user.age = age
        user.bmr = bmr
        user.userId = UUID().uuidString
        CoreDataManager.shared.save()
    }
    
    func getAllUsers() {
        users = CoreDataManager.shared.getAllUsers()
    }
}

//struct UserViewModel {
//    
//    let user: User
//    
//    var id: NSManagedObjectID {
//        return user.objectID
//    }
//    
//    var name: String {
//        return user.name ?? ""
//    }
//    
//    var weight: String  {
//        return user.weight ?? ""
//    }
//    var height: String  {
//        return user.height ?? ""
//    }
//    var sex: String  {
//        return user.sex ?? ""
//    }
//    var age: String {
//        return user.age ?? ""
//    }
//}
