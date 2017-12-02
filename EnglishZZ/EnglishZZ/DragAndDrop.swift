//
//  DragAndDrop.swift
//  EnglishZZ
//
//  Created by Theo BULLAT on 08/01/2017.
//  Copyright © 2017 Theo BULLAT Loïc GREFFIER. All rights reserved.
//

import UIKit

class DragAndDrop: UIView {

    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        print("init")
        
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
        self.gestureRecognizers = [panRecognizer]
        
        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        //let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        //let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        
        print("detectpan")
        let translation  = recognizer.translation(in: self.superview!)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch")
        // Promote the touched view
        self.superview?.bringSubview(toFront: self)
        
        // Remember original location
        lastLocation = self.center
    }

}
