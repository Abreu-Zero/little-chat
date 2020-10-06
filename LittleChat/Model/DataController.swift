//
//  DataController.swift
//  MemeGenerator
//
//  Created by Henrique Abreu on 24/08/2020.
//  Copyright © 2020 Henrique Abreu. All rights reserved.
//

import CoreData
import Foundation

class DataController{
    let persistentContainer : NSPersistentContainer
        
    var viewContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
        
        
    init(modelName: String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores{storeDescriptio, error in
            guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            
            completion?()
        }
    }
    
    func autoSave(interval: TimeInterval){
        if viewContext.hasChanges{
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSave(interval: interval)
        }
    }
    
}
