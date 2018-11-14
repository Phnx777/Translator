//
//  SourceViewController.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol SourceViewProtocol: class {
    func showAlert(text: String)
    func reloadData()
}

class SourceViewController: UIViewController, SourceViewProtocol {
    var presenter: SourcePresenterProtocol!
    var configurator: SourceConfigurator = SourceConfigurator()
    
    @IBOutlet weak var tableView: UITableView!
    let cellId = "sourceCell"
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        configurator.configure(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.configureView()
        view.backgroundColor = UIColor.mainYellow
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: cellId)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in 
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(text: String) {
        showAlertView(with: text)
    }
   
}


extension SourceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.languagesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?  = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.textLabel?.text = presenter.languagesNames[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedLanguage = presenter.languagesNames[indexPath.row]
        presenter.router?.routeToTranslator()
    }
}
