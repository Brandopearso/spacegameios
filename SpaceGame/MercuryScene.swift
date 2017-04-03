//
//  GameScene.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 9/12/16.
//  Copyright (c) 2016 Brandon  Pearson . All rights reserved.
//

import SpriteKit
import AVFoundation

protocol DeathSceneDelegate {
    
    func launchViewController(_ scene: SKScene)
}

import SpriteKit
import AVFoundation
import UIKit

class MercuryScene: SKScene, SKPhysicsContactDelegate {
    
    let level = Level()
    var collisionDelegate: DeathSceneDelegate?
    var level_name:String = ""
    
    override func didMove(to view: SKView) {
        
        print("final level name:")
        print(level_name)
        level.height = self.size.height
        level.width = self.size.width
        
        // setup physics
        self.physicsWorld.contactDelegate = self
        self.view!.isMultipleTouchEnabled = true;
        
        // add player
        let player = level.player
        player.node.position = CGPoint(x: (self.size.width / 5), y: (self.size.height / 2))
        self.addChild(player.node)
        
        // add fire button
        let button = level.button
        button?.position = CGPoint(x:self.size.width - 100, y:200);
        self.addChild(button!)
        
        // add background
        let background = level.background
        background.size = self.frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        // add score
        let score = level.scoreLabel
        let highscore = level.highscoreLabel
        self.view?.addSubview(score)
        self.view?.addSubview(highscore)
        
        // enemy timer
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MercuryScene.spawnEnemy), userInfo: nil, repeats: true)
        
        let pauseButton = level.pauseButton
        pauseButton?.position = CGPoint(x:self.size.width - 200, y: self.size.height - 130)
        addChild(pauseButton!)
        
        let saveButton = level.saveButton
        saveButton?.position = CGPoint(x:self.size.width - 100, y: self.size.height - 130)
        addChild(saveButton!)
    }
    
    func died() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        _ = mainStoryboard.instantiateViewController(withIdentifier: "Death") as! DeathViewController
        let savescoreDefault = UserDefaults.standard
        savescoreDefault.setValue(0, forKey: "Savescore")
        savescoreDefault.synchronize()
        
        self.collisionDelegate!.launchViewController(self)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        let randomIntForWeaponPowerup:UInt32 = arc4random_uniform(4)
        let randomIntForSpawnPowerup:UInt32 = arc4random_uniform(4)
        
        if ((firstBody.categoryBitMask == physicsCategory.enemy) && secondBody.categoryBitMask == physicsCategory.player) {
            
            level.PlayerCollisionWithEnemy(secondBody.node as! SKSpriteNode, enemy: firstBody.node as! SKSpriteNode)
            died()
        }
        if ((firstBody.categoryBitMask == physicsCategory.player) && secondBody.categoryBitMask == physicsCategory.enemy) {
            
            level.PlayerCollisionWithEnemy(firstBody.node as! SKSpriteNode, enemy: secondBody.node as! SKSpriteNode)
            died()
        }
        
        if ((firstBody.categoryBitMask == physicsCategory.enemy) && (secondBody.categoryBitMask == physicsCategory.bullet)) {
            
            let enemy  = firstBody.node
            
            for (i, enemy_i) in level.enemylist.enumerated() {
                
                if (enemy_i.node.isEqual(to: enemy!)) {
                    
                    enemy_i.health = enemy_i.health - 1
                    
                    if (enemy_i.health <= 0)
                    {
                        level.PlayerCollisionWithBullet(firstBody.node as! SKSpriteNode, bullet: secondBody.node as! SKSpriteNode)
                        let pos:CGPoint = (enemy?.position)!
                        
                        if randomIntForSpawnPowerup == 1 {
                            spawnPowerup(pos, weaponNum:randomIntForWeaponPowerup)
                        }
                        level.enemylist.remove(at: i)
                    }
                }
            }
        }
        
        if((firstBody.categoryBitMask == physicsCategory.powerup) && (secondBody.categoryBitMask == physicsCategory.player)) {
            
            level.PlayerCollisionWithPowerup(secondBody.node as! SKSpriteNode, powerup: firstBody.node as! SKSpriteNode)
        }
        
        if((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.powerup)) {
            
            level.PlayerCollisionWithPowerup(firstBody.node as! SKSpriteNode, powerup: secondBody.node as! SKSpriteNode)
        }
        
        if((firstBody.categoryBitMask == physicsCategory.bullet) && (secondBody.categoryBitMask == physicsCategory.enemy)){
            
            let enemy  = secondBody.node
            
            for (i, enemy_i) in level.enemylist.enumerated() {
                
                if (enemy_i.node.isEqual(to: enemy!)) {
                    
                    enemy_i.health = enemy_i.health - 1
                    
                    if (enemy_i.health <= 0) {
                        
                        level.PlayerCollisionWithBullet(secondBody.node as! SKSpriteNode, bullet: firstBody.node as! SKSpriteNode)
                        let pos:CGPoint = (enemy?.position)!
                        
                        if randomIntForSpawnPowerup == 1 {
                            spawnPowerup(pos, weaponNum:randomIntForWeaponPowerup)
                        }
                        level.enemylist.remove(at: i)
                    }
                }
            }
        }
    }
    
    func pauseGame()
    {
        scene!.view!.isPaused = true
    }
    
    func spawnPowerup(_ pos:CGPoint, weaponNum:UInt32) {
        
        var powerup:SKSpriteNode
        
        if weaponNum == 0 {
            powerup = SKSpriteNode(imageNamed: "sprites/redpowerup.png")
            powerup.color = UIColor.red
        }
        else if weaponNum == 1 {
            
            powerup = SKSpriteNode(imageNamed: "sprites/bluepowerup.png")
            powerup.color = UIColor.cyan
        }
        else {
            
            powerup = SKSpriteNode(imageNamed: "sprites/greenpowerup.png")
            powerup.color = UIColor.green
        }
        
        powerup.zPosition = -5
        
        let action = SKAction.moveTo(x: -70, duration: 2.5)
        let actionDone = SKAction.removeFromParent()
        powerup.run(SKAction.sequence([action, actionDone]))
        powerup.position = pos
        
        powerup.physicsBody = SKPhysicsBody(rectangleOf: powerup.size)
        powerup.physicsBody?.categoryBitMask = physicsCategory.powerup
        powerup.physicsBody?.collisionBitMask = 0
        powerup.physicsBody?.contactTestBitMask = physicsCategory.player
        powerup.physicsBody?.affectedByGravity = false
        powerup.physicsBody?.isDynamic = true
        self.addChild(powerup)
    }
    
    
    func spawnEnemy() {
        
        let random_num = arc4random_uniform(10)
        var enemy:Enemy
        if (self.level_name == "mercury") {
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "squid_blue", frames: 0.25, speed:3.0)
                enemy.node.name = "squid_blue"
            }
            else {
                
                enemy = Enemy(type: "squid_blue", frames: 0.25, speed:3.0)
                enemy.node.name = "squid_blue"
            }
        }
        else if (self.level_name == "venus") {
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "squid_blue", frames: 0.25, speed:3.0)
                enemy.node.name = "squid_blue"
            }
            else {
                
                enemy = Enemy(type: "cyclops_blue", frames: 0.25, speed:2.5)
                enemy.node.name = "cyclops_blue"
            }
        }
        else if (self.level_name == "earth"){
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "spider_blue", frames: 0.25, speed:2.0)
                enemy.node.name = "squid_blue"
            }
            else {
                
                enemy = Enemy(type: "cyclops_blue", frames: 0.25, speed:2.5)
                enemy.node.name = "cyclops_blue"
            }
        }
        else if (self.level_name == "mars") {
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "bee_blue", frames: 0.25, speed:1.6)
                enemy.node.name = "bee_blue"
            }
            else {
                
                enemy = Enemy(type: "spider_blue", frames: 0.25, speed:2.0)
                enemy.node.name = "spider_blue"
            }
        }
        else if (self.level_name == "jupiter") {
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "squid_red", frames: 0.25, speed:3.0)
                enemy.node.name = "squid_red"
            }
            else {
                
                enemy = Enemy(type: "bee_blue", frames: 0.25, speed:1.6)
                enemy.node.name = "bee_blue"
            }
        }
        else if (self.level_name == "saturn") {
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "cyclops_red", frames: 0.25, speed:2.5)
            }
            else {
                
                enemy = Enemy(type: "spider_blue", frames: 0.25, speed:2.0)
            }
        }
        else if (self.level_name == "uranus") {
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "cyclops_red", frames: 0.25, speed:2.5)
                enemy.node.name = "cyclops_red"
            }
            else {
                
                enemy = Enemy(type: "spider_red", frames: 0.25, speed:2.0)
                enemy.node.name = "spider_red"
            }
        }
        else {
            
            if random_num % 2 == 0 {
                
                enemy = Enemy(type: "bee_red", frames: 0.25, speed:1.6)
                enemy.node.name = "bee_red"
            }
            else {
                
                enemy = Enemy(type: "spider_red", frames: 0.25, speed:2.0)
                enemy.node.name = "spider_red"
            }
        }
        let minValue = self.size.height / 6
        let maxValue = self.size.width
        let spawnPoint = UInt32(maxValue - minValue)
        
        
        enemy.node.position = CGPoint(x: self.size.width, y: CGFloat(arc4random_uniform(spawnPoint)))
        enemy.height = self.size.height
        enemy.width = self.size.width
        
        level.enemylist.append(enemy)
        self.addChild(enemy.node)
    }
    
    func spawnBullets() {
        
        let action = SKAction.moveTo(x: self.size.width + 30, duration: 1.0)
        let bullet = level.player.spawnBullet(action, isBig: false)
        bullet.position = CGPoint(x: level.player.node.position.x, y: level.player.node.position.y)
        level.playBulletSound()
        
        //add bullet to the scene
        if (level.player.weapon == 0) {
            
            self.addChild(bullet)
        }
        else if (level.player.weapon == 1) {
            
            let action2 = SKAction.moveTo(x: self.size.width + 30, duration: 0.8)
            let bullet2 = level.player.spawnBullet(action2, isBig: false)
            bullet2.position = CGPoint(x: level.player.node.position.x + 10, y: level.player.node.position.y)
            self.addChild(bullet)
            self.addChild(bullet2)
        }
        else {
            let action3 = SKAction.moveTo(x: self.size.width + 30, duration: 1.5)
            let bullet3 = level.player.spawnBullet(action3, isBig: true)
            bullet3.position = CGPoint(x: level.player.node.position.x + 10, y: level.player.node.position.y)
            self.addChild(bullet3)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self)
            
            // Check if the location of the touch is within the button's bounds
            if level.button.contains(location) {
                
                spawnBullets()
            }
            else if level.pauseButton.contains(location) {
                
                if (scene!.view!.isPaused == true) {
                    scene!.view!.isPaused = false
                }
                else {
                    scene!.view!.isPaused = true
                }
            }
            else if level.saveButton.contains(location) {
                
                let savescoreDefault = UserDefaults.standard
                savescoreDefault.setValue(level.score, forKey: "Savescore")
                savescoreDefault.synchronize()
                level.score = savescoreDefault.value(forKey: "Savescore") as! NSInteger!
                print ("saved score")
            }
            else {
                
                level.player.node.position.x = location.x + 130
                level.player.node.position.y = location.y
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            

            if (!level.button.contains(location)) {
                
                level.player.node.position.x = location.x + 130
                level.player.node.position.y = location.y
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
