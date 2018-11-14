//
//  HistoryInteractor.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol HistoryDataStore {
    var word: Word? { get set }
}

protocol HistoryInteractorProtocol: class {
    func getAllWords() -> [Word]?
    func createWord(by string: String, separator: String) -> Word?
    func deleteAllWords()
}

class HistoryInteractor: HistoryInteractorProtocol, HistoryDataStore {
    
    weak var presenter: HistoryPresenterProtocol!
    let storageService: StorageServiceProtocol = StorageService()
    
    var word: Word?
    
    required init(presenter: HistoryPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getAllWords() -> [Word]? {
        return storageService.getWords()
    }
    
    func deleteAllWords() {
        storageService.deleteAllWords()
    }
    
    func createWord(by string: String,
                    separator: String) -> Word? {
        let words = string.components(separatedBy: separator)
        guard words.count == 2,
            let original = words.first,
            let translation = words.last else {
                return nil
        }
        return Word(original: original,
                    translation: translation)
    }
}
