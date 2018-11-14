//
//  HistoryConfigurator.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol HistoryConfiguratorProtocol: class {
    func configure(with viewController: HistoryTableViewController)
}

class HistoryConfigurator: HistoryConfiguratorProtocol {
    func configure(with viewController: HistoryTableViewController) {
        let presenter = HistoryPresenter(view: viewController)
        let interactor = HistoryInteractor(presenter: presenter)
        let router = HistoryRouter(viewController: viewController)
        router.dataStore = interactor
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
