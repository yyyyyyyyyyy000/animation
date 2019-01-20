//
//  Deck(model).swift
//  animation
//
//  Created by 无敌帅的yyyyy on 2019/1/19.
//  Copyright © 2019年 无敌帅的yyyy. All rights reserved.
//

import Foundation
struct playingCardDeck {
    private(set) var cards=[playingCard]()
    
    init(){
        for suit in playingCard.Suit.all{
            for rank in playingCard.Rank.all{
                cards.append(playingCard(suit:suit,rank:rank))
            }
        }
    }
    mutating func draw()->playingCard?{
        if cards.count>0{
            return cards.remove(at: cards.count.arc4random)
        }else{
            return nil
        }
    }
    
    
    
}

extension Int{
    var arc4random: Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}
