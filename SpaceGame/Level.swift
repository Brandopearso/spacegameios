//
//  Level.swift
//  SpaceGame
//
//  Created by Brandon  Pearson  on 11/5/16.
//  Copyright © 2016 Brandon  Pearson . All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Level {
    
    var player:Player = Player()
    var score: Int = 0
    var highscore: Int = 0
    var scoreLabel = UILabel()
    var highscoreLabel = UILabel()
    var button: SKNode! = nil
    var pauseButton: SKNode! = nil
    var saveButton: SKNode! = nil
    var audioPlayer: AVAudioPlayer?
    var audioLaser: AVAudioPlayer?
    var background = SKSpriteNode(imageNamed: "space_no_planets.png")
    var enemylist = [Enemy]()
    var width:CGFloat = 0
    var height:CGFloat = 0

    init() {
        self.button = spawnFireButton()
        makeBackground()
        makeScoreLabel()
        makeHighScoreLabel()
        playMusic()
        self.pauseButton = spawnPauseButton()
        self.saveButton = spawnSaveButton()
        
        let HighscoreDefault = NSUserDefaults.standardUserDefaults()
        if(HighscoreDefault.valueForKey("Highscore") == nil)
        {
            HighscoreDefault.setValue(self.highscore, forKey: "Highscore")
            HighscoreDefault.synchronize()
        }
        
        let savescoreDefault = NSUserDefaults.standardUserDefaults()
        if(savescoreDefault.valueForKey("Savescore") != nil)
        {
            score = savescoreDefault.valueForKey("Savescore") as! NSInteger!
            print ("loaded save score")
        }
        else {
            
            savescoreDefault.setValue(0, forKey: "Savescore")
            savescoreDefault.synchronize()
        }
        highscore = HighscoreDefault.valueForKey("Highscore") as! NSInteger!
    }
    
    
    func PlayerCollisionWithBullet(enemy: SKSpriteNode, bullet: SKSpriteNode) {
        
        enemy.removeFromParent()
        bullet.removeFromParent()
        self.score+=1
        if self.score > self.highscore
        {
            self.highscore = self.score
            let HighscoreDefault = NSUserDefaults.standardUserDefaults()
            HighscoreDefault.setValue(self.highscore, forKey: "Highscore")
            HighscoreDefault.synchronize()
        }
        
        self.scoreLabel.text = "Current Score: \(self.score)"
        self.highscoreLabel.text = "High Score: \(self.highscore)"
    }
    
    func PlayerCollisionWithEnemy(player: SKSpriteNode, enemy: SKSpriteNode) {
        
        player.removeFromParent()
    }
    
    func PlayerCollisionWithPowerup(player: SKSpriteNode, powerup: SKSpriteNode) {
        
        powerup.removeFromParent()
        
        if powerup.color == UIColor.cyanColor() {
            
            self.player.weapon = 0
        }
        else if(powerup.color == UIColor.redColor()) {
            
            self.player.weapon = 1
        }
        else {
            
            self.player.weapon = 2
        }
        print (powerup.name)
        print (self.player.weapon)
    }
    
    func playBulletSound() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fx = defaults.boolForKey("sfx")
        
        if (fx) {
            let laserSound = NSBundle.mainBundle().URLForResource("laser", withExtension: "mp3")!
            do {
                audioLaser = try AVAudioPlayer(contentsOfURL: laserSound)
                guard let audioLaser = audioLaser else { return }
                audioLaser.prepareToPlay()
                audioLaser.play()
            } catch let error as NSError {
                
                print(error.description)
            }
        }
    }
    
    func playMusic() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let music = defaults.boolForKey("backgroundMusic")
        if (music == true) {
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
    }
    
    func makeBackground() {
        
        background.zPosition = -100
    }
    
    func makeScoreLabel()
    {
        scoreLabel.text = "Current Score: \(score)"
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        scoreLabel.backgroundColor = UIColor.blackColor()
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.adjustsFontSizeToFitWidth = true

    }
    
    func makeHighScoreLabel()
    {
        highscoreLabel.text = "Highscore: \(highscore)"
        highscoreLabel = UILabel(frame: CGRect(x: 150, y: 0, width: 100, height: 20))
        highscoreLabel.backgroundColor = UIColor.blackColor()
        highscoreLabel.textColor = UIColor.whiteColor()
        highscoreLabel.adjustsFontSizeToFitWidth = true

    }
    
    func spawnFireButton() -> SKSpriteNode {
        
        let button = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 200, height: 100))
        return button
    }
    
    func spawnPauseButton() -> SKSpriteNode {
        
        let button = SKSpriteNode(imageNamed:"sprites/pausebutton.png")
        return button
    }
    
    func spawnSaveButton() -> SKSpriteNode {
        
        let button = SKSpriteNode(imageNamed:"sprites/savebutton.png")
        return button
    }
}