//
//  InfoViewController.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 04/03/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit
import AVFoundation


class InfoViewController : UIViewController {

    @IBOutlet weak var DevelopLabel: UIStackView!
    @IBOutlet weak var IdeeLabel: UIStackView!
    @IBOutlet weak var SuperviseLabel: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DevelopLabel.center.x  += view.bounds.width
        self.DevelopLabel.translatesAutoresizingMaskIntoConstraints = true
        IdeeLabel.center.x -= view.bounds.width
        self.IdeeLabel.translatesAutoresizingMaskIntoConstraints = true
        SuperviseLabel.center.x += view.bounds.width
        self.SuperviseLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.DevelopLabel.center.x -= self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [],
                       animations: {
                        self.IdeeLabel.center.x += self.view.bounds.width
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.3, delay: 0.4, options: [],
                       animations: {
                        self.SuperviseLabel.center.x -= self.view.bounds.width
        },
                       completion: nil
        )
    }
}
