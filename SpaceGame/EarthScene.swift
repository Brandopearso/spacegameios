//
//  GameScene.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 9/12/16.
//  Copyright (c) 2016 Brandon  Pearson . All rights reserved.
//

import SpriteKit
import AVFoundation

class EarthScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode(imageNamed: "sprites/player.png")
    var score: Int = 0
    var scoreLabel = UILabel()
    var button: SKNode! = nil

    var background = SKSpriteNode(imageNamed: "space_no_planets.png")
    var audioPlayer: AVAudioPlayer?
    var audioLaser: AVAudioPlayer?
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        player.position = CGPointMake((self.size.width / 5), (self.size.height / 2))
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = physicsCategory.player
        player.physicsBody?.contactTestBitMask = physicsCategory.enemy
        player.physicsBody?.dynamic = false
        
        // Create a simple red rectangle that's 100x44
        button = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 200, height: 100))
        // Put it in the center of the scene
        button.position = CGPoint(x:self.size.width - 100, y:200);
        
        self.addChild(button)
        
        
        //set timer to bullet once it reaches view
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(GameScene.spawnBullets), userInfo: nil, repeats: true)
        
        //set timer to enemy once it reaches view
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameScene.spawnEnemy), userInfo: nil, repeats: true)
        
        //add player to the view
        self.addChild(player)
        
        scoreLabel.text = "\(score)"
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        scoreLabel.backgroundColor = UIColor.blackColor()
        scoreLabel.textColor = UIColor.whiteColor()
        background.zPosition = -100
        background.size = self.frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        self.view?.addSubview(scoreLabel)
        // Start music
        let defaults = NSUserDefaults.standardUserDefaults()
        let music = defaults.boolForKey("backgroundMusic")
        if (music == true) {
            playSound()
        }
    }
    func playSound() {
        let url = NSBundle.mainBundle().URLForResource("Night-Winds", withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            guard let audioPlayer = audioPlayer else { return }
            
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
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
        
        let enemy = SKSpriteNode(imageNamed: "squid_11.png")
        var actions = Array<SKAction>();
        let minValue = self.size.height / 6
        let maxValue = self.size.height
        
        //UInt32 for precision
        let spawnPoint = UInt32(maxValue - minValue)
        enemy.position = CGPoint(x: self.size.width, y: CGFloat(arc4random_uniform(spawnPoint)))
        
        let TextureAtlas = SKTextureAtlas(named: "squid1")
        
        let animation = SKAction.animateWithTextures([
            
            TextureAtlas.textureNamed("squid_11.png"),
            TextureAtlas.textureNamed("squid_22.png"),
            TextureAtlas.textureNamed("squid_33.png"),
            TextureAtlas.textureNamed("squid_44.png")
            ], timePerFrame:0.25)
        
        //create action object to give to bullet. give +30 to height so that bullet goes off screen
        let action = SKAction.moveToX(-70, duration: 3.0)
        
        // ???
        let actionDone = SKAction.removeFromParent()
        actions.append(SKAction.sequence([action, actionDone]))
        actions.append(SKAction.repeatActionForever(animation))
        
        let group = SKAction.group(actions);
        enemy.runAction(group)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.categoryBitMask = physicsCategory.enemy
        enemy.physicsBody?.contactTestBitMask = physicsCategory.bullet
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.dynamic = true
        
        
        self.addChild(enemy)
    }
    
    func spawnBullets() {
        
        //creating bullet obj
        let bullet = SKSpriteNode(imageNamed: "sprites/bullet.png")
        
        //give illusion of spawning from ship
        bullet.zPosition = -5
        
        //give ship a spawn point on the map
        bullet.position = CGPointMake(player.position.x, player.position.y)
        
        //create action object to give to bullet. give +30 to height so that bullet goes off screen
        let action = SKAction.moveToX(self.size.width + 30, duration: 1.0)
        
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
        let defaults = NSUserDefaults.standardUserDefaults()
        let fx = defaults.boolForKey("sfx")
        
        if (fx) {
        let laserSound = NSBundle.mainBundle().URLForResource("laser", withExtension: "mp3")!
        do {
            self.audioLaser = try AVAudioPlayer(contentsOfURL: laserSound)
            guard let audioLaser = audioLaser else { return }
            audioLaser.prepareToPlay()
            audioLaser.play()
        } catch let error as NSError {
            
            print(error.description)
        }
        }

        //add bullet to the scene
        self.addChild(bullet)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Check if the location of the touch is within the button's bounds
            if button.containsPoint(location) {
                spawnBullets()
            }
            else {
                
                player.position.x = location.x + 130
                player.position.y = location.y
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x + 130
            player.position.y = location.y
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
