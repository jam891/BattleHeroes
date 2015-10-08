//
//  Spiderman.swift
//  BattleHeroes
//
//  Created by Vitaliy Delidov on 10/8/15.
//  Copyright © 2015 Vitaliy Delidov. All rights reserved.
//

import Foundation

enum SpidermanParameter: Int {
    case Shot = 0
    case Entangling
}

class Spiderman: Hero {

    override init() {
        super.init()
        self.name = "Spiderman"
    }
    
    override func attack(hero: Hero) {
        let bonus = Int(arc4random_uniform(3))
        let parameter = randomParam()
        if bonus == parameter.rawValue {
            switch parameter {
            case .Shot:
                log = "\(name) shot!"
                attack *= 2
            case .Entangling:
                log = "\(name) perform entangling!"
                attack += 25
            }
        }
        super.attack(hero)
    }
    
    func randomParam() -> SpidermanParameter {
        let random = Int(arc4random_uniform(2))
        let param = SpidermanParameter(rawValue: random)
        return param!
    }


}