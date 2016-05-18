//
//  SlideMenu.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-28.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class SlideMenu: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    //skapar variabler så vi kan ändra hur stor menyn ska vara
    var height:CGFloat = 0.0
    var isPresenting = false
    var moved:CGFloat = 0.0
    var snap:UIView?
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        //sätter höjd för hur menyn ska visas
        let container = transitionContext.containerView()
        let moveDown = CGAffineTransformMakeTranslation(0,moved)
        let moveUp = CGAffineTransformMakeTranslation(0, height)
        //visar menyn och tar screencap av förra veiw för att visa
        if isPresenting{
            toView.transform = moveUp
            snap = fromView.snapshotViewAfterScreenUpdates(true)
            container!.addSubview(toView)
            container!.addSubview(snap!)
        }
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options:[] , animations: {
            //tar ner eller upp menyn
            if self.isPresenting{
                self.snap?.transform = moveDown
                toView.transform = CGAffineTransformIdentity
            }
            else{
                self.snap?.transform = CGAffineTransformIdentity
                fromView.transform = moveUp
            }
            
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                if !self.isPresenting {
                    self.snap?.removeFromSuperview()
                }
        })
        
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    
}
