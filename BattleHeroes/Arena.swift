//
//  Arena.swift
//  BattleHeroes
//
//  Created by Vitaliy Delidov on 10/7/15.
//  Copyright © 2015 Vitaliy Delidov. All rights reserved.
//

import Foundation

class Arena {
    
    var allHeroes: [Hero]
    
    init(heroes: [Hero]) {
        self.allHeroes = heroes
    }
    
    func nextMove() {
        var aliveHeroes = allHeroes.count
        
        var attacker: Hero!
        repeat {
            attacker = randomHero(allHeroes)
        } while attacker.isMoved
        
        var defender: Hero!
        repeat {
            defender = randomHero(allHeroes)
        } while attacker == defender
        
        let criticalHp = Int(30.0 / 100.0 * Double(attacker.maxHp))
        if attacker.currentHp < criticalHp {
            attacker.updateParameter(.Health)
        } else {
            attacker.attack(defender)
        }
        
        if attacker.isDead || defender.isDead {
            let killed = attacker.isDead ? attacker : defender
            let index = allHeroes.indexOf(killed)
            allHeroes.removeAtIndex(index!)
            --aliveHeroes
            
            if aliveHeroes == 1 {
                let winner = allHeroes.last!
                winner.log = "\(winner.name) is the winner!"
            }
        }
        
        var allMoves = 0
        for hero in allHeroes {
            if hero.isMoved {
                ++allMoves
            }
            hero.updateParameter(.Attack)
        }
        if allMoves == aliveHeroes {
            clearAllMoves(allHeroes)
        }

    }
    
    private func randomHero(heroes: [Hero]) -> Hero {
        let index = Int(arc4random_uniform(UInt32(heroes.count)))
        return heroes[index]
    }
    
    private func clearAllMoves(heroes: [Hero]) {
        for hero in heroes {
            hero.isMoved = false
        }
    }

}

