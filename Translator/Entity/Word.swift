//
//  Word.swift
//  Translator
//
//  Created by Имал Фарук on 13/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

class Word: NSObject {
    var original: String!
    var translation: String!
    
    required init(original: String, translation: String) {
        self.original = original
        self.translation = translation
    }
}
