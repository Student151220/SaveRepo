//
//  DataBaseManager.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation
import UIKit
import CoreData

// Tego można użyć zamiast tego Result<String, Error> żeby nie zwracać jakiegoś dziwnego, niepotrzebnego tekstu.
enum VoidResult<E: Error> {
    case success
    case failure(E)
}


final class DataBaseManager{
    
    // To się może scraschować, nie powinno się wyciągać kontekstu z app delegate, lepiej stworzyć własny
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
            // ten completion powinien być tutaj
            completion(.success("Zapisano"))
        }catch{
            completion(.failure(error))
        }
       
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
            completion(.success("Usunięto"))
        }catch{
            completion(.failure(error))
        }
        
    }
    
    // To jest takie mało reużywalne, jakbyś chciał mieć inny predykat, to byś pewnie powielał metody
    func loadRecords(text:String, completion: @escaping ((Result<[ItemDataBase], Error>) -> Void)){
        let request : NSFetchRequest<ItemDataBase> = ItemDataBase.fetchRequest()
        request.predicate = NSPredicate(format: "name Contains[cd]%@", text)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        var itemsArray = [ItemDataBase]()
        do{
            try itemsArray = context.fetch(request)
            completion(.success(itemsArray))
        }catch{
            completion(.failure(error))
        }
        
    }
    
    // To już jest dużo bardziej generyczne niż poprzednie
    func fetchData(using query: QueryType, completion: @escaping (Result<[ItemDataBase], Error>) -> Void) {
        let request : NSFetchRequest<ItemDataBase> = ItemDataBase.fetchRequest()
        request.predicate = query.predicate
        request.sortDescriptors = query.sortDescriptors
        do {
            let itemsArray = try context.fetch(request)
            completion(.success(itemsArray))
        } catch {
            completion(.failure(error))
        }
    }
    
    // Ale co by było jakbyś miał zapisać różne obiekty? Będziesz drugiego menadżera pisał? Pasuje zrobic takie coś zarówno dla zapisu jak i odczytu?
    func fetchData<T: NSManagedObject>(using query: QueryType, completion: @escaping (Result<[T], Error>) -> Void) {
        let request : NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = query.predicate
        request.sortDescriptors = query.sortDescriptors
        
        do {
            let itemsArray = try context.fetch(request)
            completion(.success(itemsArray))
        } catch {
            completion(.failure(error))
        }
    }
    
}

protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [NSSortDescriptor] { get }
}

enum GettingItemsByNameQuery: QueryType {
    case itemName(String)
    
    var predicate: NSPredicate? {
        guard case .itemName(let name) = self else { return nil }
        return NSPredicate(format: "name Contains[cd]%@", name)
    }
    
    var sortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
    
}
