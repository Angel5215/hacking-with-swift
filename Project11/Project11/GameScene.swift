//
//  GameScene.swift
//  Project11
//
//  Created by Angel Vázquez on 9/22/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var scoreLabel: SKLabelNode!
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	var usedBallsLabel: SKLabelNode!
	var maxBalls = 5
	
	var usedBalls = 0 {
		didSet {
			usedBallsLabel.text = "Remaining balls: \(maxBalls - usedBalls)"
		}
	}
	
	var editLabel: SKLabelNode!
	
	var editingMode: Bool = false {
		didSet {
			editLabel.text = editingMode ? "Done" : "Edit"
		}
	}
	
	override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
		
		//	Adds physics to the scene.
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		
		//	Every scene has a physics world to simulate physics.
		physicsWorld.contactDelegate = self
		
		makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
		makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
		makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
		makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
		
		
		//	Evenly distributed bouncers.
		for i in 0 ..< 5 {
			makeBouncer(at: CGPoint(x: 256 * i, y: 0))
		}
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text = "Score: 0"
		scoreLabel.horizontalAlignmentMode = .right
		scoreLabel.position = CGPoint(x: 980, y: 700)
		addChild(scoreLabel)
		
		usedBallsLabel = SKLabelNode(fontNamed: "Chalkduster")
		usedBallsLabel.text = "Remaining balls: 5"
		usedBallsLabel.horizontalAlignmentMode = .center
		usedBallsLabel.position = CGPoint(x: 512, y: 700)
		addChild(usedBallsLabel)
		
		editLabel = SKLabelNode(fontNamed: "Chalkduster")
		editLabel.text = "Edit"
		editLabel.position = CGPoint(x: 80, y: 700)
		addChild(editLabel)
		
		configureBoxes(min: 40, max: 50)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			
			//	Edition mode
			let objects = nodes(at: location)
			
			if objects.contains(editLabel) {
				editingMode = !editingMode
			} else {
				//	Enhancement 1. Make balls of different colors.
				if editingMode {
					
					if let box = objects.first(where: { $0.name == "box" }) {
						destroy(box: box)
					} else {
						makeBox(in: location)
					}
					
				} else {
					//	Enhancement 2. Make balls appear only near the top of the screen.
					if location.y >= 530 && usedBalls < maxBalls {
						makeBall(in: location)
						usedBalls += 1
					}
				}
			}
			
			//	Creates a box of 64x64 points and gives them physics.
			/* let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
			box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
			box.position = location
			addChild(box)*/
		}
	}
	
	func makeBox(in location: CGPoint) {
		let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(), height: 16)
		let box = SKSpriteNode(color: RandomColor(), size: size)
		box.zRotation = RandomCGFloat(min: 0, max: 3)
		box.position = location
		
		box.name = "box"
		
		box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
		box.physicsBody?.isDynamic = false
		addChild(box)
	}
	
	func makeBall(in location: CGPoint) {

		let ballColors = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
		let randomIndex = RandomInt(min: 0, max: ballColors.count - 1)
		
		let ball = SKSpriteNode(imageNamed: ballColors[randomIndex])
		
		ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
		
		//	Contact test bitmask
		ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
		
		//	Bounciness. Values vary from 0 to 1.0
		ball.physicsBody?.restitution = 0.4
		ball.position = location
		
		ball.name = "ball"
		
		addChild(ball)
	}
	
	func makeBouncer(at position: CGPoint) {
		let bouncer = SKSpriteNode(imageNamed: "bouncer")
		bouncer.position = position
		bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
		bouncer.physicsBody?.isDynamic = false
		addChild(bouncer)
	}
	
	func makeSlot(at position: CGPoint, isGood: Bool) {
		var slotBase: SKSpriteNode
		var slotGlow: SKSpriteNode
		
		if isGood {
			slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
			slotBase.name = "good"
		} else {
			slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
			slotBase.name = "bad"
		}
		
		slotBase.position = position
		slotGlow.position = position
		
		slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
		slotBase.physicsBody?.isDynamic = false
		
		addChild(slotBase)
		addChild(slotGlow)
		
		//	SKAction to animate the glows:
		let spin = SKAction.rotate(byAngle: .pi, duration: 10)
		let spinForever = SKAction.repeatForever(spin)
		slotGlow.run(spinForever)
	}
	
	func collisionBetween(ball: SKNode, object: SKNode) {
		if object.name == "good" {
			destroy(ball: ball)
			score += 1
			
			//	Gives the player an extra ball.
			usedBalls -= 1
			
		} else if object.name == "bad" {
			destroy(ball: ball)
			score -= 1
			
			//	Add random boxes whenever you get a bad score (from 1 to 5):
			configureBoxes(min: 1, max: 5)
		}
	}
	
	func destroy(ball: SKNode) {
		
		if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
			fireParticles.position = ball.position
			addChild(fireParticles)
		}
		
		ball.removeFromParent()
	}
	
	func destroy(box: SKNode) {
		
		let fading = SKAction.fadeOut(withDuration: 0.3)
		box.run(fading)
		
		box.removeFromParent()
	}
	
	//	Called when two bodies make contact into each other.
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA.name == "ball" && nodeB.name != "box" {
			collisionBetween(ball: nodeA, object: nodeB)
		} else if nodeB.name == "ball" && nodeA.name != "box" {
			collisionBetween(ball: nodeB, object: nodeA)
		} else if nodeA.name == "ball" && nodeB.name == "box"{
			destroy(box: nodeB)
		} else if nodeB.name == "ball" && nodeA.name == "box"{
			destroy(box: nodeA)
		}
	}
	
	func configureBoxes(min: Int, max: Int) {
		let numberOfBoxes = RandomInt(min: min, max: max)
		
		for _ in 0 ..< numberOfBoxes {
			let position = RandomPosition(minX: 0, maxX: 1024, minY: 45, maxY: 650)
			makeBox(in: position)
		}
	}
}
