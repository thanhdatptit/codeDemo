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
  
    var isDragging: Bool = false
    var oldX: CGFloat = 0
    var oldY: CGFloat = 0
    override func layoutSubviews() {
        let panGest : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveAround))
        lblBackground.isUserInteractionEnabled = true
        lblBackground.addGestureRecognizer(panGest)
        print("lbl : \(lblBackground)")
    }
    
    @objc func moveAround(panGes : UIPanGestureRecognizer)  {
        
        if panGes.state == UIGestureRecognizerState.changed{
            var centerP = panGes.view?.center
            let trans = panGes.translation(in: self)
            centerP = CGPoint(x: (centerP?.x)! + trans.x  , y: (centerP?.y)! + trans.y )
            let pointExp = CGPoint(x: (centerP?.x)! + self.frame.origin.x, y: (centerP?.y)!)
            
            if self.frame.contains(pointExp){
                panGes.view?.center = centerP!
                panGes.setTranslation(CGPoint.zero, in: self)
            }
    }
    }
//        if (pgr.state == UIGestureRecognizerStateChanged) {
//            //    CGPoint center = pgr.view.center;
//            //    CGPoint translation = [pgr translationInView:pgr.view];
//            //    center = CGPointMake(center.x + translation.x,
//            //    center.y + translation.y);
//            //    pgr.view.center = center;
//            //    [pgr setTranslation:CGPointZero inView:pgr.view];
//
//    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let position = touch.location(in: self)
//            var distance = hypot(position.x - center.x, position.y - center.y)
//            var radius = self.frame.size.width / 2
//
//            if distance <= radius {
//                self.lblBackground.center = position
//            } else {
//
//                self.lblBackground.center = CGPoint(x: position.x / distance * radius, y: position.y / distance * radius)
//            }
////            print(position.x)
////            print(position.y)
////           self.lblBackground.frame.origin = CGPoint(x:position.x,y:position.y)
//
////            let oldLocation = touches.first?.previousLocation(in: self)
////            let newLocation = touches.first?.location(in: self)
////            move(with: CGPoint(x: (newLocation?.x)! - (oldLocation?.x)!, y: (newLocation?.y)! - (oldLocation?.y)!))
//
////        }
//        }
////    private func move(with offset: CGPoint) {
////        self.lblBackground.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
////
////    }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        let touch: UITouch = touches.first!
//        let touchLocation = touch.location(in: self)
//
//        if lblBackground.frame.contains(touchLocation) {
//            isDragging = true
//            oldX = touchLocation.x - self.frame.origin.x
//            oldY = touchLocation.y - self.frame.origin.y
//        }
//
//    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch: UITouch = touches.first!
//        let touchLocation = touch.location(in: self)
//
//        if isDragging {
//
//            var frameP = lblBackground.frame
//           lblBackground.center.x =   touchLocation.x - self.frame.origin.x ;
//            lblBackground.center.y = touchLocation.y - self.frame.origin.y;
////            lblBackground.frame = frameP;
//        }
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isDragging = false
//    }
    
//    UIPanGestureRecognizer* pgr = [[UIPanGestureRecognizer alloc]
//    initWithTarget:self
//    action:@selector(handlePan:)];
//    [self.panningView addGestureRecognizer:pgr];
//    [pgr release];
//    -(void)handlePan:(UIPanGestureRecognizer*)pgr;
//    {
//    if (pgr.state == UIGestureRecognizerStateChanged) {
//    CGPoint center = pgr.view.center;
//    CGPoint translation = [pgr translationInView:pgr.view];
//    center = CGPointMake(center.x + translation.x,
//    center.y + translation.y);
//    pgr.view.center = center;
//    [pgr setTranslation:CGPointZero inView:pgr.view];
//    }
//    }
}
