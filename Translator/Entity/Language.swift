//
//  Language.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

class Language: NSObject {
    var name: String!
    var code: String!
    
    required init(name: String, code: String) {
        self.name = name
        self.code = code
    }
    
    static func defaultLeftLanguage() -> Language {
        return self.init(name: "Русский", code: "ru")
    }
    
    static func defaultRightLanguage() -> Language {
        return self.init(name: "Английский", code: "en")
    }
}
