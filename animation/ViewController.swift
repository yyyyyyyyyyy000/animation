//
//  ViewController.swift
//  animation
//
//  Created by 无敌帅的yyyyy on 2019/1/19.
//  Copyright © 2019年 无敌帅的yyyy. All rights reserved.
//

import UIKit
@IBDesignable
class ViewController: UIViewController {
    private var deck = playingCardDeck()
    
    @IBOutlet private var cardViews: [playingcardView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
     var cardbehavior = cardBehavior()
     override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(cardbehavior)
        var cards = [playingCard]()
        for _ in 1...((cardViews.count/2)){
            let card = deck.draw()!
            cards += [card,card]
        }
        for cardView in cardViews{
            cardView.isFaceup = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipcard)))
            cardbehavior.additem(cardView)
        }
    }
    private var faceUpcard:[playingcardView]{
        return cardViews.filter({$0.isFaceup && !$0.isHidden })
    }
    
    private var ismatched:Bool{
        return faceUpcard[0].suit == faceUpcard[1].suit && faceUpcard[0].rank == faceUpcard[1].rank
    }
    
    
    @objc func flipcard(_ recognizer:UITapGestureRecognizer){
        if let view = recognizer.view as? playingcardView,faceUpcard.count<2{
            cardbehavior.renmoveitem(view)
            UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromTop, animations: {view.isFaceup = !view.isFaceup}, completion: {finished in
                if self.faceUpcard.count == 2{
                    if !self.ismatched{
                        self.faceUpcard.forEach{view in
                            UIView.transition(with: view, duration: 0.7, options: .transitionFlipFromTop, animations: {view.isFaceup = false},completion:{finished in self.cardbehavior.additem(view)})
                        }
                    }else{
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, animations: {
                            for view in self.faceUpcard{
                                view.transform = CGAffineTransform.identity.scaledBy(x: 3, y: 3)
                            }
                        }, completion: {position in
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.7, delay: 0,animations: {
                                for view in self.faceUpcard{
                                    view.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                    view.alpha = 0
                                }
                            }, completion: {finished in
                                for view in self.faceUpcard{
                                    view.isFaceup = false
                                    view.isHidden = true
                                }
                            })
                        })
                    }
                }else if !view.isFaceup{
                    self.cardbehavior.additem(view)
                }
            }
            )
        }
    }
}

extension CGFloat{
    func arc4random()->CGFloat{
        if self>0{
        return CGFloat(arc4random_uniform(UInt32(self)))
        }else if self == 0{
            return 0
        }else{
            return  CGFloat(arc4random_uniform(UInt32(-self)))
        }
    }
    
}
