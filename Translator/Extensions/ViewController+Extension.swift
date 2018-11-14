//
//  ViewController+Extension.swift
//  Translator
//
//  Created by Имал Фарук on 13/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func showAlertView(with text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
