//
//  ColoursViewController.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 21/12/2016.
//  Copyright © 2016 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    var listImage = [UIImageView]()
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Image4: UIImageView!
    @IBOutlet weak var Image5: UIImageView!
    @IBOutlet weak var Image6: UIImageView!
    
    var listLabel = [UILabel]()
    @IBOutlet weak var Name1: UILabel!
    @IBOutlet weak var Name2: UILabel!
    @IBOutlet weak var Name3: UILabel!
    @IBOutlet weak var Name4: UILabel!
    @IBOutlet weak var Name5: UILabel!
    @IBOutlet weak var Name6: UILabel!
    
    @IBOutlet weak var AttachLeft1: UIImageView!
    @IBOutlet weak var AttachLeft2: UIImageView!
    @IBOutlet weak var AttachLeft3: UIImageView!
    @IBOutlet weak var AttachLeft4: UIImageView!
    @IBOutlet weak var AttachLeft5: UIImageView!
    @IBOutlet weak var AttachLeft6: UIImageView!
    
    @IBOutlet weak var AttachRight1: UIImageView!
    @IBOutlet weak var AttachRight2: UIImageView!
    @IBOutlet weak var AttachRight3: UIImageView!
    @IBOutlet weak var AttachRight4: UIImageView!
    @IBOutlet weak var AttachRight5: UIImageView!
    @IBOutlet weak var AttachRight6: UIImageView!
    
    @IBOutlet weak var stackViewLeft: UIStackView!
    @IBOutlet weak var stackViewRight: UIStackView!
    
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var DrawingView: UIView!
    
    // Vue destinée au dessin des traits de liaison de l'utilisateur
    @IBOutlet weak var imageDrawingView: UIImageView!
    
    // Vue destinée au dessin des traits de liaisons corrects
    @IBOutlet weak var imageFixView: UIImageView!
    
    // Vue destinée au dessin des traits de liaisons faux
    @IBOutlet weak var imageFalseView: UIImageView!

    @IBOutlet weak var MessageErreur: UILabel!
    
    
    // Liste de messages de félicitations
    var congratulations = [String]()

    // Nombre d'élément de vocabulaire que l'on va récupérer
    let numberOfVocabularyElements = 6
    
    var theme: Theme!
    var tabName = [String]()
    var tabImageName = [String]()
    
    // Tableaux d'entiers dont le contenu nous permettra de disposer les images/labels au hasard
    var imageOrder = [0,1,2,3,4,5]
    var nameOrder = [0,1,2,3,4,5]
    
    // Tableaux permettant de savoir si deux points sont reliés
    var tabAttachLeftConnected: [Bool]!
    var tabAttachRightConnected: [Bool]!
    
    // Entier permettant de noter le numéro de l'attache touchée dans la colonne de gauche
    var positionAttachLeft: Int!
    
    // Entier permettant de noter le numéro de l'attache touchée dans la colonne de droite
    var positionAttachRight: Int!
    
    // Définit un point de départ sur l'écran : le centre de l'attache de départ
    var firstPoint: CGPoint!
    
    //Définit un point d'arrivée sur l'écran : le centre de l'attache d'arrivée
    var lastPoint: CGPoint!
    
    // Booléen permettant de savoir si une attache a été touché
    var attachAsBegan = false
    
    // Booléen permettant de savoir si un trait a un point d'arrivée. Il ne valide pas qu'il soit sur une attache mais seulement qu'il existe
    var attachAsEnded = false
    
    // Booléen permettant de savoir si on est parti d'une attache de gauche ou non
    var startedLeft: Bool!
    
    // Entier permettant de comptabiliser le nombre de liaisons correctes
    var numberOfGoodMatch = 0
    
    // Entier permettant de comptabiliser le nombre de liaisons fausses
    var numberOfWrongMatch = 0
    
    // Tableau permettant de notifier les numéros des attaches de gauche faussement reliées
    var tabFalseMatchLeft = [Int]()
    
    // Tableau permettant de notifier les numéros des attaches de droite faussement reliées
    var tabFalseMatchRight = [Int]()
    
    // Temps durant lequel le message d'erreur apparait en millisecondes
    var timeDisplayMessageError = 500
    var progressiveTime = 200
    
    // Fonction permettant de remplir chacune de nos listes d'éléments (Images, Labels)
    func fillTheList(){
        listImage = [UIImageView]()
        listImage.append(Image1)
        listImage.append(Image2)
        listImage.append(Image3)
        listImage.append(Image4)
        listImage.append(Image5)
        listImage.append(Image6)
        
        listLabel = [UILabel]()
        listLabel.append(Name1)
        listLabel.append(Name2)
        listLabel.append(Name3)
        listLabel.append(Name4)
        listLabel.append(Name5)
        listLabel.append(Name6)

    }
    
    
    // Au chargement de la fenêtre
    // Au récupère 6 éléments de vocabulaire par rapport au thème séléctionné au hasard via la fonction "getVocabulary"
    // On mélange nos 2 tableaux d'entiers "imageOrder" et "nameOrder". On obtient ainsi 2 tableaux d'indices mélangés.
    // On remplit en parallèle 2 listes, une contenant les noms de nos 6 éléments de vocabulaire et l'autre contenant le nom des images associées
    // On remplit les labels avec les noms des éléments de vocabulaires et en fonction des indices mélangés du tableau "nameOrder"
    // On remplit les imageViews avec le tableau de noms des images et en fonction des indices mélangés du tableau "imageOrder"
    // On cache le bouton "Suivant" et on vide le label contenant les messages d'erreurs
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)

        
        tabName = [String]()
        tabImageName = [String]()
        tabFalseMatchLeft = [Int]()
        tabFalseMatchRight = [Int]()
        fillCongratulationsList();
        
        let listVocabulary = self.theme.getVocabulary(numberOfVocab: numberOfVocabularyElements)

        imageOrder.shuffle()
        nameOrder.shuffle()

        fillTheList()
        
        for i in 0...numberOfVocabularyElements-1 {
            
            self.tabName.append(listVocabulary[i].getName())
            self.tabImageName.append(listVocabulary[i].getImageName())
        }
        
        for i in 0...numberOfVocabularyElements-1 {
            
            self.listLabel[i].text = tabName[nameOrder[i]]
            self.listImage[i].image = UIImage.init(named: tabImageName[imageOrder[i]])
        }
        
        tabAttachLeftConnected = [false,false,false,false,false,false]
        tabAttachRightConnected = [false,false,false,false,false,false]
        
        imageDrawingView.image = nil
        imageFixView.image = nil
        imageFalseView.image = nil
        
        numberOfGoodMatch = 0
        numberOfWrongMatch = 0

        MessageErreur.text = ""
        answerView.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)
        answerView.alpha = 0

    }
    
    // Au touché de l'écran
    // On déclare un objet de type CGPoint représentant un point sur l'écran
    // S'il s'agit du premier touché d'écran alors
        // On récupèré la location du touché sur la première vue "imageDrawingView"
        // Si on a cliqué sur une attache, alors on note que l'on a cliqué sur une attache par un booléen "attachAsBegan"
        // Si on a bien cliqué sur une attache, alors on récupère le centre du logo lié à l'attache où l'on a cliqué
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var point: CGPoint!
        
        if let touch = touches.first {
            
            point = touch.location(in: self.imageDrawingView)
            
            if isAnAttach(point: point) {
                
                attachAsBegan = true
            }
        }
        
        if isAnAttach(point: point) && attachAsBegan {
            
            firstPoint = getCenterAttach()
        }
    }
    
    // Lorsque l'on a touché l'écran et que l'on glisse en maintenant le doigt dessus
    // Si on a touché une attache alors
        // Si c'est le premier touché alors
            // On vide la vue imageDrawingView
            // On note le dernier point touché par l'utilisateur (le bout du trait de liaison)
            // On appelle la fonction permettant de dessiner le trait en lui passant un point de départ, d'arrivée et la vue où l'on dessine
        // On note que le dessin du trait est terminé via un booléen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if attachAsBegan {
            
            if let touch = touches.first {
                
                self.imageDrawingView.image = nil
                
                lastPoint = touch.location(in: self.imageDrawingView)
                
                drawLines(fromPoint: firstPoint, toPoint: lastPoint,onView: imageDrawingView)
            }
            
             attachAsEnded = true
        }
    }
    
    // Lorsque l'on relache le doigt de l'écran
    // On vide la vue imageDrawingView destinée au dessin du trait de liaison par l'utilisateur
    // Si le trait de liaison a un point d'arrivée alors
        // Si le point d'arrivée est une attache alors
            // Si les deux points ne sont pas du même côté alors
                // On récupère le centre de l'attache d'arrivée
                // On note que les deux attaches sont reliées grâce à des tableaux de booléens
                // Si le nom relié correspond à l'image alors
                    // On dessine une ligne sur la vue contenant les traits de liaisons justes.
                    // On incrémente le nombre de liaisons correctes
                // Sinon
                    // On dessine une ligne sur la vue contenant les traits de liaisons faux.
                    // On incrémente le nombre de liaisons fausses.
                    // On note dans un premier tableau le numéro de l'attache de gauche fausse.
                    // On note dans un second tableau le numéro de l'attache de droite fausse.
                // Si tous les points ont été reliés alors
                    // On fait valider l'exercice (Cf: Fonction validate())
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.imageDrawingView.image = nil
        
        if attachAsEnded {
            
            if isAnAttach(point: lastPoint) {
                
                if isNotFromTheSameSide() {
                    
                    lastPoint = getCenterAttach()
                    tabAttachLeftConnected[positionAttachLeft] = true
                    tabAttachRightConnected[positionAttachRight] = true
                    
                    if matchIsGood() {
                        
                        drawLines(fromPoint: firstPoint, toPoint: lastPoint,onView: imageFixView)
                        numberOfGoodMatch += 1
                    }
                    else {
                        
                        drawLines(fromPoint: firstPoint, toPoint: lastPoint, onView: imageFalseView)
                        numberOfWrongMatch += 1
                        tabFalseMatchLeft.append(positionAttachLeft)
                        tabFalseMatchRight.append(positionAttachRight)
                    }
                    
                    if numberOfWrongMatch + numberOfGoodMatch >= 6 {
                        
                        validate()
                    }
                }
            }
            
            attachAsBegan = false
            attachAsEnded = false
            startedLeft = false
        }
    }
    
    // Fonction permettant de dessiner des lignes
    // Paramètres : un point de départ, un point d'arrivée, une vue sur laquelle dessiner
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint, onView: UIImageView) {
        
        UIGraphicsBeginImageContext(onView.frame.size)
        onView.image?.draw(in: CGRect(x: 0, y: 0, width: onView.frame.width, height: self.imageDrawingView.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode((CGBlendMode.normal))
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        
        context?.strokePath()
        
        onView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    //     *********           FONCTIONS DE VERIFICATION DES JOINTURES       *********   //

    // Fonction permettant de savoir si l'utilisateur a cliqué sur une attache. Renvoit true si oui, false sinon.
    // Pour toutes les attaches dans la colonne de gauche
        // Si l'attache courante n'est pas reliée alors
            // Si l'attache courante contient le point où l'utilisateur a touché l'écran alors
                // On note via un booléen qu'il s'agit bien d'une attache
                // On note de la combientième attache de gauche il s'agit
                // On note qu'on est bien parti d'une attache de gauche
    // On fait de même pour les attaches de la colonne de droite
    func isAnAttach(point: CGPoint) -> Bool{
        
        var isAnAttach = false
        var count = 0
        
        if !attachAsBegan {
            
            positionAttachLeft = -1
            positionAttachRight = -1
        }
        
        for attach in stackViewLeft.arrangedSubviews {
            
            if tabAttachLeftConnected[count] == false {
                
                if (attach as! UIImageView).convert((attach as! UIImageView).bounds, to: imageDrawingView).contains(point) {
                    
                    isAnAttach = true
                    
                    positionAttachLeft = count
                    
                    if !attachAsBegan {
                        
                        startedLeft = true
                    }
                }
            }
            
            count += 1
        }
        
        count = 0
        
        for attach in stackViewRight.arrangedSubviews {
            
            if tabAttachRightConnected[count] == false {
               
                if (attach as! UIImageView).convert((attach as! UIImageView).bounds, to: imageDrawingView).contains(point) {
                    
                    isAnAttach = true
                    
                    positionAttachRight = count
                    
                    if !attachAsBegan {
                        
                        startedLeft = false
                    }
                }
            }
            
            count += 1
        }
        
        return isAnAttach
    }
    
    // Retourne un point (objet CGPoint) désignant le centre de l'attache séléctionné
    // Si l'on est parti d'une attache de gauche alors
        // on récupère l'imageView contenant l'attache de gauche
    // Sinon on récupère l'imageView contenant l'attache de droite
    // On récupère le centre de l'imageView contenant notre attache en notant les coordonées dans un objet CGPoint
    func getCenterAttach() -> CGPoint {
        
        var attach: CGRect!
        var point: CGPoint!
        
        if (!attachAsEnded && startedLeft! ) || (attachAsEnded && !startedLeft!) {
            
            let imageViewLeft = (stackViewLeft.arrangedSubviews[positionAttachLeft] as! UIImageView)
            attach = imageViewLeft.convert(imageViewLeft.bounds, to: imageDrawingView)
        }
        else {
            
            let imageViewRight = (stackViewRight.arrangedSubviews[positionAttachRight] as! UIImageView)
            attach = imageViewRight.convert(imageViewRight.bounds, to: imageDrawingView)
        }
        
        point = attach.origin
        point.x += attach.size.height/2
        point.y += attach.size.width/2
        
        return point
    }
    
    // Fonction permettant de savoir si deux points reliés sont du même côté de l'écran
    // Retourne true si les deux points ne sont pas du même côté
    func isNotFromTheSameSide() -> Bool
    {
        return (startedLeft && positionAttachRight != -1) || (!startedLeft && positionAttachLeft != -1)
    }
    
    // Retourne true si la liaison entre deux attaches est correcte
    func matchIsGood() -> Bool {
        
        return imageOrder[positionAttachLeft] == nameOrder[positionAttachRight]
    }
    
    // S'il y a des erreurs alors
        // On affiche un message d'erreur
        // On vide la vue contenant les liaisons fausses
        // On reset le nombre de mauvaises liaisons
        // Dans les tableaux permettant de savoir quelles attaches sont reliées, on met à false les attaches faussement reliées afin de notifier qu'elles ne sont plus reliées
    // Sinon on affiche le bouton "Suivant"
    func validate() {
        
        if numberOfGoodMatch != 6 {
            
            self.MessageErreur.text = "You made some mistakes !"
            self.MessageErreur.textAlignment = .center
            
            alertErrorMessage()
            
            self.imageFalseView.image = nil
            
            numberOfWrongMatch = 0
            
            for posLeft in tabFalseMatchLeft {
               
                tabAttachLeftConnected[posLeft] = false
            }
            
            for posRight in tabFalseMatchRight {
               
                tabAttachRightConnected[posRight] = false
            }
        }
        else {
            
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

    
    
    
    // Fonction faisant clignoter le message d'erreur
    // Tous les multiples de 2 le message est affichée
    // Tous les multiples de 4 le message est cachée
    // Et ce jusqu'à 14, à 14 le message reste affiché jusqu'à 24 où on le cache
    func alertErrorMessage() {
        
        delay(timeDisplayMessageError + progressiveTime) { self.MessageErreur.alpha = 0 }
        delay(timeDisplayMessageError + progressiveTime * 2) { self.MessageErreur.alpha = 1 }
        delay(timeDisplayMessageError + progressiveTime * 4) { self.MessageErreur.alpha = 0 }
        delay(timeDisplayMessageError + progressiveTime * 6) { self.MessageErreur.alpha = 1 }
        delay(timeDisplayMessageError + progressiveTime * 8) { self.MessageErreur.alpha = 0 }
        delay(timeDisplayMessageError + progressiveTime * 10) { self.MessageErreur.alpha = 1 }
        delay(timeDisplayMessageError + progressiveTime * 12) { self.MessageErreur.alpha = 0 }
        delay(timeDisplayMessageError + progressiveTime * 14) { self.MessageErreur.alpha = 1 }
        delay(timeDisplayMessageError + progressiveTime * 28) { self.MessageErreur.alpha = 0 }
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
