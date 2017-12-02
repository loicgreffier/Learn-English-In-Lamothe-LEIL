//
//  ViewController.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 20/12/2016.
//  Copyright © 2016 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit

class ExoSelectionViewController: UIViewController {

    var theme: Theme!
    
    @IBOutlet weak var Vocab: UIButton!
    @IBOutlet weak var Match: UIButton!
    @IBOutlet weak var PutInOrder: UIButton!
    @IBOutlet weak var WhatIsIt: UIButton!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.647, green: 0.796, blue: 0.8862, alpha: 1)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.Vocab.translatesAutoresizingMaskIntoConstraints = true
        self.Vocab.center.x -= view.bounds.width
        self.Match.translatesAutoresizingMaskIntoConstraints = true
        self.Match.center.y += view.bounds.width
        self.PutInOrder.translatesAutoresizingMaskIntoConstraints = true
        self.PutInOrder.center.y -= view.bounds.width
        self.WhatIsIt.translatesAutoresizingMaskIntoConstraints = true
        self.WhatIsIt.center.x += view.bounds.width

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.5, delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [], animations: {
                        self.Vocab.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.1,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [], animations: {
                        self.Match.center.y -= self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [], animations: {
                        self.PutInOrder.center.y += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3    ,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [], animations: {
                        self.WhatIsIt.center.x -= self.view.bounds.width
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "matchSegue" {
            
            let matchView = segue.destination as! MatchViewController
            matchView.theme = self.theme
        }
        
        if segue.identifier == "vocabularySegue" {
            
            let vocabView = segue.destination as! VocabularyViewController
            vocabView.theme = self.theme
        }
        
        if segue.identifier == "PutInOrderSegue" {
            
            let PutInOrderView = segue.destination as! PutInOrderViewController
            PutInOrderView.theme = self.theme
        }
        
        if segue.identifier == "WhatIsItSegue" {
            
            let WhatIsIt = segue.destination as! WhatIsItViewController
            WhatIsIt.theme = self.theme
        }

    }
}

