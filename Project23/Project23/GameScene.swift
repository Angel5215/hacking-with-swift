//
//  GameScene.swift
//  Project23
//
//  Created by Angel Vázquez on 12/16/18.
//  Copyright © 2018 PROTECO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //  MARK: Initial Configuration
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //  MARK: Adding Enemies
    var possibleEnemies = ["hammer", "ball", "tv"]
    var gameTimer: Timer!
    var isGameOver = false
	
	//	Lasers
	let LASER_PLAYER_OFFSET: CGFloat = 5
    
    //  MARK: Initial methods
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "Starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
		player.name = "player"
        player.position = CGPoint(x: 100, y: 384)
        //  Adds per-pixel collision detection.
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        //  Disables gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
    }

    @objc func createEnemy() {
        
        possibleEnemies.shuffle()
        
        let sprite = SKSpriteNode(imageNamed: possibleEnemies[0])
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50 ... 736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: Int.random(in: -3000 ... -500), dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
		sprite.name = "debris"
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
			} else if node.position.x > 1300 {
				node.removeFromParent()
			}
        }
        
        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
		
		let xDifference = abs(player.position.x - location.x)
		let yDifference = abs(player.position.y - location.y)
		
		if xDifference <= 30 && yDifference <= 30 {
			player.position = location
		}
		
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
		
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA.name == "player" && nodeB.name == "debris" {
			gameOver()
			print(1)
		} else if nodeA.name == "debris" && nodeB.name == "player" {
			gameOver()
			print(2)
		} else if nodeA.name == "laser" && nodeB.name == "debris" {
			destroy(debrisNode: nodeB, by: nodeA)
		} else if nodeA.name == "debris" && nodeB.name == "laser" {
			destroy(debrisNode: nodeA, by: nodeB)
		}
		
    }
	
	func destroy(debrisNode: SKNode, by laserNode: SKNode) {
		let explosion = SKEmitterNode(fileNamed: "debrisExplosion")!
		explosion.position = debrisNode.position
		addChild(explosion)
		
		laserNode.removeFromParent()
		debrisNode.removeFromParent()
	}
	
	func gameOver() {
		let explosion = SKEmitterNode(fileNamed: "explosion")!
		explosion.position = player.position
		addChild(explosion)
		
		player.removeFromParent()
		gameTimer.invalidate()
		
		isGameOver = true
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		if isGameOver { return }
		
		let x = player.position.x + player.size.width / 2.0 + LASER_PLAYER_OFFSET
		let y = player.position.y
		let position = CGPoint(x: x, y: y)
		
		let laser = SKSpriteNode(imageNamed: "laser")
		laser.name = "laser"
		laser.position = position
		laser.physicsBody = SKPhysicsBody(rectangleOf: laser.size)
		laser.physicsBody?.velocity = CGVector(dx: 600, dy: 0)
		laser.physicsBody?.linearDamping = 0
		laser.physicsBody?.contactTestBitMask = 0x10
		
		addChild(laser)
	}
}
