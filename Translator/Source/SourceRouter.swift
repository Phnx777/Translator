//
//  SourceRouter.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol SourceRouterProtocol: class {
    var dataStore: SourceDataStore? { get set }
    func routeToTranslator()
}

class SourceRouter: SourceRouterProtocol {
     
    var dataStore: SourceDataStore?
    
    weak var viewController: SourceViewController!
    
    init(viewController: SourceViewController) {
        self.viewController = viewController
    }
    
    func routeToTranslator() {
        guard let tab = viewController.presentingViewController as? UITabBarController,
            let destinationVC = tab.viewControllers?.first as? TranslatorViewController,
            var destinationDS = destinationVC.presenter?.router?.dataStore,
            let ds = dataStore else {
                return
        }
        
        passDataToTranslator(dataStore: ds,
                             destionation: &destinationDS)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func passDataToTranslator(dataStore: SourceDataStore,
                          destionation: inout TranslatorDataStore) {
        guard let lang = dataStore.selectedLanguage else {
            return
        }
        switch destionation.direction {
        case .left:
            destionation.leftLanguage = lang
        case .right:
            destionation.rightLanguage = lang
        default:
            break
        }
        
    }
}
