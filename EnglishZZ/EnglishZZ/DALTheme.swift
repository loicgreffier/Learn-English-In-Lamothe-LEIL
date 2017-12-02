//
//  DALTheme.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 07/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import Foundation

class DALTheme {
    
    func getThemeAndVocabulary(identifier: String) -> Theme {
        
        var theme: Theme!
        
        switch identifier {
         
        case "Animals" :
            
            theme = Theme(name: "Animals", imageName: "dog", soundName: "dog")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Bear", imageName: "bear", soundName: "bear"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Beavel", imageName: "beavel", soundName: "beavel"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Cat", imageName: "cat", soundName: "cat"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Cow", imageName: "cow", soundName: "cow"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Dog", imageName: "dog", soundName: "dog"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Elephant", imageName: "elephant", soundName: "elephant"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Giraffe", imageName: "giraffe", soundName: "giraffe"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Hippopotamus", imageName: "hippopotamus", soundName: "hippopotamus"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Lion", imageName: "lion", soundName: "lion"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Mouse", imageName: "mouse", soundName: "mouse"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Owl", imageName: "owl", soundName: "owl"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Panther", imageName: "panther", soundName: "panther"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Pig", imageName: "pig", soundName: "pig"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Sheep", imageName: "sheep", soundName: "sheep"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Squirrel", imageName: "squirrel", soundName: "squirrel"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Tiger", imageName: "tiger", soundName: "tiger"))

            break
            
            
        case "Sea" :
            
            theme = Theme(name: "Sea", imageName: "seal", soundName: "seal")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Dolphin", imageName: "dolphin", soundName: "dolphin"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Fish", imageName: "fish", soundName: "fish"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Hippocampus", imageName: "hippocampus", soundName: "hippocampus"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Orca", imageName: "orca", soundName: "orca"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Seal", imageName: "seal", soundName: "seal"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Sea Turtle", imageName: "sea_turtle", soundName: "seaTurtle"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Shark", imageName: "shark", soundName: "shark"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Swordfish", imageName: "swordfish", soundName: "swordfish"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Whale", imageName: "whale", soundName: "whale"))

            break
            
        case "Cities" :
            
            theme = Theme(name: "Cities", imageName: "london", soundName: "london")
            theme.addVocabulary(vocabulary: Vocabulary(name: "London", imageName: "london", soundName: "london"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Moscow", imageName: "moscow", soundName: "moscow"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "New York", imageName: "newYork", soundName: "newYork"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Paris", imageName: "paris", soundName: "paris"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Rome", imageName: "rome", soundName: "rome"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Sydney", imageName: "sydney", soundName: "sydney"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Tokyo", imageName: "tokyo", soundName: "tokyo"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Washington", imageName: "washington", soundName: "washington"))

            break
            
            
        case "Christmas" :
            
            theme = Theme(name: "Christmas", imageName: "SantaClaus", soundName: "Christmas")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Bells", imageName: "Bells", soundName: "Bells"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Chimney", imageName: "Chimney", soundName: "Chimney"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Presents", imageName: "Presents", soundName: "Presents"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Santa Claus", imageName: "SantaClaus", soundName: "SantaClaus"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Snowman", imageName: "Snowman", soundName: "Snowman"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Star", imageName: "Star", soundName: "Star"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Christmas Tree", imageName: "ChristmasTree", soundName: "ChristmasTree"))
            break
            
            
        case "Colors" :
            
