//
//  GameScene.swift
//  movementsnippet
//
//  Created by Mateusz Chojnacki on 21.12.2017.
//  Copyright © 2017 Mateusz Chojnacki. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var player:SKSpriteNode?
    var movingMode = false
    let moveSound = SKAction.playSoundFileNamed("Sounds/move.wav", waitForCompletion: false)
    func createPlayer(){
        player = SKSpriteNode(imageNamed: "player")
        player?.position =  CGPoint(x:self.frame.width / 2,y : self.frame.height / 2)
        self.addChild(player!)
    }
    
    func moveVertically(up: Bool){
        if up{
            let moveAction = SKAction.moveBy(x: 0, y:  3, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        }else{
            let moveAction = SKAction.moveBy(x: 0, y:  -3, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        }
    }
    
    func moveHoryzontalny(side:Bool){
        player?.removeAllActions()
        movingMode = true
        
        if let player = self.player{
            let verdicalSide:CGPoint?
            if side{ //right
                verdicalSide = CGPoint(x:player.position.x + 40 , y:player.position.y)
            }else{ // left
                verdicalSide = CGPoint(x:player.position.x - 40 , y:player.position.y)
            }
            let moveAction = SKAction.move(to: verdicalSide!, duration: 0.4)
            
            player.run(moveAction, completion: {
                self.movingMode = false
            })
            
            self.run(moveSound)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let tauch = touches.first{
            let location = tauch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            if node?.name == "right"{
                moveHoryzontalny(side: true)
            }else if node?.name == "left"{
                moveHoryzontalny(side: false)
            }else if node?.name == "up"{
                print("move Up")
                moveVertically(up: true)
                
            } else if node?.name == "down"{
                print("move Down")
                moveVertically(up: false)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingMode{
            player?.removeAllActions()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }
    
    
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        createPlayer()
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
