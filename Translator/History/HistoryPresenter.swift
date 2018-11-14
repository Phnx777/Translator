//
//  HistoryPresenter.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol HistoryPresenterProtocol: class {
    var router: HistoryRouter! { set get }
    var filteredWords: [String] { set get }
    func updateWords()
    func deleteAllWords()
    func searchWord(by str: String)
    func process(word: String)
}

class HistoryPresenter: HistoryPresenterProtocol {
    private let separator = " - "
    var words = [String]() {
        didSet {
            filteredWords = words
            view.reloadData()
        }
    }
    
    var filteredWords = [String]()
    
    var router: HistoryRouter!
    weak var view: HistoryViewProtocol!
    var interactor: HistoryInteractorProtocol!
    
    required init(view: HistoryViewProtocol) {
        self.view = view
    }
    
    func process(word: String) {
        router.dataStore?.word = interactor.createWord(by: word,
                                                       separator: separator)
    }
    
    func updateWords() {
        words = []
        guard let allWords = interactor.getAllWords() else {
            return
        }
        words = allWords.map { $0.original + separator + $0.translation }
    }
    
    func deleteAllWords() {
        interactor.deleteAllWords()
        updateWords()
    }
    
    func searchWord(by str: String) {
        filteredWords = words.filter { (word) -> Bool in
            return word.lowercased().contains(str.lowercased())
        }
        view.reloadData()
    }

}
