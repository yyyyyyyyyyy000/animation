//
//  cardBehavior.swift
//  animation
//
//  Created by 无敌帅的yyyyy on 2019/1/20.
//  Copyright © 2019年 无敌帅的yyyy. All rights reserved.
//

import UIKit

class cardBehavior: UIDynamicBehavior {
     var collidebehavior:UICollisionBehavior = {
        let collide = UICollisionBehavior()
        collide.translatesReferenceBoundsIntoBoundary = true
        return collide
    }()
    var itembehavior:UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.resistance = 0
        behavior.elasticity = 1.1
        behavior.allowsRotation = false
        return behavior
    }()
    
    private func push(_ item:UIDynamicItem){
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds{
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch(item.center.x,item.center.y){
            case let(x,y) where x<center.x&&y<center.y:
                push.angle = (CGFloat.pi/2).arc4random()
            case let (x,y) where x>center.x&&y<center.y:
                push.angle = CGFloat.pi-(CGFloat.pi/2).arc4random()
            case let (x,y) where x<center.x&&y>center.y:
                push.angle = (-CGFloat.pi/2).arc4random()
            case let (x,y) where x>center.x&&y>center.y:
                push.angle = CGFloat.pi+(CGFloat.pi/2).arc4random()
            default:break
        }
        }
        push.magnitude = CGFloat(1)+(CGFloat(2)).arc4random()
        push.action = {[unowned push,weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    func additem(_ item:UIDynamicItem){
        itembehavior.addItem(item)
        collidebehavior.addItem(item)
        push(item)
    }
    func renmoveitem(_ item:UIDynamicItem){
        itembehavior.removeItem(item)
        collidebehavior.removeItem(item)
    }
    
    
    
    
    override init(){
        super.init()
        addChildBehavior(collidebehavior)
        addChildBehavior(itembehavior)
    }
}
