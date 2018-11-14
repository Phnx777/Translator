//
//  LanguageService.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol LanguageServiceProtocol {
    var leftLanguage: Language { set get }
    var rightLanguage: Language { set get }
    func saveAllLanguages(with dict: [String: String])
    var direction: Direction  { get set }
    func getLanguage(by name: String) -> Language?
}

enum Direction {
    case unknown
    case left
    case right
}

class LanguageService: LanguageServiceProtocol {
    var direction: Direction = .unknown
    
    var leftLanguage: Language
    var rightLanguage: Language
    
    init() {
        leftLanguage = Language.defaultLeftLanguage()
        rightLanguage = Language.defaultRightLanguage()
    }
    
    private let storageService: StorageServiceProtocol = StorageService()
    
    func saveAllLanguages(with dict: [String: String]) {
        dict.forEach { [weak self] (code, name) in
            self?.storageService.add(language: Language(name: name,
                                                        code: code))
        }
        guard let languages = storageService.getLanguages(),
            languages.count > 0 else {
            return
        }
    }
    
    func getLanguage(by name: String) -> Language? {
        guard let languages = storageService.getLanguages() else {
            return nil
        }
        let result = languages.filter { $0.name == name }
        if result.count == 1 {
            return result.first
        }
        return nil
    }
    
}
