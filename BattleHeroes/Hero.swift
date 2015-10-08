//
//  Hero.swift
//  BattleHeroes
//
//  Created by Vitaliy Delidov on 10/7/15.
//  Copyright © 2015 Vitaliy Delidov. All rights reserved.
//

import Foundation

let logActionNotificationKey = "logActionNotificationKey"
let logActionDidChangeNotification = "logActionDidChangeNotification"

enum HeroParameter {
    case Health
    case Attack
}

class Hero: NSObject {
    private var baseAttack: Int
    
    var name: String
    var maxHp: Int
    var attack: Int
    var isDead: Bool
    var isMoved: Bool
    var currentHp: Int {
        didSet {
            if currentHp < 0 {
                currentHp = 0
            }
        }
    }
    
    override var description : String {
        return name
    }
    
    var log: String? {
        get {
            return "Hello"
        }
        set {
            let userInfo = [logActionNotificationKey : newValue!]
            NSNotificationCenter.defaultCenter().postNotificationName(logActionDidChangeNotification, object: nil, userInfo: userInfo)
        }
    }
    
    override init() {
        self.name = ""
        self.maxHp = 200
        self.currentHp = 200
        self.attack = 50
        self.baseAttack = 50
        self.isMoved = false
        self.isDead = false
    }
    
    convenience init(name: String, health: Int, attack: Int) {
        self.init()
        self.name = name
        self.maxHp = health
        self.currentHp = health
        self.attack = attack
        self.baseAttack = attack
    }
    
    func attack(hero: Hero) {
        hero.currentHp -= attack
        hero.isDead = hero.currentHp > 0 ? false : true
        log = logAttack(hero)
        if !hero.isDead {
            hero.attack /= 2
            currentHp -= hero.attack
            isDead = currentHp > 0 ? false : true
            log = hero.logAttack(self)
        }
        isMoved = true
    }

    func updateParameter(parameter: HeroParameter) {
        switch parameter {
        case .Health:
            log = "\(name) drink \"Elixir of Health\""
            currentHp = maxHp
            isMoved = true
        case .Attack:
            attack = baseAttack
        }
    }
    
    private func logAttack(hero: Hero) -> String {
        let log = "\(self) deal \(attack) damage to \(hero)."
        let tail = "\n\(hero) perish."
        
        if hero.isDead {
            return log.stringByAppendingString(tail)
        } else {
            return log
        }
    }
    

    
}