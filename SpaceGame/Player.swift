//
//  Player.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 11/5/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    
    var node:SKSpriteNode! = nil
    var health:Int
    var weapon:Int = 0
    
    init() {
        
        self.health = 1
        self.node = spawn()
    }
    
    func spawnBullet(action:SKAction, isBig:Bool) -> SKSpriteNode {
        
        let bullet:SKSpriteNode
        
        //creating bullet obj
        if (isBig) {
            
            bullet = SKSpriteNode(imageNamed: "sprites/bigbullet.png")
        }
        else {
            
            bullet = SKSpriteNode(imageNamed: "sprites/bullet.png")
        }
        
        //give illusion of spawning from ship
        bullet.zPosition = -5
        
        // ???
        let actionDone = SKAction.removeFromParent()
        bullet.runAction(SKAction.sequence([action, actionDone]))
        
        //assign physics body to parent
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        
        //assign bitmask2 of 1 to categorybitmask so that bullets will register as a 1 in bitmask
        bullet.physicsBody?.categoryBitMask = physicsCategory.bullet
        
        //set the obj that we're going to collide with as a bullet (enemy)
        bullet.physicsBody?.contactTestBitMask = physicsCategory.enemy
        
        //forget gravity
        bullet.physicsBody?.affectedByGravity = false
        
        //???
        bullet.physicsBody?.dynamic = false
        
        
        return bullet
    }
    
    func spawn() -> SKSpriteNode {
        let player = SKSpriteNode(imageNamed: "sprites/player.png")
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = physicsCategory.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = physicsCategory.powerup
        player.physicsBody?.dynamic = false
        return player
    }
}