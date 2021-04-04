//
//  DataBaseManager.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation
import UIKit
import CoreData

final class DataBaseManager{
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveRepository(item:Items, completion: @escaping ((Result<String, Error>) -> Void)){
        
        let newRecord = ItemDataBase(context: self.context)
        newRecord.id = Int32(item.id)
        newRecord.language = item.language
        newRecord.html_url = item.html_url
        newRecord.name = item.name
        newRecord.login = item.owner.login
        newRecord.stargazers_count = Int32(item.stargazers_count)
        
        do{
            try context.save()
        }catch{
            completion(.failure(error))
        }
        completion(.success("Zapisano"))
    }
    
    
    
    func loadAllRecords(completion: @escaping ((Result<[ItemDataBase], Error>) -> Void)){
        let request : NSFetchRequest<ItemDataBase> = ItemDataBase.fetchRequest()
        var itemsArray = [ItemDataBase]()
        do{
            try itemsArray = context.fetch(request)
        }catch{
            completion(.failure(error))
        }
        completion(.success(itemsArray))
    }
    
    
    func deleteRecord(item:ItemDataBase, completion: @escaping ((Result<String, Error>) -> Void)){
        
        context.delete(item)
        do{
            try context.save()
        }catch{
            completion(.failure(error))
        }
        completion(.success("Usunięto"))
    }
    
    func loadRecords(text:String, completion: @escaping ((Result<[ItemDataBase], Error>) -> Void)){
        let request : NSFetchRequest<ItemDataBase> = ItemDataBase.fetchRequest()
        request.predicate = NSPredicate(format: "name Contains[cd]%@", text)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        var itemsArray = [ItemDataBase]()
        do{
            try itemsArray = context.fetch(request)
        }catch{
            completion(.failure(error))
        }
        completion(.success(itemsArray))
    }
    
    
}
