//
//  Theme.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 05/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import Foundation


class Theme : Vocabulary {
    
    private var tabVocabulary = [Vocabulary]()
    private var index = 100
    
    // Ajoute un élément de vocabulaire au tableau de vocabulaire du thème
    func addVocabulary(vocabulary: Vocabulary) {
        
        tabVocabulary.append(vocabulary)
    }
    
    // Retourne la taille du tableau de vocabulaire d'un thème
    func getLength() -> Int {
        
        return tabVocabulary.count
    }
    
    // Paramètre : Nombre d'éléments de vocabulaire demandé
    // On créer un tableau de vocabulaire
    // Si on dispose de plus d'élements de vocabulaire que le nombre demandé alors
        // On mélange les éléments de vocabulaire 
        // On récupère les n premiers éléments de vocabulaire
    func getVocabulary(numberOfVocab: Int) -> [Vocabulary] {
        
        var shorterTabVocab = [Vocabulary]()

        if (index + numberOfVocab - 1 >= tabVocabulary.count) {
            index = 0
            tabVocabulary.shuffle()
        }

        for _ in 0...numberOfVocab-1 {
                
            shorterTabVocab.append(tabVocabulary[index])
            index += 1
        }
        
        return shorterTabVocab
    }
}
