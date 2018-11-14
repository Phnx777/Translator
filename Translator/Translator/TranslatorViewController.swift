//
//  TranslatorViewController.swift
//  Translator
//
//  Created by Имал Фарук on 11/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol TranslatorViewProtocol: class {
    func changeLeftLanguageButton(title: String)
    func changeRightLanguageButton(title: String)
    func setTranslation(with text: String)
    func setOriginal(with text: String)
    func showAlertView(with text: String)
    func showLoader()
    func hideLoader()
}

class TranslatorViewController: UIViewController, TranslatorViewProtocol {
    @IBOutlet weak var translationBackgroundView: UIView!
    
    @IBOutlet weak var leftLanguageButton: UIButton!
    @IBOutlet weak var rightLanguageButton: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var translationLabel: UILabel!
    
    let loader = UIActivityIndicatorView(style: .gray)
    
    var presenter: TranslatorPresenterProtocol!
    var configurator: TranslatorConfigurator = TranslatorConfigurator()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configurator.configure(with: self)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        configurator.configure(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
        
        translationBackgroundView.layer.cornerRadius = 10
        setupToolbar()
        setupLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.checkNewLanguages()
        presenter.updateDirections()
        presenter.checkAutoFill()
    }
    
    @IBAction func changeLeftLanguage(_ sender: UIButton) {
        presenter.router.routeSource(direction: .left)
    }
    
    @IBAction func changeRightLanguage(_ sender: UIButton) {
        presenter.router.routeSource(direction: .right)
    }
    
    @IBAction func reverseLanguages(_ sender: UIButton) {
        presenter.reverseDirection()
    }
    
    func setupToolbar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,
                                                         width: self.view.frame.size.width,
                                                         height: 30))
        let translateButton: UIBarButtonItem = UIBarButtonItem(title: "Перевести",
                                                       style: .done, target: self,
                                                       action: #selector(translate))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let closeButton: UIBarButtonItem = UIBarButtonItem(title: "Отменить",
                                                       style: .plain, target: self,
                                                       action: #selector(closeKeyboard))
        toolbar.setItems([translateButton, flexSpace, closeButton], animated: false)
        toolbar.sizeToFit()
        textfield.inputAccessoryView = toolbar
    }
    
    func changeLeftLanguageButton(title: String) {
        leftLanguageButton.setTitle(title, for: .normal)
    }
    
    func changeRightLanguageButton(title: String) {
        rightLanguageButton.setTitle(title, for: .normal)
    }
    
    func setupLoader() {
        loader.center = view.center
        view.addSubview(loader)
    }
    
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.stopAnimating()
        }
    }
     
    @objc func translate() {
        closeKeyboard()
        
        guard let text = textfield.text,
            text.count > 0 else {
            return
        }
        presenter.translate(text: text)
        
    }
    
    func setTranslation(with text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.translationLabel.text = text
        }
    }
    
    func setOriginal(with text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.textfield.text = text
        }
    }
    
}
