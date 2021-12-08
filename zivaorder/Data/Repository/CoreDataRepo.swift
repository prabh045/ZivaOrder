//
//  CoreDataRepo.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 08/12/21.
//
import UIKit
import CoreData

class CoreDataRepo: CoreDataRepo {
    
    func saveProduct(product: Products) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No app delegate")
        }
        let managedContext = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        do {
            let data = try JSONEncoder().encode(product)
            managedObject.setValue(data, forKey: "productData")
            try managedContext.save()
            print("Gadget saved successfully")
        } catch (let error) {
            print("Error saving gadget \(error.localizedDescription)")
        }
    }
    
    func retrieveProducts() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("no app delegate found")
        }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "Product")
        do {
            let tasks = try managedcontext.fetch(fetchRequest)
            print("Products fetched successfully", [tasks])
            return tasks
        } catch  {
            print("Could not fetch tasks")
            return []
        }
    }
}
