//
//  StorageService.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit
import CoreData

protocol StorageServiceProtocol: class {
    func add(language: Language)
    func getLanguages() -> [Language]?
    
    func add(word: Word)
    func deleteAllWords()
    func getWords() -> [Word]?
}

class StorageService: StorageServiceProtocol {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext!
    
    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    
    func add(language: Language) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Languages", in: context) else {
            return
        }
        let newLang = NSManagedObject(entity: entity, insertInto: context)
        newLang.setValue(language.name, forKey: "name")
        newLang.setValue(language.code, forKey: "code")
        
        saveContext()
    }
    
    func getLanguages() -> [Language]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Languages")
        request.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject],
                result.count > 0 else {
                return nil
            }
            var languages = [Language]()
            result.forEach { (data) in
                guard let code = data.value(forKey: "code") as? String,
                    let name = data.value(forKey: "name") as? String else {
                        return
                }
                languages.append(Language(name: name, code: code))
            }
            return languages
        } catch {
            return nil
        }
    }
    
    func add(word: Word) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Words", in: context) else {
            return
        }
        let newLang = NSManagedObject(entity: entity, insertInto: context)
        newLang.setValue(word.original, forKey: "original")
        newLang.setValue(word.translation, forKey: "translation")
        
        saveContext()
    }
    
    func deleteAllWords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            
        } catch {
            print("Словарь не удалился")
        }
    }
    
    func getWords() -> [Word]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        request.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject],
                result.count > 0 else {
                    return nil
            }
            var languages = [Word]()
            result.forEach { (data) in
                guard let original = data.value(forKey: "original") as? String,
                    let translation = data.value(forKey: "translation") as? String else {
                        return
                }
                languages.append(Word(original: original, translation: translation))
            }
            return languages
        } catch {
            return nil
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Данные не сохранились")
        }
    }
    
}
