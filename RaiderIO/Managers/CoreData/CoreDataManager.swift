//
//  CoreDataManager.swift
//  RaiderIO
//
//  Created by baris on 13.03.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func getAllCharacters() -> [SavedCharacter] {
        let fetchRequest: NSFetchRequest<SavedCharacter> = SavedCharacter.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveCharacter(character: Character) {
        let savedCharacter = SavedCharacter(context: persistentContainer.viewContext)
        savedCharacter.name = character.name
        savedCharacter.realm = character.realm
        savedCharacter.region = character.region
        savedCharacter.imageUrl = character.thumbnailURL
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save character \(error)")
        }
    }
    
    func deleteCharacter(savedCharacter: SavedCharacter) {
        persistentContainer.viewContext.delete(savedCharacter)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func checkIfCharacterExists(name: String) -> Bool {
        let request : NSFetchRequest<SavedCharacter> = SavedCharacter.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        request.fetchLimit = 1
        do{
            let count = try persistentContainer.viewContext.count(for: request)
            if(count == 0){ return false }
            else { return true }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return false
        }
    }
}
