//
//  ThemeSelectionViewController.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 05/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit

class ThemeSelectionViewController: UIViewController {

    @IBOutlet weak var StackViewButtons: UIStackView!
    
    var theme: Theme!
    
    // Accès aux fonctions de la classe ModeleTheme
    var modeleTheme = ModeleTheme()
    
    // Liste de tous nos thèmes
    var listTheme = [Theme]()
    
    // Coordonnées des bouttons
    var coordonneeX: CGFloat!
    var coordonneeY: CGFloat!
    
    // Au chargement de la fenêtre, on place tous les bouttons en fonction du nombre de thèmes récupérés en base
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)
        coordonneeX = self.StackViewButtons.frame.origin.x + 50
        coordonneeY = self.StackViewButtons.frame.origin.y - 100

        listTheme = modeleTheme.getAllThemes()
    
        for i in 0...listTheme.count-1 {
        
            setButtonsOnStackView(i: i)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for theme in StackViewButtons.arrangedSubviews {
            theme.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var delay = 0.0
        var i = 0
        for theme in self.StackViewButtons.subviews {
            UIView.animate(withDuration: 0.8,delay: delay,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 0.5,
                           options: [], animations:
                {
                    let size = CGSize.init(width: theme.frame.width+20 , height: theme.frame.height+20)
                    theme.frame = CGRect.init(origin: theme.frame.origin, size: size)
                }, completion: nil)
            if i % 2 == 1 {
                delay += 0.05
                if i % 8 == 7{
                    delay -= 0.2
                }
            }
            i += 1
        }
    }

    
    
    
    

    // Fonction appelée lorsque l'on clique sur un thème
    // On charge le vocabulaire associé au thème séléctionné
    // On charge la fenêtre suivante
    // On transmet le thème à la fenêtre suivante
    // On lance la fenêtre
    func buttonClick(sender: UIButton!) {
        theme = modeleTheme.getThemeAndVocabulary(identifier: listTheme[sender.tag].getName())
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SIDExoSelection") as! ExoSelectionViewController
        
        nextViewController.theme = self.theme
        
        self.present(nextViewController, animated:true, completion:nil)
    }

    // Fonction permettant de placer les éléments sur la fenêtre d'accueil
    func setButtonsOnStackView(i: Int) {
        let buttonImage = UIButton(frame: CGRect(x: coordonneeX, y: coordonneeY, width: 150, height: 150))
        customImageButtons(buttonToCustom: buttonImage, indice: i)
        
        let buttonThemeName = UIButton(frame: CGRect(x: coordonneeX+25, y: coordonneeY+130, width: 100, height: 100))
        customTextButtons(buttonToCustom: buttonThemeName, indice: i)
        
        self.StackViewButtons.addSubview(buttonImage)
        self.StackViewButtons.addSubview(buttonThemeName)
        
        coordonneeX = coordonneeX + 250
        
        if coordonneeX >= 1000 {
            
            coordonneeY = coordonneeY + 200
            
            coordonneeX = self.StackViewButtons.frame.origin.x + 50
        }
    }
    
    // Fonction permettant de gérer les effets visuels des boutons images
    func customImageButtons(buttonToCustom: UIButton, indice: Int) {
        
        buttonToCustom.setImage(UIImage.init(named: listTheme[indice].getImageName()), for: UIControlState.normal)
        buttonToCustom.tag = indice
        buttonToCustom.addTarget(self, action: #selector(ThemeSelectionViewController.buttonClick(sender:)), for: .touchUpInside)
    }
    
    // Fonction permettant de gérer les effets visuels des boutons textes
    func customTextButtons(buttonToCustom: UIButton, indice: Int) {
        
        buttonToCustom.setTitle(listTheme[indice].getName(), for: UIControlState.normal)
        buttonToCustom.setTitleColor(UIColor.black, for: UIControlState.normal)
        buttonToCustom.titleLabel?.font = UIFont(name: "Back_to_School_", size: 20)
        buttonToCustom.tag = indice
        buttonToCustom.addTarget(self, action: #selector(ThemeSelectionViewController.buttonClick(sender:)), for: .touchUpInside)
    }
    
    // Affiche toutes les polices disponibles sur l'iPad dans les logs
    func displayFontsAvailableOnIPad() {
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
}
