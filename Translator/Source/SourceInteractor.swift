//
//  SourceInteractor.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol SourceDataStore {
    var direction: Direction { get set }
    var selectedLanguage: String? { get set }
    func getLanguages() -> [Language]?
}

protocol SourceInteractorProtocol: class {
    func getLanguages() -> [Language]?
}

class SourceInteractor: SourceInteractorProtocol, SourceDataStore {
    
    weak var presenter: SourcePresenterProtocol!
    let storageService: StorageServiceProtocol = StorageService()
    let serverService: ServerServiceProtocol = ServerService()
    var languageService: LanguageServiceProtocol = LanguageService()
    var selectedLanguage: String?
     
    var direction: Direction = .unknown 
    
    required init(presenter: SourcePresenterProtocol) {
        self.presenter = presenter
    }
    
    func getLanguages() -> [Language]? {
       return storageService.getLanguages()
    }
}
