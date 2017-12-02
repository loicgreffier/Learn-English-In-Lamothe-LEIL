
//
//  ComprehensionViewController.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 01/03/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit
import AVFoundation


class WhatIsItViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonHelp: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonVocab: UIButton!
    @IBOutlet weak var buttonValidate: UIButton!
    
    @IBOutlet weak var messageErreur: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var answerView: UIView!
    
    let numberOfVocabularyElements = 6
    
    var spamSecurity = false
    
    var indexVocabActive = 0
    // Liste de messages de félicitations
    var congratulations = [String]()
    
    var theme: Theme!
    var tabName = [String]()
    var tabImageName = [String]()
    var tabSoundName = [String]()
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let colorBackground = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)

        self.view.backgroundColor =  colorBackground
        self.textField.backgroundColor = colorBackground
        self.answerView.backgroundColor = colorBackground
        
        textField.delegate = self;
        textField.autocorrectionType = .no
        
        let listVocabulary = self.theme.getVocabulary(numberOfVocab: numberOfVocabularyElements)
        
        tabName = [String]()
        tabImageName = [String]()
        tabSoundName = [String]()
        
        for i in 0...numberOfVocabularyElements-1 {
            
            self.tabName.append(listVocabulary[i].getName())
            self.tabImageName.append(listVocabulary[i].getImageName())
            self.tabSoundName.append(listVocabulary[i].getSoundName())
        }
        
        textField.becomeFirstResponder()
        textField.alpha = 1
        
        messageErreur.text = ""
        messageErreur.textAlignment = .center
        
        indexVocabActive = 0
        setKeyboardUpButton()
        setNewWord(i: indexVocabActive)

        fillCongratulationsList()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNewWord(i: Int) {
        let random = Int(arc4random_uniform(2))
        if (random == 0) {
            buttonVocab.setImage(UIImage.init(named: tabImageName[i]), for: UIControlState.normal)
            buttonHelp.alpha = 0
            helpLabel.alpha = 0
        } else {
            buttonVocab.setImage(#imageLiteral(resourceName: "playButton"), for: UIControlState.normal)
            buttonHelp.alpha = 1
            helpLabel.alpha = 0
        }
        textField.text = ""
        scoreLabel.text = " \(indexVocabActive) / \(numberOfVocabularyElements)"
    }
    
    
    func setKeyboardUpButton(){
        for view in answerView.subviews {
            view.removeFromSuperview()
        }
        
        let keyboard = UIButton(frame: CGRect(x: answerView.center.x-125, y: answerView.frame.origin.y-200, width: 250, height: 120))
        keyboard.addTarget(self, action: #selector(WhatIsItViewController.afficherKeyboard), for: .touchUpInside)
        keyboard.setTitle("Keyboard", for: UIControlState.normal)
        keyboard.setTitleColor(UIColor.black, for: UIControlState.normal)
        keyboard.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(keyboard)
    }
    
    func afficherKeyboard(){
        textField.becomeFirstResponder()
    }
    
    @IBAction func validateWord(_ sender: Any) {
        if( tabName[indexVocabActive].lowercased() == textField.text?.lowercased()) {
            if (indexVocabActive == numberOfVocabularyElements-1) {
                scoreLabel.text = "\(numberOfVocabularyElements) / \(numberOfVocabularyElements)"
                textField.alpha = 0
                
                for view in answerView.subviews {
                    view.removeFromSuperview()
                }
                
                let congratulationLabel = UILabel(frame: CGRect(x: answerView.center.x-400, y: answerView.frame.origin.y-375, width: 800, height: 200))
                customCongratulationLabel(label: congratulationLabel)
                
                let replay = UIButton(frame: CGRect(x: answerView.center.x-125, y: answerView.frame.origin.y-200, width: 250, height: 120))
                customReplayButton(replay: replay)
                
                let exit = UIButton(frame: CGRect(x: answerView.center.x-125, y: answerView.frame.origin.y-100, width: 250, height: 120))
                customExitButton(exit: exit)
                
                textField.resignFirstResponder()
            } else {
                indexVocabActive += 1
                setNewWord(i: indexVocabActive)
            }
        }else{
            messageErreur.text = "You made a mistake"
            textField.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                self.messageErreur.text = ""
                self.textField.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        validateWord(0)
        return true
    }
    

    
    
    
    
    // Fonction permettant de jouer un son dont le nom et l'extension sont passés en paramètre
    func playSound(name: String?, extensionName: String?) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: extensionName)!))
        }
        catch {
            
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        if (!spamSecurity){
            spamSecurity = true
            playSound(name: tabSoundName[indexVocabActive], extensionName: "m4a")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                self.spamSecurity = false
            }
        }
    }
    
    @IBAction func ButtonHelpPressed(_ sender: Any) {
        buttonVocab.setImage(UIImage.init(named: tabImageName[indexVocabActive]), for: UIControlState.normal)
        buttonHelp.alpha = 0
        helpLabel.alpha = 0
    }

    @IBAction func ButtonClearPressed(_ sender: Any) {
        
        textField.text = ""
    }
    
    
    
    
    
    // Fonction appelé lorsque l'on clique sur le bouton "Suivant" ou "Précédent"
    // Renvoit le thème séléctionné à la fenêtre suivante ou précédente
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let exoSelectionVC = segue.destination as! ExoSelectionViewController
        exoSelectionVC.theme = self.theme
    }
    
    
    
    func fillCongratulationsList() {
        
        congratulations = [String]()
        congratulations.append("Amazing !")
        congratulations.append("Huge !")
        congratulations.append("Fantastic !")
        congratulations.append("Awesome !")
        congratulations.append("Congratulations !")
        congratulations.append("Great !")
        congratulations.append("Brilliant !")
        
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
        
        answerView.addSubview(label)
    }
    
    
    
    func replayGame() {
        
        self.viewDidLoad()
    }
    
    // Fonction appelée pour quitter le jeu en cliquant sur le bouton exit
    func exitGame() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SIDExoSelection") as! ExoSelectionViewController
        
        nextViewController.theme = self.theme
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    // Fonction décorant le bouton replay
    func customReplayButton(replay: UIButton) {
        
        replay.addTarget(self, action: #selector(WhatIsItViewController.replayGame), for: .touchUpInside)
        replay.setTitle("Replay", for: UIControlState.normal)
        replay.setTitleColor(UIColor.black, for: UIControlState.normal)
        replay.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(replay)
    }
    
    func customExitButton(exit: UIButton) {
        
        exit.addTarget(self, action: #selector(WhatIsItViewController.exitGame), for: .touchUpInside)
        exit.setTitle("Exit", for: UIControlState.normal)
        exit.setTitleColor(UIColor.black, for: UIControlState.normal)
        exit.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(exit)
    }
    
}
