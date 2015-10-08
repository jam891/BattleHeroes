//
//  Superman.swift
//  BattleHeroes
//
//  Created by Vitaliy Delidov on 10/8/15.
//  Copyright © 2015 Vitaliy Delidov. All rights reserved.
//

import Foundation

enum SupermanParameter: Int {
    case Initiative = 0
    case Teleporter
}

class Superman: Hero {

    override init() {
        super.init()
        self.name = "Superman"
    }
    
    override func attack(hero: Hero) {
        let bonus = Int(arc4random_uniform(3))
        let parameter = randomParam()
        if bonus == parameter.rawValue {
            switch parameter {
            case .Initiative:
                log = "\(name) perform initiative!"
                attack *= 2
            case .Teleporter:
                log = "\(name) perform teleporter!"
                attack += 30
            }
        }
        super.attack(hero)
    }
    
    func randomParam() -> SupermanParameter {
        let random = Int(arc4random_uniform(2))
        let param = SupermanParameter(rawValue: random)
        return param!
    }

}