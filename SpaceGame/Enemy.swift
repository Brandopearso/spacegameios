//
//  Enemy.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 11/5/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import Foundation
import SpriteKit

class Enemy {
    
    var health:Int
    var node:SKSpriteNode! = nil
    var frames:Double
    var type:String
    var speed:Double
    var hasBullets:Bool = false
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    init(type:String, frames:Double, speed:Double) {

        self.type = type
        self.frames = frames
        self.speed = speed
        switch type {
            
            case "spider_blue":
                self.health = 1
                self.node = spawn()
            case "bee_blue":
                self.health = 1
                self.node = spawn()
            case "squid_blue":
                self.health = 1
                self.node = spawn()
            case "cyclops_blue":
                self.health = 1
                self.node = spawn()
            case "spider_red":
                self.health = 2
                self.node = spawn()
                self.hasBullets = true
            case "bee_red":
                self.health = 2
                self.node = spawn()
                self.hasBullets = true
            case "squid_red":
                self.health = 2
                self.node = spawn()
                self.hasBullets = true
            case "cyclops_red":
                self.health = 2
                self.node = spawn()
                self.hasBullets = true
            default:
                self.health = 1
                self.node = spawn()
        }
    }
    
//    @objc func spawnBullets() {
//        
//        let action:SKAction
//        switch self.type {
//            
//            case "spider_red":
//                action = SKAction.moveToX(-30, duration: 1.0)
//            case "bee_red":
//                action = SKAction.moveToX(-30, duration: 1.0)
//            case "squid_red":
//                action = SKAction.moveToX(-30, duration: 1.0)
//            case"cyclops_red":
//                action = SKAction.moveToX(-30, duration: 1.0)
//            default:
//                action = SKAction.moveToX(-30, duration: 1.0)
//
//        }
//        
//        //creating bullet obj
//        let bullet = SKSpriteNode(imageNamed: "sprites/bullet.png")
//        
//        //give illusion of spawning from ship
//        bullet.zPosition = -5
//        
//        // ???
//        let actionDone = SKAction.removeFromParent()
//        bullet.runAction(SKAction.sequence([action, actionDone]))
//        
//        //assign physics body to parent
//        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
//        
//        //assign bitmask of 1 to categorybitmask so that bullets will register as a 1 in bitmask
//        bullet.physicsBody?.categoryBitMask = physicsCategory.bullet
//        
//        //set the obj that we're going to collide with as a bullet (enemy)
//        bullet.physicsBody?.contactTestBitMask = physicsCategory.player
//        
//        //forget gravity
//        bullet.physicsBody?.affectedByGravity = false
//        
//        //???
//        bullet.physicsBody?.dynamic = false
//
//    }
    
    func spawn() -> SKSpriteNode! {
        
        let enemy1:String = self.type + "1.png"
        let enemy2:String = self.type + "2.png"
        let enemy3:String = self.type + "3.png"
        let enemy4:String = self.type + "4.png"
        
        let enemy = SKSpriteNode(imageNamed: enemy1)
        var actions = Array<SKAction>();
        
        let TextureAtlas = SKTextureAtlas(named: String(self.type))
        
        let animation = SKAction.animateWithTextures([
            
            TextureAtlas.textureNamed(enemy1),
            TextureAtlas.textureNamed(enemy2),
            TextureAtlas.textureNamed(enemy3),
            TextureAtlas.textureNamed(enemy4)
            ], timePerFrame:self.frames)
        
        //create action object to give to bullet. give +30 to height so that bullet goes off screen
        let action = SKAction.moveToX(-70, duration: speed)
        
        // ???
        let actionDone = SKAction.removeFromParent()
        actions.append(SKAction.sequence([action, actionDone]))
        actions.append(SKAction.repeatActionForever(animation))
        
        let group = SKAction.group(actions);
        enemy.runAction(group)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.categoryBitMask = physicsCategory.enemy
        enemy.physicsBody?.contactTestBitMask = physicsCategory.bullet | physicsCategory.player
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.dynamic = true
        
        return enemy
    }
}