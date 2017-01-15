//
//  ListGesturesHelper.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController {
    func configureRecognizers(){
        self.originalFrame = self.bottomView.frame
        //let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGR(_:)))
        //tapGR.delegate = self
        //self.bottomView.addGestureRecognizer(tapGR)
        self.addPanGR()
    }
    
    func addPanGR(){
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGR(_:)))
        self.bottomView.addGestureRecognizer(panGR)
    }
    
    
    //    func handleTapGR(recognizer: UITapGestureRecognizer){
    //        if self.bottomView.y != (self.view.frame.height * 7/10){
    //
    //        }
    //    }
    
    func handlePanGR(_ recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        let viewTranslation = originalFrame.origin.y + translation.y
        
        if recognizer.state == .changed {
            if (viewTranslation > (self.view.height * topMapProportion)) && (viewTranslation < (self.view.height * bottomMapProportion)) {
                self.bottomView.y = originalFrame.origin.y + translation.y
            }
            // let height = self.view.frame.maxY - self.bottomView.frame.minY + self.indicatorView.height
            
            let maxY = 0.7 * self.view.height
            self.mapView.alpha  = (self.bottomView.frame.minY - 135) / maxY
            
        }else if recognizer.state == .ended{
            
            let velocity = recognizer.velocity(in: self.view)
            let slideMultiplier = velocity.y / 200
            
            let slideFactor: CGFloat = 4 // Increase for more of a slide
            
            var finalY = self.bottomView.y + (slideFactor * slideMultiplier)
            
            let topBound = (self.view.frame.height * topMapProportion)
            let bottomBound = (self.view.frame.height * bottomMapProportion)
            
            var finalAlpha: CGFloat = 0
            
            if finalY < topBound || velocity.y < -1500{
                finalY = topBound
                finalAlpha = 1
            }
            
            if finalY > bottomBound || velocity.y > 1500{
                finalY = bottomBound
                finalAlpha = 0
            }
            
            if finalY < topBound + 0.25 * self.mapView.height {
                finalY = topBound
                finalAlpha = 1
            }else if finalY > bottomBound - 0.25 * self.mapView.height {
                finalY = bottomBound
                finalAlpha = 0
            }
            
            UIView.animate(withDuration: Double(slideFactor/10), delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 4, options: .curveEaseOut, animations: {
                recognizer.view!.y = finalY
                self.bannerView.alpha = finalAlpha
            }, completion: { (_) in
                self.originalFrame = self.bottomView.frame
            })
        }
        
    }
    
    func handleTouchRemoved(_ view: UIView){
        originalFrame = self.bottomView.frame
    }
}
