//
//  CircularTransition.swift
//  wordcoin3
//
//  Created by admin on 21.02.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    public var circle = UIView()
    
    var startingpoint = CGPoint.zero{
        didSet{
            circle.center = startingpoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.3
    enum CircularTransitionMode:Int{
        case present, dismiss, pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
}

extension CircularTransition: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let conteinerView = transitionContext.containerView
        
        
        if transitionMode == .present{
            
            if let presenteView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let  viewCenter = presenteView.center
                let viewSize = presenteView.frame.size
                
                circle = UIView()
                circle.frame = framefromCircle(withVieewCenter: viewCenter, size: viewSize, startPoint: startingpoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingpoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                conteinerView.addSubview(circle)
                
                presenteView.center = startingpoint
                presenteView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presenteView.alpha = 0
                conteinerView.addSubview(presenteView)
                
                UIView.animate(withDuration: duration, animations: {self.circle.transform = CGAffineTransform.identity
                    presenteView.transform = CGAffineTransform.identity
                    presenteView.alpha = 1
                    presenteView.center = viewCenter
                    
                }, completion: {(success:Bool) in
                        transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returnView = transitionContext.view(forKey: transitionModeKey){
                let viewCenter = returnView.center
                let viewSize = returnView.frame.size
                
                circle.frame = framefromCircle(withVieewCenter: viewCenter, size: viewSize, startPoint: startingpoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingpoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returnView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returnView.center = self.startingpoint
                    returnView.alpha = 0
                    if self.transitionMode == .pop{
                        conteinerView.insertSubview(returnView, belowSubview: returnView)
                        conteinerView.insertSubview(self.circle, belowSubview: returnView)
                    }
                }, completion: {(success:Bool) in
                    returnView.center = viewCenter
                    returnView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                })
            }
        }
    }
}



func framefromCircle (withVieewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint:CGPoint) -> CGRect{
    let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
    let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
    let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
    let size = CGSize(width: offestVector, height: offestVector)
    return CGRect(origin: CGPoint.zero, size: size)
}
