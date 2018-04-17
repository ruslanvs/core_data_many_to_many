//
//  DataModel.swift
//  core_data_many_to_many
//
//  Created by Ruslan Suvorov on 4/17/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit
import CoreData

class PersonModel {
    private var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    private var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )
    
    static let shared = PersonModel()

    func getAll() -> [Person]{
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Person" )

        do{
            return try managedObjectContext.fetch( request ) as! [Person]
        } catch {
            print( error )
            return []
        }
    }
    
    func create( name: String ) -> Person {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Person", into: managedObjectContext) as! Person
        item.name = name
        saveContext()
        return item
    }
    
    func delete( _ item: Person ) {
        managedObjectContext.delete(item)
        saveContext()
    }
    
    func saveContext(){
        appDelegate.saveContext()
    }
}

class LanguageModel {
    private var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    private var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )
    
    static let shared = LanguageModel()
    
    func getAll() -> [Language]{
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Language" )
        
        do{
            return try managedObjectContext.fetch( request ) as! [Language]
        } catch {
            print( error )
            return []
        }
    }
    
    func create( name: String ) -> Language {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Language", into: managedObjectContext) as! Language
        item.name = name
        saveContext()
        return item
    }
    
    func delete( _ item: Language ) {
        managedObjectContext.delete(item)
        saveContext()
    }
    
    func saveContext(){
        appDelegate.saveContext()
    }

}

class ScoreModel {
    private var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    private var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )
    
    static let shared = ScoreModel()
    
    func getAll( for language: Language? = nil ) -> [Score]{
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Score" )
        
//        request.predicate = NSPredicate( format: "language = %@", language as! CVarArg )
        
        do{
            return try managedObjectContext.fetch( request ) as! [Score]
        } catch {
            print( error )
            return []
        }
    }
    
    func create( person: Person, language: Language, score: Double ) -> Score {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Score", into: managedObjectContext) as! Score
        item.person = person
        item.language = language
        item.score = score
        saveContext()
        return item
    }
    
    func delete( _ item: Score ) {
        managedObjectContext.delete(item)
        saveContext()
    }

    func saveContext(){
        appDelegate.saveContext()
    }


}
