//
//  SourceConfigurator.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol SourceConfiguratorProtocol: class {
    func configure(with viewController: SourceViewController)
}

class SourceConfigurator: SourceConfiguratorProtocol {
    
    func configure(with viewController: SourceViewController) {
        let presenter = SourcePresenter(view: viewController)
        let interactor = SourceInteractor(presenter: presenter)
        let router = SourceRouter(viewController: viewController)
        router.dataStore = interactor
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
