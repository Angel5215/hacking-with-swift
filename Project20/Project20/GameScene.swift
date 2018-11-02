//
//  GameScene.swift
//  Project20
//
//  Created by Angel Vázquez on 11/1/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	
	var gameTimer: Timer!
	var fireworks = [SKNode]()
	
	let leftEdge = -22
	let bottomEdge = -22
	let rightEdge = 1024 + 22
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	var scoreLabel: SKLabelNode!
	
	//	MARK: Touch handling methods.
	
    override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.position = CGPoint(x: 900, y: 720)
		scoreLabel.text = "Score: 0"
		scoreLabel.fontSize = 40
		addChild(scoreLabel)
		
		gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		checkTouches(touches)
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesMoved(touches, with: event)
		checkTouches(touches)
	}
	
	func checkTouches(_ touches: Set<UITouch>) {
		guard let touch = touches.first else { return }
		
		let location = touch.location(in: self)
		let nodesAtPoint = nodes(at: location)
		
		for node in nodesAtPoint {
			if node is SKSpriteNode {
				let sprite = node as! SKSpriteNode
				if sprite.name == "firework" {
					
					for parent in fireworks {
						let firework = parent.children[0] as! SKSpriteNode
						if firework.name == "selected" && firework.color != sprite.color {
							firework.name = "firework"
							firework.colorBlendFactor = 1
						}
					}
					
					sprite.name = "selected"
					sprite.colorBlendFactor = 0
				}
			}
		}
	}
	
	//	MARK: Game state
	override func update(_ currentTime: TimeInterval) {
		for (index, firework) in fireworks.enumerated().reversed() {
			if firework.position.y > 900 {
				//	This uses a position high above so that rockets can explode off screen.
				fireworks.remove(at: index)
				firework.removeFromParent()
			}
		}
	}
	
	//	MARK: Methods
	@objc func launchFireworks() {
		let movementAmount: CGFloat = 1800
		
		switch GKRandomSource.sharedRandom().nextInt(upperBound: 4) {
		case 0:
			//	Fire five, straight up.
			createFirework(xMovement: 0, x: 512, y: bottomEdge)
			createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
			createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
			createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
			createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
		case 1:
			//	Fire five, in a fan.
			createFirework(xMovement: 0, x: 512, y: bottomEdge)
			createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
			createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
			createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
			createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)
		case 2:
			//	Fire five, from the left to the right
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
		case 3:
			//	Fire five, from the right to the left.
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
		default:
			break
		}
	}
	
	func createFirework(xMovement: CGFloat, x: Int, y: Int) {
		
		//	Container for the firework.
		let node = SKNode()
		node.position = CGPoint(x: x, y: y)
		
		//	Create a rocket sprite, adjust its colorBlendFactor property so that we can color it.
		let firework = SKSpriteNode(imageNamed: "rocket")
		firework.colorBlendFactor = 1
		firework.name = "firework"
		node.addChild(firework)
		
		//	Assign a random color to the sprite node.
		switch GKRandomSource.sharedRandom().nextInt(upperBound: 3) {
		case 0:
			firework.color = .cyan
		case 1:
			firework.color = .green
		case 2:
			firework.color = .red
		default:
			break
		}
		
		//	A UIBezierPath will represent the movement of the firework.
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: xMovement, y: 1000))
		
		//	Tell the container to follow the path.
		let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
		node.run(move)
		
		//	Create particles behind the rocket.
		let emitter = SKEmitterNode(fileNamed: "fuse")!
		emitter.position = CGPoint(x: 0, y: -22)
		node.addChild(emitter)
		
		//	Add the firework to the fireworks array.
		fireworks.append(node)
		addChild(node)
	}
	
	func explode(firework: SKNode) {
		let emitter = SKEmitterNode(fileNamed: "explode")!
		emitter.position = firework.position
		addChild(emitter)
		
		firework.removeFromParent()
	}
	
	func explodeFireworks() {
		var numExploded = 0
		
		for (index, fireworkContainer) in fireworks.enumerated().reversed() {
			let firework = fireworkContainer.children[0] as! SKSpriteNode
			
			if firework.name == "selected" {
				explode(firework: fireworkContainer)
				fireworks.remove(at: index)
				numExploded += 1
			}
		}
		
		switch numExploded {
		case 0:
			break
		case 1:
			score += 200
		case 2:
			score += 500
		case 3:
			score += 1500
		case 4:
			score += 2500
		default:
			score += 4000
		}
	}
}
