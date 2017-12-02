//
//  Vocabulary.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 05/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import Foundation


class Vocabulary {
    
    private let name: String
    private let imageName: String
    private let soundName: String
    
    init(name: String, imageName: String, soundName: String){
        self.name = name
        self.imageName = imageName
        self.soundName = soundName
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getImageName() -> String {
        return self.imageName
    }
    
    func getSoundName() -> String {
        return self.soundName
    }
    
}
