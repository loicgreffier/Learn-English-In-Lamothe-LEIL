//
//  PutInOrderViewController.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 08/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit

class PutInOrderViewController : UIViewController{
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var imageViewHelp: UIImageView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var answerView: UIView!
    
    // Bouton reset lettres placées
    @IBOutlet weak var resetLettersButton: UIButton!
    
    // Bouton retour
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    // Nombre de mots validés
    @IBOutlet weak var numberOfValidateWord: UILabel!
    
    // Thème choisi
    var theme: Theme!
    
    // Nombre de mots que l'on veut résoudre dans l'exercice
    var numberOfVocabularyElements = 6
    
    // Coordonnées des labels
    var coordonneeX: CGFloat! = 0
    var coordonneeY: CGFloat! = 0
    var coordonneeXMixUpWord: CGFloat! = 0
    var coordonneeYMixUpWord: CGFloat! = 0
    
    var xFromCenter: CGFloat = 0
    
    // Liste de Gesture permettant de detecter le drag&drop sur un UILabel. On a besoin d'une liste car on a besoin d'une Gesture par UILabel (Une gesture contient une 
    // et une seule UILabel)
    var GestureList = [UIPanGestureRecognizer]()
    
    // Liste de points permettant de sauvegarder les coordonnées d'origine de chaque point
    var Origine = [CGPoint]()
    
    // Taille du mot courant sans espace
    var firstWordLengthSpaceLess: Int! = 0
    
    // Taille du mot avec espace
    var firstWordLength: Int! = 0
    
    // Nombre de lettre placée sur le mot à remplir
    var numberLetterSetOnBlankWord: Int! = 0
    
    // Tableau de lettres mélangées
    var mixUpWord: [String]!
    
    // Mot traité
    var wordIndex: Int! = 0
    
    // Nombre de lettres bonnes dans un mot
    var goodLetter: Int! = 0
    
    // Liste de vocabulaires
    var listVocabulary = [Vocabulary]()
    
    // Temps d'affichage du message de félicitations
    var timeDisplayMessageError = 500
    
    // Liste de messages de félicitations
    var congratulations = [String]()
    
    // Nombre de lettres proposées par ligne
    var numberLetter: Int! = 12
    
    // Liste contenant les tailles des parties d'un mot avec espace
    var partsLength = [Int]()
    
    // Compteur permettant de compter la taille des parties d'un mot avec espace
    var countLength: Int! = 0
    
    // Défini quel taille utilisée en fonction de la partie du mot avec espace que l'on traite
    var lengthToUse: Int! = 0
    
    // Compteur permettant de mettre un tag sur chaque label "réponse". Utilisé notamment pour les mots avec espace (on ne peut pas utiliser le i de la boucle
    // for qui se reset à chaque nouvelle partie
    var countTagMultiPartWord: Int! = 0
    
    // Même chose pour les labels suggérés
    var countTagMultiPartWordSuggestedLabel: Int! = 0
    
    
    // Au chargement de la fenêtre
    // On charge n vocabulaires liés à notre thème
    // On initialise un entier qui sera un index sur le mot que l'on va mélanger
    // On récupère la taille du mot à mélanger puis sa taille sans les espaces
    // On le converti en liste de String en le mélangeant via la fonction stringToList et en supprimant les espaces
    // On place la coordonée X du premier label au bon endroit pour toutes les centrer
    // On initialise les autres coordonnées
    // On place les labels "réponses"
    // On place les labels "suggerées"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)

        wordIndex = 0
        
        firstWordLength = 0
        
        firstWordLengthSpaceLess = 0
        
        helpButton.alpha = 1
        
        resetLettersButton.alpha = 1
        
        resetVariablesAndDeleteSubviewsForNextWord()
        
        fillCongratulationsList()
        
        numberOfValidateWord.text = "Good words : " + String(wordIndex) + " / " + String(numberOfVocabularyElements)
        
