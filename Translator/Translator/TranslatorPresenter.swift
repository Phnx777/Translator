//
//  TranslatorPresenter.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol TranslatorPresenterProtocol: class {
    var router: TranslatorRouterProtocol! { set get }
    func configureView()
    func reverseDirection()
    func translate(text: String)
    func setTranslation(with text: String)
    func showAlertView(with text: String)
    func updateDirections()
    func checkNewLanguages()
    func checkAutoFill()
    func showLoader()
    func hideLoader()
}

class TranslatorPresenter: TranslatorPresenterProtocol {
    
    var languageDirections = [String]()
    
    var router: TranslatorRouterProtocol!
    weak var view: TranslatorViewProtocol!
    var interactor: TranslatorInteractorProtocol!
    
    required init(view: TranslatorViewProtocol) {
        self.view = view 
    }
    
    func configureView() {
        view.setTranslation(with: "")
        interactor.getLanguages()
    }
    
    func reverseDirection() {
        languageDirections = languageDirections.reversed()
        updateDirections()
    }
    
    func checkNewLanguages() {
        if let left = router?.dataStore?.leftLanguage,
            let right = router?.dataStore?.rightLanguage {
            languageDirections = [left, right]
        } else {
            languageDirections = interactor.languageDirections
        }
    }
    
    func updateDirections() {
        guard languageDirections.count == 2,
            let leftValue = languageDirections.first,
            let rightValue = languageDirections.last else {
                return
        }
        view.changeLeftLanguageButton(title: leftValue)
        view.changeRightLanguageButton(title: rightValue)
    }
    
    func translate(text: String) {
        guard languageDirections.count == 2,
            let leftValue = languageDirections.first,
            let rightValue = languageDirections.last,
            let leftCode = interactor.getLanguage(by: leftValue)?.code,
            let rightCode = interactor.getLanguage(by: rightValue)?.code else {
                return
        }
        interactor.translate(word: text,
                             fromLang: leftCode,
                             toLang: rightCode)
    }
    
    func setTranslation(with text: String) {
        view.setTranslation(with: text)
    }
    
    func showAlertView(with text: String) {
        view.showAlertView(with: text)
    }
    
    func checkAutoFill() {
        guard let word = router.dataStore?.word,
            let original = word.original,
            let translation = word.translation else {
            return
        }
        setTranslation(with: translation)
        view.setOriginal(with: original)
        router.dataStore?.word = nil
    }
    
    func showLoader() {
        view.showLoader()
    }
    
    func hideLoader() {
        view.hideLoader()
    }

}
