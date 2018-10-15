//
//  itemScrollView.swift
//  ScrollViewDemo
//
//  Created by NguyenManh on 10/7/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class ItemScrollView: UIView {
    @IBOutlet weak var imagBackground: UIImageView!
    @IBOutlet weak var lblBackground: UILabel!
    
    @IBOutlet weak var lblTut: UILabel!
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            var distance = hypot(position.x - center.x, position.y - center.y)
            var radius = self.frame.size.width / 2
            
            if distance <= radius {
                self.lblBackground.center = position
            } else {
        
                self.lblBackground.center = CGPoint(x: position.x / distance * radius, y: position.y / distance * radius)
            }
//            print(position.x)
//            print(position.y)
//           self.lblBackground.frame.origin = CGPoint(x:position.x,y:position.y)
        
//            let oldLocation = touches.first?.previousLocation(in: self)
//            let newLocation = touches.first?.location(in: self)
//            move(with: CGPoint(x: (newLocation?.x)! - (oldLocation?.x)!, y: (newLocation?.y)! - (oldLocation?.y)!))
        
//        }
        }
//    private func move(with offset: CGPoint) {
//        self.lblBackground.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
//
//    }
    }

}
