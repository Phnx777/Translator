//
//  HistoryRouter.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol HistoryRouterProtocol: class {
    var dataStore: HistoryDataStore? { get set }
    func openTranslation()
}

class HistoryRouter: HistoryRouterProtocol {
    var dataStore: HistoryDataStore?
    
    weak var viewController: HistoryTableViewController!
    init(viewController: HistoryTableViewController) {
        self.viewController = viewController
    }
    
    func openTranslation() { 
        guard let tab = viewController.tabBarController,
            let destinationVC = tab.viewControllers?.first as? TranslatorViewController,
            var destinationDS = destinationVC.presenter?.router?.dataStore,
            let dataStore = dataStore else {
            return
        }
        
        passDataToTranslator(dataStore: dataStore,
                             destionation: &destinationDS)
        tab.selectedIndex = 0
    }
    
    func passDataToTranslator(dataStore: HistoryDataStore,
                              destionation: inout TranslatorDataStore) {
        destionation.word = dataStore.word
    }
}
