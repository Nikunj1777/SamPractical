//
//  DataModel.swift
//  SamPractical
//
//  Created by nikunj sareriya on 04/05/22.
//

import Foundation
import CoreData
import UIKit

class DataModel: NSObject {
    static let sharedInstance = DataModel()
    
    // MARK: - Save data in coredata
    
    func saveContext() {
        DispatchQueue.main.async {
            appDelegate.saveContext()
        }
    }
    
    // MARK: - Get data from coredata
    
    func getProductData() -> [ProductDetail] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductDetail")
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [ProductDetail] {
                return result
            }
            return []
        } catch {
        }
        return []
    }
    
    // MARK: - Set data in coredata
    
    func setProductData(productData: ProductDataModel) {
        let context = appDelegate.persistentContainer.viewContext
        guard let product = NSEntityDescription.insertNewObject(forEntityName: "ProductDetail", into: context) as? ProductDetail else { return }
        product.setValue(productData.image, forKey: "image")
        product.setValue(productData.name, forKey: "name")
        product.setValue(productData.desc, forKey: "desc")
        self.saveContext()
    }
    
    // MARK: - Delete data in coredata
    
    func deleteUserDetails() -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ProductDetail")
        do {
            if let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject] {
                for entity in fetchedResults {
                    managedContext.delete(entity)
                }
                self.saveContext()
                return true
            }
            return false
        } catch {
            print("Could not delete")

        }
        return false
    }
}



