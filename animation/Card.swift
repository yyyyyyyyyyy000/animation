//
//  Card.swift
//  animation
//
//  Created by 无敌帅的yyyyy on 2019/1/19.
//  Copyright © 2019年 无敌帅的yyyy. All rights reserved.
//

import Foundation
struct playingCard:CustomStringConvertible{
    var description: String{
        return "\(suit)\(rank)"
    }
    
    var suit : Suit
    var rank : Rank
    
    enum Suit: String,CustomStringConvertible{
        var description: String{
            return rawValue
        }
        
        
        case spades="♠️"
        case hearts="♥️"
        case diamonds="♦️"
        case clubs="♣️"
        
        static var all=[Suit.spades,.hearts,.diamonds,.clubs]
        
    }
    enum Rank:CustomStringConvertible{
        var description: String{
            switch self{
            case .ace: return "A"
            case .numeric(let numb): return "\(numb)"
            case .face(let kind): return kind
            }
        }
        
        case ace
        case numeric(Int)
        case face(String)
        
        var order:Int{
            switch self{
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J" :return 11
            case .face(let kind) where kind == "Q" :return 12
            case .face(let kind) where kind == "K" :return 13
            default:return 0
            }
        }
        
        static var all:[Rank]{
            var allrank=[Rank.ace]
            for pips in 2...10{
                allrank.append(Rank.numeric(pips))
            }
            allrank+=[Rank.face("J"),.face("Q"),.face("K")]
            return allrank
        }
        
    }
    
    
}
