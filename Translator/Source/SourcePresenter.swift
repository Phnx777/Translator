//
//  SourcePresenter.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol SourcePresenterProtocol: class {
    var router: SourceRouterProtocol? { get set }
    var selectedLanguage: String { get set }
    var languagesNames: [String] { get set }
    
    func showAlertView(with text: String)
    func configureView()
}

class SourcePresenter: SourcePresenterProtocol {

    var selectedLanguage: String = "" {
        didSet {
            router?.dataStore?.selectedLanguage = selectedLanguage
        }
    }
    
    var router: SourceRouterProtocol?
    weak var view: SourceViewProtocol!
    var interactor: SourceInteractorProtocol!
    var languagesNames = [String]() {
        didSet {
            view.reloadData()
        }
    }
    
    required init(view: SourceViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        guard let languages = interactor.getLanguages() else {
            view.showAlert(text: "Языки отсутствуют, попробуйте позднее")
            return
        }
        languagesNames = languages.map { $0.name }
    }
    
    func showAlertView(with text: String) {
        view.showAlert(text: text)
    }
    
}
