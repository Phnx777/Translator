//
//  HistoryTableViewController.swift
//  Translator
//
//  Created by Имал Фарук on 11/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol HistoryViewProtocol: class {
    func showAlertView(text: String)
    func reloadData()
}

class HistoryTableViewController: UITableViewController,
HistoryViewProtocol {
 
    let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: HistoryPresenterProtocol!
    var configurator: HistoryConfigurator = HistoryConfigurator()
    let cellId = "sourceCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self) 
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: cellId)
  
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Очистить",
                                                                 style: .plain, target: self,
                                                                 action: #selector(deleteAllWords))
        
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateWords()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти слово"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc func deleteAllWords() {
        presenter.deleteAllWords()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filteredWords.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?  = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.textLabel?.text = presenter.filteredWords[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.process(word: presenter.filteredWords[indexPath.row])
        presenter.router.openTranslation()
    }
    
    func showAlertView(text: String) {
        showAlertView(with: text)
    }

}

extension HistoryTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count > 0 else {
            presenter.updateWords()
            return
        }
        presenter.searchWord(by: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.updateWords()
    }
}
