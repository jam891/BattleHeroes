//
//  ArenaViewController.swift
//  BattleHeroes
//
//  Created by Vitaliy Delidov on 10/7/15.
//  Copyright © 2015 Vitaliy Delidov. All rights reserved.
//

import UIKit

class ArenaViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var arena: Arena!
    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLogBattle:", name:logActionDidChangeNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - Notifications
    
    func showLogBattle(notification: NSNotification) {
        let string = notification.userInfo?[logActionNotificationKey] as? String
        let words = string!.componentsSeparatedByString(" ")
        for word in words {
            if word.hasSuffix("winner!") {
                let winner = words[0]
                showAlertWinner(winner)
            }
        }
        textView.text = "\(textView.text)\n\(string!)"
        textView.scrollRangeToVisible(textView.selectedRange)
    }

    func createHeroes() -> [Hero] {
        let batman = Batman()
        let spiderman = Spiderman()
        let superman = Superman()
        let robin = Batman(name: "Robin", health: 250, attack: 30)
        let superwomen = Superman(name: "Superwomen", health: 350, attack: 40)
        
        var heroes = [Hero]()
        heroes.append(batman)
        heroes.append(spiderman)
        heroes.append(superman)
        heroes.append(robin)
        heroes.append(superwomen)
        
        return heroes
    }
    
    //MARK: - Actions
    
    @IBAction func actionNewGame(sender: UIButton) {
        heroes = createHeroes()
        arena = Arena(heroes: heroes)
        tableView.reloadData()
        textView.text = ""
    }
    
    @IBAction func actionNextMove(sender: UIButton) {
        if arena != nil {
            if arena.allHeroes.count > 1 {
                arena.nextMove()
                tableView.reloadData()
            }
        }
    }
    
    func showAlertWinner(winner: String) {
        let alertController = UIAlertController(title: "Victorious:", message: winner, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let hero = heroes[indexPath.row]
        let criticalHp = Int(30.0 / 100.0 * Double(hero.maxHp))
        
        cell.textLabel?.text = hero.name
        cell.detailTextLabel?.textColor = hero.currentHp < criticalHp ? UIColor.redColor() : UIColor.greenColor()
        cell.detailTextLabel?.text = "\(hero.currentHp)/\(hero.maxHp)"
        
        return cell
    }

}
