//
//  Batman.swift
//  BattleHeroes
//
//  Created by Vitaliy Delidov on 10/7/15.
//  Copyright © 2015 Vitaliy Delidov. All rights reserved.
//

import Foundation

enum BatmanParameter: Int {
    case Сritical = 0
    case Luck
    case Stun
}

class Batman: Hero {
    
    override init() {
        super.init()
        self.name = "Batman"
    }
    
    override func attack(hero: Hero) {
        let bonus = Int(arc4random_uniform(3))
        let parameter = randomParam()
        if bonus == parameter.rawValue {
            switch parameter {
            case .Сritical:
                log = "\(name) critical hit!"
                attack *= 2;
            case .Luck:
                log = "Luck befalls \(name)!"
                attack += 20;
            case .Stun:
                log = "\(name) perform stun!"
                attack += 10;
            }
        }
        super.attack(hero)
    }
    
    func randomParam() -> BatmanParameter {
        let random = Int(arc4random_uniform(3))
        let param = BatmanParameter(rawValue: random)
        return param!
    }
    
}
