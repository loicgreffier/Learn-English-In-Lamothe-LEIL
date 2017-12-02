//
//  ModeleTheme.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 07/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import Foundation

class ModeleTheme {

    let dalTheme = DALTheme()
    
    func getThemeAndVocabulary(identifier: String) -> Theme {
        
        return dalTheme.getThemeAndVocabulary(identifier: identifier)
    }
    
    func getAllThemes() -> [Theme] {
     
        return dalTheme.getAllThemes()
    }
}
