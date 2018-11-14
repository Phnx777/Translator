//
//  TranslatorConfigurator.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol TranslatorConfiguratorProtocol: class {
    func configure(with viewController: TranslatorViewController)
}

class TranslatorConfigurator: TranslatorConfiguratorProtocol {
    
    func configure(with viewController: TranslatorViewController) {
        let presenter = TranslatorPresenter(view: viewController)
        let interactor = TranslatorInteractor(presenter: presenter)
        let router = TranslatorRouter(viewController: viewController)
        router.dataStore = interactor
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
