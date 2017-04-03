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
        
        let HighscoreDefault = UserDefaults.standard
        if(HighscoreDefault.value(forKey: "Highscore") == nil)
        {
            HighscoreDefault.setValue(self.highscore, forKey: "Highscore")
            HighscoreDefault.synchronize()
        }
        
        let savescoreDefault = UserDefaults.standard
        if(savescoreDefault.value(forKey: "Savescore") != nil)
        {
            score = savescoreDefault.value(forKey: "Savescore") as! NSInteger!
            print ("loaded save score")
        }
        else {
            
            savescoreDefault.setValue(0, forKey: "Savescore")
            savescoreDefault.synchronize()
        }
        highscore = HighscoreDefault.value(forKey: "Highscore") as! NSInteger!
    }
    
    
    func PlayerCollisionWithBullet(_ enemy: SKSpriteNode, bullet: SKSpriteNode) {
        
        enemy.removeFromParent()
        bullet.removeFromParent()
        self.score+=1
        if self.score > self.highscore
        {
            self.highscore = self.score
            let HighscoreDefault = UserDefaults.standard
            HighscoreDefault.setValue(self.highscore, forKey: "Highscore")
            HighscoreDefault.synchronize()
        }
        
        self.scoreLabel.text = "Current Score: \(self.score)"
        self.highscoreLabel.text = "High Score: \(self.highscore)"
    }
    
    func PlayerCollisionWithEnemy(_ player: SKSpriteNode, enemy: SKSpriteNode) {
        
        player.removeFromParent()
    }
    
    func PlayerCollisionWithPowerup(_ player: SKSpriteNode, powerup: SKSpriteNode) {
        
        powerup.removeFromParent()
        
        if powerup.color == UIColor.cyan {
            
            self.player.weapon = 0
        }
        else if(powerup.color == UIColor.red) {
            
            self.player.weapon = 1
        }
        else {
            
            self.player.weapon = 2
        }
        print (powerup.name)
        print (self.player.weapon)
    }
    
    func playBulletSound() {
        
        let defaults = UserDefaults.standard
        let fx = defaults.bool(forKey: "sfx")
        
        if (fx) {
            let laserSound = Bundle.main.url(forResource: "laser", withExtension: "mp3")!
            do {
                audioLaser = try AVAudioPlayer(contentsOf: laserSound)
                guard let audioLaser = audioLaser else { return }
                audioLaser.prepareToPlay()
                audioLaser.play()
            } catch let error as NSError {
                
                print(error.description)
            }
        }
    }
    
    func playMusic() {
        let defaults = UserDefaults.standard
        let music = defaults.bool(forKey: "backgroundMusic")
        if (music == true) {
            let url = Bundle.main.url(forResource: "Night-Winds", withExtension: "mp3")!
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
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
        scoreLabel.backgroundColor = UIColor.black
        scoreLabel.textColor = UIColor.white
        scoreLabel.adjustsFontSizeToFitWidth = true

    }
    
    func makeHighScoreLabel()
    {
        highscoreLabel.text = "Highscore: \(highscore)"
        highscoreLabel = UILabel(frame: CGRect(x: 150, y: 0, width: 100, height: 20))
        highscoreLabel.backgroundColor = UIColor.black
        highscoreLabel.textColor = UIColor.white
        highscoreLabel.adjustsFontSizeToFitWidth = true

    }
    
    func spawnFireButton() -> SKSpriteNode {
        
        let button = SKSpriteNode(imageNamed:"sprites/firebutton.png")
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