            theme = Theme(name: "Colors", imageName: "blue", soundName: "blue")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Black", imageName: "black", soundName: "black"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Blue", imageName: "blue", soundName: "blue"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Brown", imageName: "brown", soundName: "brown"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Green", imageName: "green", soundName: "green"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Grey", imageName: "grey", soundName: "grey"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Orange", imageName: "orange", soundName: "orange"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Pink", imageName: "pink", soundName: "pink"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Purple", imageName: "purple", soundName: "purple"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Red", imageName: "red", soundName: "red"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "White", imageName: "white", soundName: "white"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Yellow", imageName: "yellow", soundName: "yellow"))

            break
            

        case "Disney" :
            
            theme = Theme(name: "Disney", imageName: "snowWhite", soundName: "SnowWhite")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Ariel", imageName: "Ariel", soundName: "Ariel"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Aurora", imageName: "Aurora", soundName: "Aurora"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Belle", imageName: "Belle", soundName: "Belle"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Rapunzel", imageName: "Rapunzel", soundName: "Rapunzel"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Snow White", imageName: "snowWhite", soundName: "SnowWhite"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Cinderella", imageName: "cinderella", soundName: "Cinderella"))
            break
            
            
        case "School" :
            
            theme = Theme(name: "School", imageName: "School", soundName: "School")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Book", imageName: "Book", soundName: "Book"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Pen", imageName: "Pen", soundName: "Pen"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Pencil case", imageName: "PencilCase", soundName: "PencilCase"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "School bag", imageName: "SchoolBag", soundName: "SchoolBag"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Scissors", imageName: "Scissors", soundName: "Scissors"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "School", imageName: "School", soundName: "School"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Glue", imageName: "Glue", soundName: "Glue"))
            break
            
            
        case "Feelings" :
            
            theme = Theme(name: "Feelings", imageName: "happy", soundName: "happy")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Aggressive", imageName: "aggressive", soundName: "aggressive"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Angry", imageName: "Angry", soundName: "angry"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Anxious", imageName: "anxious", soundName: "anxious"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Bored", imageName: "bored", soundName: "bored"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Confused", imageName: "confused", soundName: "confused"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Embarassed", imageName: "embarassed", soundName: "embarassed"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Excited", imageName: "excited", soundName: "excited"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Frustrated", imageName: "frustrated", soundName: "frustrated"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Happy", imageName: "happy", soundName: "happy"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Hurt", imageName: "hurt", soundName: "hurt"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Sad", imageName: "sad", soundName: "sad"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Scared", imageName: "Scared", soundName: "scared"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Sick", imageName: "sick", soundName: "sick"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Surprised", imageName: "surprised", soundName: "surprised"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Tired", imageName: "tired", soundName: "tired"))

            break
            
        case "Medieval" :
            theme = Theme(name: "Medieval", imageName: "castle", soundName: "castle")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Bow", imageName: "bow", soundName: "bow"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Castle", imageName: "castle", soundName: "castle"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Crossbow", imageName: "crossbow", soundName: "crossbow"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Crown", imageName: "crown", soundName: "crown"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Drawbridge", imageName: "drawbridge", soundName: "drawbridge"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Horseman", imageName: "horseman", soundName: "horseman"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "King", imageName: "king", soundName: "king"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Queen", imageName: "queen", soundName: "queen"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Soldier", imageName: "soldier", soundName: "soldier"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Sword", imageName: "sword", soundName: "sword"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Tower", imageName: "tower", soundName: "tower"))

            break
            
            
        case "Jobs" :
            
            theme = Theme(name: "Jobs", imageName: "postman", soundName: "postman")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Actor", imageName: "actor", soundName: "actor"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Baker", imageName: "baker", soundName: "baker"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Butcher", imageName: "butcher", soundName: "butcher"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Doctor", imageName: "doctor", soundName: "doctor"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Fireman", imageName: "fireman", soundName: "fireman"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Nurse", imageName: "nurse", soundName: "nurse"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Policeman", imageName: "policeman", soundName: "policeman"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Postman", imageName: "postman", soundName: "postman"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Teacher", imageName: "teacher", soundName: "teacher"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Waiter", imageName: "waiter", soundName: "waiter"))

            break
           
            
        case "Numbers" :
            
            theme = Theme(name: "Numbers", imageName: "1", soundName: "1")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Zero", imageName: "0", soundName: "0"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "One", imageName: "1", soundName: "1"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Two", imageName: "2", soundName: "2"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Three", imageName: "3", soundName: "3"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Four", imageName: "4", soundName: "4"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Five", imageName: "5", soundName: "5"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Six", imageName: "6", soundName: "6"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Seven", imageName: "7", soundName: "7"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Eight", imageName: "8", soundName: "8"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Nine", imageName: "9", soundName: "9"))

            break
            
        case "Positions" :
            
            theme = Theme(name: "Positions", imageName: "in", soundName: "in")
            theme.addVocabulary(vocabulary: Vocabulary(name: "Behind", imageName: "behind", soundName: "behind"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Between", imageName: "between", soundName: "between"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "In", imageName: "in", soundName: "in"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "In Front of", imageName: "InFrontOf", soundName: "inFrontOf"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Next To", imageName: "NextTo", soundName: "nextTo"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "On", imageName: "on", soundName: "on"))
            theme.addVocabulary(vocabulary: Vocabulary(name: "Under", imageName: "under", soundName: "under"))
            break
            
        default : break

        }
    
        return theme
    }

    func getAllThemes() -> [Theme] {
        
        var listTheme = [Theme]()
        
        listTheme.append(Theme(name: "Animals", imageName: "dog", soundName: "dog"))
        listTheme.append(Theme(name: "Sea", imageName: "seal", soundName: "seal"))
        listTheme.append(Theme(name: "Cities", imageName: "london", soundName: "london"))
        listTheme.append(Theme(name: "Christmas", imageName: "SantaClaus", soundName: "Christmas"))
        listTheme.append(Theme(name: "Colors", imageName: "blue", soundName: "blue"))
        listTheme.append(Theme(name: "School", imageName: "School", soundName: "School"))
        listTheme.append(Theme(name: "Feelings", imageName: "happy", soundName: "happy"))
        listTheme.append(Theme(name: "Medieval", imageName: "castle", soundName: "castle"))
        listTheme.append(Theme(name: "Jobs", imageName: "postman", soundName: "postman"))
        listTheme.append(Theme(name: "Disney", imageName: "snowWhite", soundName: "snowWhite"))
        listTheme.append(Theme(name: "Numbers", imageName: "1", soundName: "1"))
        listTheme.append(Theme(name: "Positions", imageName: "in", soundName: "in"))
        //listTheme.append(Theme(name: "Test", imageName: "in", soundName: "in"))

        return listTheme
    }
}