        // Récupère des éléments de vocabulaire
        listVocabulary = self.theme.getVocabulary(numberOfVocab: numberOfVocabularyElements)
        
        getWordFromRandomListByWordIndex()
        
        initLabelLocalisation()
    }
    
    func getWordFromRandomListByWordIndex() {
        
        // Récupère le premier mot parmi les éléments de vocabulaire
        firstWordLength = listVocabulary[wordIndex].getName().characters.count
        
        firstWordLengthSpaceLess = String(listVocabulary[wordIndex].getName().characters.filter({$0 != " "})).characters.count
        
        // Transforme le premier mot en liste et mélange les lettres en supprimant les espaces
        mixUpWord = stringToList(word: listVocabulary[wordIndex].getName(), wordLength: firstWordLength)
        
        imageViewHelp.image = UIImage(named: listVocabulary[wordIndex].getImageName())

        imageViewHelp.alpha = 0
    }
    
    func initLabelLocalisation() {
        
        // Place le début des labels suggérés pour les centrer
        if firstWordLengthSpaceLess < numberLetter {
            
            coordonneeX = CGFloat((CGFloat((numberLetter-firstWordLengthSpaceLess)) / 2) * 75) + self.userView.frame.origin.x
        }
        else {
            
            coordonneeX = self.userView.frame.origin.x
        }
        
        // Si le mot contient des espaces alors il faut placer chaque partie au bon endroit
        if firstWordLengthSpaceLess < firstWordLength {
            
            // On compte la taille de chaque partie que l'on stocke toutes dans un tableau
            for i in 0...firstWordLength-1 {
                
                let index = listVocabulary[wordIndex].getName().index(listVocabulary[wordIndex].getName().startIndex, offsetBy: i)
                
                if listVocabulary[wordIndex].getName()[index] == " " || i == firstWordLength-1 {
                    if i == firstWordLength-1 {
                        countLength = countLength + 1
                    }
                    partsLength.append(countLength)
                    countLength = 0
                } else {
                    
                    countLength = countLength + 1
                }
            }
            var placeOnTheFullWord = 0
            for i in 0...partsLength.count-1 {
                
                if partsLength[i] < numberLetter {
                    
                    coordonneeXMixUpWord = CGFloat((CGFloat((numberLetter-partsLength[i])) / 2) * 75) + self.userView.frame.origin.x
                }
                else {
                    
                    coordonneeXMixUpWord = self.userView.frame.origin.x
                }
                
                lengthToUse = partsLength[i]
                
                coordonneeYMixUpWord = self.userView.frame.origin.y + CGFloat(75 * i)
                
                for j in 0...partsLength[i]-1 {
                    
                    setAllAnswerLabel(i: j + placeOnTheFullWord)
                }
                placeOnTheFullWord += lengthToUse + 1
            }
        }
        else {
            
            if firstWordLength < numberLetter {
                
                coordonneeXMixUpWord = CGFloat((CGFloat((numberLetter-firstWordLength)) / 2) * 75) + self.userView.frame.origin.x
            }
            else {
                
                coordonneeXMixUpWord = self.userView.frame.origin.x
            }
            
            lengthToUse = firstWordLength
            
            coordonneeYMixUpWord = self.userView.frame.origin.y
       
            for i in 0...firstWordLength-1 {
                
                setAllAnswerLabel(i: i)
            }
        }
        
        coordonneeY = self.userView.frame.origin.y
        
        for i in 0...firstWordLengthSpaceLess-1 {
            
            GestureList.append(UIPanGestureRecognizer(target: self, action: #selector(wasDragged)))
            
            setAllSuggestedLabel(i: i, mixUpWord: mixUpWord)
            
            countTagMultiPartWordSuggestedLabel = countTagMultiPartWordSuggestedLabel + 1
        }
    }
    
    func fillCongratulationsList() {
        
        congratulations.append("Amazing !")
        congratulations.append("Huge !")
        congratulations.append("Fantastic !")
        congratulations.append("Awesome !")
        congratulations.append("Congratulations !")
        congratulations.append("Great !")
        congratulations.append("Brilliant !")

    }
    
    // Fonction permettant de placer tous les labels "réponse"
    func setAllAnswerLabel(i: Int) {
        
        let index = listVocabulary[wordIndex].getName().index(listVocabulary[wordIndex].getName().startIndex, offsetBy: i)

        if listVocabulary[wordIndex].getName()[index] != " " {
            
            let answerLabel = UILabel(frame: CGRect(x: coordonneeXMixUpWord, y: coordonneeYMixUpWord, width: 70, height: 65))
            
            customLabel(myLabel: answerLabel, letter: "", indice: countTagMultiPartWord)
            
            countTagMultiPartWord = countTagMultiPartWord + 1
            
            if countTagMultiPartWord < firstWordLengthSpaceLess {
            
                let indexVerify = listVocabulary[wordIndex].getName().index(listVocabulary[wordIndex].getName().startIndex, offsetBy: countTagMultiPartWord)
            
                if listVocabulary[wordIndex].getName()[indexVerify] == " " {
                
                    countTagMultiPartWord = countTagMultiPartWord + 1
                }
            }
            
            self.answerView.addSubview(answerLabel)
            
            if lengthToUse > numberLetter && i % (numberLetter-1) == 0 && i != 0 {
                if lengthToUse-i < numberLetter || lengthToUse < numberLetter {
                    
                    coordonneeXMixUpWord = CGFloat((CGFloat((numberLetter-lengthToUse+i)) / 2) * 75) + self.userView.frame.origin.x
                } else {
                    
                    coordonneeXMixUpWord = self.userView.frame.origin.x
                }
                
                coordonneeYMixUpWord = coordonneeYMixUpWord + 75
            }
        } else {
            
            if lengthToUse-i < numberLetter || lengthToUse < numberLetter {
                
                coordonneeXMixUpWord = CGFloat((CGFloat((numberLetter-lengthToUse+i)) / 2) * 75) + self.userView.frame.origin.x
            }
            else {
                
                coordonneeXMixUpWord = self.userView.frame.origin.x
            }

             coordonneeYMixUpWord = coordonneeYMixUpWord + 155
        }
        
        coordonneeXMixUpWord = coordonneeXMixUpWord + 75
    }
    
    // Fonction permettant de placer tous les labels contenant les lettres proposées
    func setAllSuggestedLabel(i: Int, mixUpWord: [String]) {
        
        let labelOrigin = UILabel(frame: CGRect(x: coordonneeX, y: coordonneeY, width: 70, height: 65))
        
        let indexToAddSpace = listVocabulary[wordIndex].getName().index(listVocabulary[wordIndex].getName().startIndex, offsetBy: i)
        
        if listVocabulary[wordIndex].getName()[indexToAddSpace] == " " {
            
            Origine.append(CGPoint(x: 0, y: 0))
            
            countTagMultiPartWordSuggestedLabel = countTagMultiPartWordSuggestedLabel + 1
        }
        
        Origine.append(CGPoint(x: coordonneeX, y: coordonneeY))
        
        customLabel(myLabel: labelOrigin, letter: mixUpWord[i], indice: countTagMultiPartWordSuggestedLabel)
            
        labelOrigin.addGestureRecognizer(GestureList[i])
        
        labelOrigin.isUserInteractionEnabled = true
            
        self.userView.addSubview(labelOrigin)
            
        coordonneeX = coordonneeX + 75
            
        if i % (numberLetter-1) == 0 && i != 0 {
            
            if firstWordLengthSpaceLess-i < numberLetter || firstWordLengthSpaceLess < numberLetter {
                
                coordonneeX = CGFloat((CGFloat((numberLetter-firstWordLengthSpaceLess+i)) / 2) * 75) + self.userView.frame.origin.x
            }
            else {
                
                coordonneeX = self.userView.frame.origin.x
            }
            
            coordonneeY = coordonneeY + 75
        }
    }
    
    // Fonction appelée chaque fois que l'on bouge l'object contenu dans UIPanGestureRecognizer
    // Tant que l'on bouge, cette fonction est appelée en boucle
    // On récupère le label deplacé
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        var letterSettedInAnswerLabel: Bool = false
        let translation = gesture.translation(in: self.view)
        let label = gesture.view!
        
        xFromCenter += translation.x
        
        // move the label with the translation
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        
        // reset the translation that now, is already applied to the label
        gesture.setTranslation(CGPoint.zero, in: self.view)
        
        // Quand on relache le label
        if gesture.state == UIGestureRecognizerState.ended {
            
            // On récupère le point où on relache
            let point = gesture.location(in: self.answerView)
            
            // Pour toutes les vues dans la vue principale
            for answerLabelGesture in answerView.subviews {
                
                // Si le label contient le point et qu'il s'agit d'un label "vide" destiné à recevoir une lettre alors
                if (answerLabelGesture as! UILabel).convert((answerLabelGesture as! UILabel).bounds, to: answerView).contains(point) && (answerLabelGesture as! UILabel).text == "" {
                    
                    updateOriginalAndAnswersListAfterTouchEnded(labelDown: answerLabelGesture, labelUp: label)
                    
                    letterSettedInAnswerLabel = true
                }
            }
            
            if !letterSettedInAnswerLabel {
            
                // On replace le label deplacé à son origine. Cela ne se voit pas car la fonction "updateOriginal..." l'a masqué
                label.frame.origin.x = Origine[label.tag].x
                label.frame.origin.y = Origine[label.tag].y
            }
            
            // On vérifie si le mot est juste
            let goodLetter = verify()
            
            // Si oui on affiche un message et passe au mot suivant
            if goodLetter == firstWordLengthSpaceLess {
                
                wordIndex = wordIndex + 1
                
                let i = arc4random_uniform(UInt32(congratulations.count))
                
                delay(timeDisplayMessageError) { self.numberOfValidateWord.text = self.congratulations[Int(i)] }
                delay(timeDisplayMessageError + 5000) { self.numberOfValidateWord.text = "Good words : " + String(self.wordIndex) + " / " + String(self.numberOfVocabularyElements) }

                if wordIndex < 6 {
                    
                    resetVariablesAndDeleteSubviewsForNextWord()
                
                    getWordFromRandomListByWordIndex()
                
                    initLabelLocalisation()
                }
                else {
                    
                    resetVariablesAndDeleteSubviewsForNextWord()
                    
                    resetLettersButton.alpha = 0
                    helpButton.alpha = 0
                    
                    let congratulationLabel = UILabel(frame: CGRect(x: userView.center.x-400, y: userView.frame.origin.y, width: 800, height: 200))
                    customCongratulationLabel(label: congratulationLabel)
                    
                    let replay = UIButton(frame: CGRect(x: userView.center.x-125, y: userView.frame.origin.y, width: 250, height: 120))
                    customReplayButton(replay: replay)
                    
                    let exit = UIButton(frame: CGRect(x: userView.center.x-125, y: userView.frame.origin.y+125, width: 250, height: 120))
                    customExitButton(exit: exit)
                }
            }
        }
    }
    
    // Fonction qui relance une partie en cliquant sur le bouton replay
    func replayGame(sender: UIButton) {
        
        self.viewDidLoad()
    }
    
    // Fonction appelée pour quitter le jeu en cliquant sur le bouton exit
    func exitGame(sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SIDExoSelection") as! ExoSelectionViewController
        
        nextViewController.theme = self.theme
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func customCongratulationLabel(label: UILabel) {
     
        let i = arc4random_uniform(UInt32(congratulations.count))
        
        let rainbowColorMessage = NSMutableAttributedString(string: self.congratulations[Int(i)], attributes: [NSFontAttributeName:UIFont(name: "Back_to_School_", size: 100)!])
        
        for i in 0...self.congratulations[Int(i)].characters.count-1 {
            
            if i == 0 {
                
                rainbowColorMessage.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location: i, length: 1))
            }
            else if i % 3 == 0 {
                
                rainbowColorMessage.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellow, range: NSRange(location: i, length: 1))
            }
            else if i % 5 == 0 {
                
                rainbowColorMessage.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location: i, length: 1))
            }
            else if i % 2 == 0 {
                
                rainbowColorMessage.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location: i, length: 1))
            }
            else {
                
                rainbowColorMessage.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: NSRange(location: i, length: 1))
            }
        }
        
        
        label.attributedText = rainbowColorMessage
        label.textAlignment = .center
        
        userView.addSubview(label)
    }
    
    // Fonction décorant le bouton replay
    func customReplayButton(replay: UIButton) {
        
        replay.addTarget(self, action: #selector(PutInOrderViewController.replayGame(sender:)), for: .touchUpInside)
        replay.setTitle("Replay", for: UIControlState.normal)
        replay.setTitleColor(UIColor.black, for: UIControlState.normal)
        replay.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(replay)
    }
    
    func customExitButton(exit: UIButton) {
        
        exit.addTarget(self, action: #selector(PutInOrderViewController.exitGame(sender:)), for: .touchUpInside)
        exit.setTitle("Exit", for: UIControlState.normal)
        exit.setTitleColor(UIColor.black, for: UIControlState.normal)
        exit.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(exit)
    }
    
    // Fonction mettant à jour la liste de lettres proposées et la liste de labels "réponse" lorsque l'utilisateur relache une lettre sur une case "réponse"
    // Paramètre 1 : le label "réponse" courant de la boucle for de la fonction appelante
    // Paramètre 2 : le label touché par l'utilisateur
    func updateOriginalAndAnswersListAfterTouchEnded(labelDown: UIView, labelUp: UIView) {
        
        // On cache le label d'origine
        labelUp.alpha = 0
        
        labelUp.tag = labelDown.tag
        
        // On remet le label touché à sa position d'origine
        labelUp.frame.origin.x = Origine[labelUp.tag].x
        labelUp.frame.origin.y = Origine[labelUp.tag].y
        
        // Dans le label "réponse" on met le même texte que le label "déplacé
        let answerLabel = labelDown as! UILabel
        let labelUser = labelUp as! UILabel
        answerLabel.text = labelUser.text
        labelDown.layer.borderColor = UIColor.black.cgColor
        
        // On incrémente le nombre de lettre placée
        numberLetterSetOnBlankWord = numberLetterSetOnBlankWord + 1
    }
    
    // Fonction appelée lorsque l'utilisateur a rempli tous les labels "réponse". Vérifie si le mot est juste
    func verify() -> Int {
        
        goodLetter = 0
        
        if numberLetterSetOnBlankWord >= firstWordLengthSpaceLess {
            
            // Pour toutes les sous-vues dans la vue principale
            for answerLabel in answerView.subviews {
                
                let answerLabelConvert = answerLabel as! UILabel
            
                let indexVerify = listVocabulary[wordIndex].getName().index(listVocabulary[wordIndex].getName().startIndex, offsetBy: answerLabelConvert.tag)
                
                // Si le label "réponse" contient la même lettre que le mot d'origine au même endroit
                if answerLabelConvert.text?.lowercased() == String(listVocabulary[wordIndex].getName()[indexVerify]).lowercased() {
                    
                   // On incrémente le nombre de lettre bien placée
                   goodLetter = goodLetter + 1
                        
                   answerLabelConvert.layer.borderColor = UIColor.green.cgColor
                }
                else {
                        
                    answerLabelConvert.layer.borderColor = UIColor.red.cgColor
                        
                    answerLabelConvert.text = ""

                    for labelUser in userView.subviews {
                            
                        let labelUserConvert = labelUser as! UILabel
                        
                        let hideGoodLetterIndex = listVocabulary[wordIndex].getName().index(listVocabulary[wordIndex].getName().startIndex, offsetBy: labelUserConvert.tag)
                        
                        if labelUserConvert.text != String(listVocabulary[wordIndex].getName()[hideGoodLetterIndex]) {
                            
                            labelUserConvert.alpha = 1
                        }
                    }
                }
            }
            
            numberLetterSetOnBlankWord = goodLetter
        }
        
        return goodLetter
    }
    
    // Dispose des éléments graphiques sur les labels
    func customLabel(myLabel: UILabel, letter: String, indice: Int) {
        
        myLabel.text = letter
        myLabel.textAlignment = .center
        myLabel.tag = indice
        myLabel.textColor = UIColor.black
        myLabel.font = UIFont(name: "Back_to_School_", size: 45)
        myLabel.layer.borderColor = UIColor.black.cgColor
        myLabel.layer.borderWidth = 2.0
        myLabel.layer.cornerRadius = 10.0
        myLabel.clipsToBounds = true;
    }
    
    // Convertit une string en une liste de String et mélange les lettres à l'interieur
    func stringToList(word: String, wordLength: Int) -> [String] {
        
        var mixUpWord = [String]()
        var mixUpWordCompare = [String]()
        
        for i in 0...wordLength-1 {
            
            let index = word.index(word.startIndex, offsetBy: i)
            
            if String(word[index]) != " " {
                
                mixUpWord.append(String(word[index]))
                
                mixUpWordCompare.append(String(word[index]))
            }
        }
        
        mixUpWord.shuffle()
        
        if wordLength > 1 {
        
                while mixUpWord == mixUpWordCompare {
            
                    mixUpWord.shuffle()
            }
        }
        
        return mixUpWord
    }
    
    // Fonction appelée lorsque l'on clique sur le bouton pour reset les lettres placées
    @IBAction func resetLetters(_ sender: Any) {
        
        resetVariablesAndDeleteSubviewsForNextWord()
        
        initLabelLocalisation()
    }
    
    func resetVariablesAndDeleteSubviewsForNextWord() {
        
        for item in userView.subviews {
            
            item.removeFromSuperview()
        }
        
        for item in answerView.subviews {
            
            item.removeFromSuperview()
        }
        
        goodLetter = 0
        
        numberLetterSetOnBlankWord = 0
        
        countLength = 0
        
        lengthToUse = 0
        
        countTagMultiPartWord = 0
        
        countTagMultiPartWordSuggestedLabel = 0
        
        xFromCenter = 0
        
        coordonneeX = 0
        coordonneeY = 0
        coordonneeXMixUpWord = 0
        coordonneeYMixUpWord = 0
        
        partsLength.removeAll()
        
        Origine.removeAll()
        
        GestureList.removeAll()
    }
    
    @IBAction func helpPressed(_ sender: Any) {
        
        userView.alpha = 0
        answerView.alpha = 0
        imageViewHelp.alpha = 1
    }
    
    @IBAction func helpRelease(_ sender: Any) {
        
        userView.alpha = 1
        answerView.alpha = 1
        imageViewHelp.alpha = 0
    }
    
    // Execute une fonction pendant un temps donnée
    // Paramètre : delay : temps d'exécution en milisecondes.
    // Paramètre : closure : fonction à exécuter
    func delay(_ delay: Int, closure: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            
            closure()
        }
    }
    
    // Fonction appelé lorsque l'on clique sur le bouton "Suivant" ou "Précédent"
    // Renvoit le thème séléctionné à la fenêtre suivante ou précédente
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let exoSelectionVC = segue.destination as! ExoSelectionViewController
        exoSelectionVC.theme = self.theme
    }
}
