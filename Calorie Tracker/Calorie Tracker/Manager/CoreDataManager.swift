//
//  Persistence.swift
//  Calorie Tracker Using Core Data
//
//  Created by poonam mittal on 13/02/24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllUsers() -> [User]{
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        }catch {
            return []
        }
    }
    
    func getAllFoods() -> [Food]{
        let request: NSFetchRequest<Food> = Food.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        }catch {
            return []
        }
    }
    
    func getAllActivities() -> [Activity]{
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        }catch {
            return []
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CalorieTracker")
        
        persistentContainer.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error as NSError? {
           
                fatalError("Unresolved error \(error)")
            }
        })
        
    }
    
}
