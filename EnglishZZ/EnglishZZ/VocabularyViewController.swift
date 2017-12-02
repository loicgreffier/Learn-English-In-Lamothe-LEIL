//
//  VCVocabulary.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 21/12/2016.
//  Copyright © 2016 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit
import AVFoundation


class VocabularyViewController: UIViewController {
    
    var listLabel = [UILabel]()
    @IBOutlet weak var labelTopLeft: UILabel!
    @IBOutlet weak var labelTopMiddle: UILabel!
    @IBOutlet weak var labelTopRight: UILabel!
    @IBOutlet weak var labelBottomLeft: UILabel!
    @IBOutlet weak var labelBottomMiddle: UILabel!
    @IBOutlet weak var labelBottomRight: UILabel!
    
    var listImage = [UIImageView]()
    @IBOutlet weak var imageCheckGoodTopLeft: UIImageView!
    @IBOutlet weak var imageCheckGoodTopMiddle: UIImageView!
    @IBOutlet weak var imageCheckGoodTopRight: UIImageView!
    @IBOutlet weak var imageCheckGoodBottomLeft: UIImageView!
    @IBOutlet weak var imageCheckGoodBottomMiddle: UIImageView!
    @IBOutlet weak var imageCheckGoodBottomRight: UIImageView!
    
    var listButton = [UIButton]()
    @IBOutlet weak var buttonTopLeft: UIButton!
    @IBOutlet weak var buttonTopMiddle: UIButton!
    @IBOutlet weak var buttonTopRight: UIButton!
    @IBOutlet weak var buttonBotLeft: UIButton!
    @IBOutlet weak var buttonBotMiddle: UIButton!
    @IBOutlet weak var buttonBotRight: UIButton!
    
    let numberOfVocabularyElements = 6
    
    // Liste de messages de félicitations
    var congratulations = [String]()

    @IBOutlet weak var answerView: UIView!
    
    var theme: Theme!    
    var tabName = [String]()
    var tabImageName = [String]()
    var tabSoundName = [String]()

    var spamSecurity = false
    var countOfCheck = Int()
    
    var audioPlayer = AVAudioPlayer()

    // Fonction permettant de remplir chacune de nos listes d'éléments (Boutons, Images, Labels)
    // Une liste de label contenant les noms des mots
    // Une liste d'images contenant les logos de validation
    // Une liste de boutons contenant les images associées aux mots
    func fillTheList(){
        listLabel = [UILabel]()

        listLabel.append(labelTopLeft)
        listLabel.append(labelTopMiddle)
        listLabel.append(labelTopRight)
        listLabel.append(labelBottomLeft)
        listLabel.append(labelBottomMiddle)
        listLabel.append(labelBottomRight)

        listImage = [UIImageView]()

        listImage.append(imageCheckGoodTopLeft)
        listImage.append(imageCheckGoodTopMiddle)
        listImage.append(imageCheckGoodTopRight)
        listImage.append(imageCheckGoodBottomLeft)
        listImage.append(imageCheckGoodBottomMiddle)
        listImage.append(imageCheckGoodBottomRight)
        
        listButton = [UIButton]()
        listButton.append(buttonTopLeft)
        listButton.append(buttonTopMiddle)
        listButton.append(buttonTopRight)
        listButton.append(buttonBotLeft)
        listButton.append(buttonBotMiddle)
        listButton.append(buttonBotRight)
    }
    
    // Au chargement de la fenêtre
    // On récupère n=6 éléments de vocabulaire au hasard via la fonction "getVocabulary"
    // On remplit nos listes d'éléments graphiques
    // On remplit parallèlement 4 listes de chaînes de caractères contenant le nom, le nom de l'image, le nom du son, et l'extension du son de nos n éléments de vocabulaire
    // On initialise nos labels à vides et on cache les logos de validations
    // On place nos n images prises au hasard
    // On cache le boutton "Next"
    // On initialise le compteur de mots validés à 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)

        answerView.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)
        answerView.alpha = 0
        let listVocabulary = self.theme.getVocabulary(numberOfVocab: numberOfVocabularyElements)
        
        tabName = [String]()
        tabImageName = [String]()
        tabSoundName = [String]()
        
        fillTheList()
        fillCongratulationsList()
        for i in 0...numberOfVocabularyElements-1 {
            
            self.tabName.append(listVocabulary[i].getName())
            self.tabImageName.append(listVocabulary[i].getImageName())
            self.tabSoundName.append(listVocabulary[i].getSoundName())
            self.listLabel[i].text = ""
            self.listImage[i].alpha = 0
            self.listButton[i].setImage(UIImage.init(named: tabImageName[i]), for: UIControlState.normal)
        }

        self.countOfCheck = 0
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

    // Action déclenché lorsque l'on clique sur un bouton
    // Dans "sender.tag" on a un identifiant associé au bouton sur lequel on a cliqué
    // On joue le son associé au bouton sur lequel on a cliqué grâce au tableau contenant les sons
    // Si le label associé au bouton cliqué est vide (= Si c'est la première fois qu'on clique sur le bouton) alors
        // On affiche le nom de l'élément cliqué
        // On affiche le logo validé 
        // On incrémente le nombre d'élément validé
    // Si le nombre d'élément validé est >= à 6 alors
        // On affiche le bouton "Suivant"
    @IBAction func ButtonPressedDown(_ sender: UIButton) {
        if (!spamSecurity) {
            spamSecurity = true
            if listLabel[sender.tag].text == "" {
            
                listLabel[sender.tag].text = tabName[sender.tag]
                listImage[sender.tag].alpha = 1
                countOfCheck += 1
            }


            playSound(name: tabSoundName[sender.tag], extensionName: "m4a")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                self.spamSecurity = false
            }
        }

        if countOfCheck >= 6 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                self.setAnswerView()
            }
        }
    }
    
    
    func setAnswerView() {
        answerView.alpha = 0.9
        
        for view in answerView.subviews {
            view.removeFromSuperview()
        }
        
        let congratulationLabel = UILabel(frame: CGRect(x: answerView.center.x-400, y: answerView.frame.origin.y, width: 800, height: 200))
        customCongratulationLabel(label: congratulationLabel)
        
        let replay = UIButton(frame: CGRect(x: answerView.center.x-125, y: answerView.frame.origin.y+200, width: 250, height: 120))
        customReplayButton(replay: replay)
        
        let exit = UIButton(frame: CGRect(x: answerView.center.x-125, y: answerView.frame.origin.y+300, width: 250, height: 120))
        customExitButton(exit: exit)

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
        
        replay.addTarget(self, action: #selector(MatchViewController.replayGame), for: .touchUpInside)
        replay.setTitle("Replay", for: UIControlState.normal)
        replay.setTitleColor(UIColor.black, for: UIControlState.normal)
        replay.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(replay)
    }
    
    func customExitButton(exit: UIButton) {
        
        exit.addTarget(self, action: #selector(MatchViewController.exitGame), for: .touchUpInside)
        exit.setTitle("Exit", for: UIControlState.normal)
        exit.setTitleColor(UIColor.black, for: UIControlState.normal)
        exit.titleLabel?.font = UIFont(name: "Back_to_School_", size: 60)
        
        answerView.addSubview(exit)
    }
}
