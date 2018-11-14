//
//  TranslatorRouter.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol TranslatorRouterProtocol: class {
    var dataStore: TranslatorDataStore? { get set }
    func routeSource(direction: Direction)
}

class TranslatorRouter: TranslatorRouterProtocol {
    var dataStore: TranslatorDataStore? 
    
    weak var viewController: TranslatorViewController!
    init(viewController: TranslatorViewController) {
        self.viewController = viewController
    }
    
    func routeSource(direction: Direction) {
        dataStore?.direction = direction
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "SourceViewController") as? SourceViewController,
            let vc = viewController else {
            return
        }
        
        present(vc: vc, destination: destinationVC)
    }
    
    func present(vc: TranslatorViewController,
                 destination: SourceViewController) {
        vc.present(destination, animated: true, completion: nil)
    }
}
