//
//  GameScene.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 9/12/16.
//  Copyright (c) 2016 Brandon  Pearson . All rights reserved.
//

import SpriteKit

struct physicsCategory {
    
    static let enemy: UInt32 = 1
    static let bullet: UInt32 = 2
    static let player: UInt32 = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode(imageNamed: "player.png")
    var score: Int = 0
    var scoreLabel = UILabel()
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
    
        player.position = CGPointMake((self.size.width / 2), (self.size.height / 5))
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = physicsCategory.player
        player.physicsBody?.contactTestBitMask = physicsCategory.enemy
        player.physicsBody?.dynamic = false
        
        
        //set timer to bullet once it reaches view
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameScene.spawnBullets), userInfo: nil, repeats: true)
        
        //set timer to enemy once it reaches view
        var enemyTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameScene.spawnEnemy), userInfo: nil, repeats: true)
        
        //add player to the view
        self.addChild(player)
        
        scoreLabel.text = "\(score)"
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        scoreLabel.backgroundColor = UIColor.blackColor()
        scoreLabel.textColor = UIColor.whiteColor()
        
        self.view?.addSubview(scoreLabel)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        
        if (((firstBody.categoryBitMask == physicsCategory.enemy) && (secondBody.categoryBitMask == physicsCategory.bullet)) ||
            ((firstBody.categoryBitMask == physicsCategory.bullet) && (secondBody.categoryBitMask == physicsCategory.enemy))){
            
            collisionWithBullet(firstBody.node as! SKSpriteNode, bullet: secondBody.node as! SKSpriteNode)
            
        }
        
    }
    
    func collisionWithBullet(enemy: SKSpriteNode, bullet: SKSpriteNode) {
        
        enemy.removeFromParent()
        bullet.removeFromParent()
        score+=1
        
        scoreLabel.text = "\(score)"
    }
    
    func spawnEnemy() {
        
        let enemy = SKSpriteNode(imageNamed: "enemy.png")
        let minValue = self.size.width / 8
        let maxValue = self.size.width - 20
        
        //UInt32 for precision
        let spawnPoint = UInt32(maxValue - minValue)
        enemy.position = CGPoint(x: CGFloat(arc4random_uniform(spawnPoint)), y: self.size.height)
        
        //create action object to give to bullet. give +30 to height so that bullet goes off screen
        let action = SKAction.moveToY(-70, duration: 3.0)
        
        // ???
        let actionDone = SKAction.removeFromParent()
        enemy.runAction(SKAction.sequence([action, actionDone]))
        
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.categoryBitMask = physicsCategory.enemy
        enemy.physicsBody?.contactTestBitMask = physicsCategory.bullet
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.dynamic = true
        
        
        self.addChild(enemy)
        
    }
    
    func spawnBullets() {
        
        //creating bullet obj
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        
        //give illusion of spawning from ship
        bullet.zPosition = -5
        
        //give ship a spawn point on the map
        bullet.position = CGPointMake(player.position.x, player.position.y)
        
        //create action object to give to bullet. give +30 to height so that bullet goes off screen
        let action = SKAction.moveToY(self.size.height + 30, duration: 0.6)
        
        // ???
        let actionDone = SKAction.removeFromParent()
        bullet.runAction(SKAction.sequence([action, actionDone]))
        
        //assign physics body to parent
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        
        //assign bitmask of 1 to categorybitmask so that bullets will register as a 1 in bitmask
        bullet.physicsBody?.categoryBitMask = physicsCategory.bullet
        
        //set the obj that we're going to collide with as a bullet (enemy)
        bullet.physicsBody?.contactTestBitMask = physicsCategory.enemy
        
        //forget gravity
        bullet.physicsBody?.affectedByGravity = false
        
        //???
        bullet.physicsBody?.dynamic = false
        
        //add bullet to the scene
        self.addChild(bullet)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
