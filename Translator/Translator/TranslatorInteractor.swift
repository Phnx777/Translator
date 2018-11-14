//
//  TranslatorInteractor.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol TranslatorDataStore {
    var word: Word? { set get }
    var leftLanguage: String { set get }
    var rightLanguage: String { set get }
}

protocol TranslatorInteractorProtocol: class {
    func translate(word: String,
                   fromLang: String,
                   toLang: String)
    func getLanguages()
    func getLanguage(by name: String) -> Language?
    
    var languageDirections :[String] { set get }
    
}

class TranslatorInteractor: TranslatorInteractorProtocol,
TranslatorDataStore {
    var word: Word?
    
    var languageDirections: [String]
    
    var rightLanguage: String
    var leftLanguage: String
    
    weak var presenter: TranslatorPresenterProtocol!
    let serverService: ServerServiceProtocol = ServerService()
    let storageService: StorageServiceProtocol = StorageService()
    let languageService: LanguageServiceProtocol = LanguageService()
    required init(presenter: TranslatorPresenterProtocol) {
        self.presenter = presenter
        rightLanguage = languageService.rightLanguage.name
        leftLanguage = languageService.leftLanguage.name
        languageDirections = [leftLanguage, rightLanguage]
    }
    
    func getLanguage(by name: String) -> Language? {
        return languageService.getLanguage(by: name)
    }
    
    func translate(word: String, fromLang: String,
                   toLang: String) {
        presenter.showLoader()
        serverService.translate(word: word, fromLang: fromLang,
                                toLang: toLang) { [weak self] (dict, error) in
                                    guard let textArray = dict?["text"] as? [String],
                                        textArray.count > 0,
                                        let text = textArray.first else {
                                            guard let errorMessage = dict?["message"] as? String else {
                                                self?.presenter.hideLoader()
                                                self?.presenter.showAlertView(with: "Произошла ошибка")
                                                return
                                            }
                                            self?.presenter.hideLoader()
                                            self?.presenter.showAlertView(with: errorMessage)
                                        return
                                    }
                                    self?.presenter.hideLoader()
                                    self?.storageService.add(word: Word(original: word,
                                                                        translation: text))
                                    self?.presenter.setTranslation(with: text)
            
        }
    }
    
    func getLanguages() {
        if let languages = storageService.getLanguages(),
            languages.count > 0 {
            print("Языки в хранилище")
        } else {
            presenter.showLoader()
            serverService.getLanguages {  [weak self] (dict, error) in
                self?.presenter.hideLoader()
                guard let dictionary = dict?["langs"] as? Dictionary<String, String> else {
                    self?.presenter.showAlertView(with: "Проблема загрузки языков")
                    return
                }
                self?.languageService.saveAllLanguages(with: dictionary)
            }
        }
    }
}
