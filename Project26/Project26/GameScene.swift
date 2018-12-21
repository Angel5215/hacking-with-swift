//
//  GameScene.swift
//  Project26
//
//  Created by Angel Vázquez on 12/20/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import SpriteKit
import CoreMotion

enum CollisionTypes: UInt32 {
	case player = 1		//	0b0000...00000001
	case wall = 2		//	0b0000...00000010
	case star = 4		//	0b0000...00000100
	case vortex = 8		//	0b0000...00001000
	case finish = 16	//	0b0000...00010000
	case portal = 32	//	0b0000...00100000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var player: SKSpriteNode!
	var lastTouchPosition: CGPoint?
	
	var motionManager: CMMotionManager!
	
	var scoreLabel: SKLabelNode!
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	var isGameOver = false
	
	var currentLevel = "level1"
	
	var portals: [Character: PortalPairNode] = [:]
	
	override func didMove(to view: SKView) {
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text = "Score: \(score)"
		scoreLabel.horizontalAlignmentMode = .left
		scoreLabel.position = CGPoint(x: 16, y: 16)
		scoreLabel.zPosition = 1
		addChild(scoreLabel)
		
		//	Disables ball movement at start
		physicsWorld.gravity = CGVector(dx: 0, dy: 0)
		
		loadLevel(name: currentLevel)
		createPlayer()
		
		motionManager = CMMotionManager()
		motionManager.startAccelerometerUpdates()
		
		//	Contact Delegate
		physicsWorld.contactDelegate = self
	}
	
	func readLevelFromDisk(levelName: String, ofType type: String = "txt") -> [String]? {
		
		if let levelPath = Bundle.main.path(forResource: levelName, ofType: type) {
			if let levelString = try? String(contentsOfFile: levelPath).trimmingCharacters(in: .whitespacesAndNewlines) {
				return levelString.components(separatedBy: "\n")
			}
		}
		
		return nil
	}
	
	
	func loadLevel(name: String) {
		
		createBackground()
		
		if let currentLevelLines = readLevelFromDisk(levelName: name) {
			for (row, line) in currentLevelLines.reversed().enumerated() {
				for (column, letter) in line.enumerated() {
					let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
					drawNode(with: letter, at: position)
				}
			}
		}
	}
	
	func drawNode(with letter: Character, at position: CGPoint) {
		switch letter {
		case "x":	// Wall
			createWall(at: position)
		case "v":	// Vortex
			createVortex(at: position)
		case "s":	// Star
			createStar(at: position)
		case "f":	// Finish
			createFinish(at: position)
		case "p", "t", "w":	//	Portals
			createPortal(at: position, type: letter)
		default:
			break
		}
	}
	
	func createBackground() {
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
	}
	
	func createWall(at position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "block")
		node.position = position
		
		node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
		node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
		node.physicsBody?.isDynamic = false
		addChild(node)
	}
	
	func createVortex(at position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "vortex")
		node.name = "vortex"
		node.position = position
		node.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi, duration: 1)))
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
		
		node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		addChild(node)
	}
	
	func createStar(at position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "star")
		node.name = "star"
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
		
		node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		node.position = position
		addChild(node)
	}
	
	func createFinish(at position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "finish")
		node.name = "finish"
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
		
		node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		node.position = position
		addChild(node)
	}
	
	func createPortal(at position: CGPoint, type: Character) {		
		if let currentPair = portals[type] {
			currentPair.setSecond(at: position)
		} else {
			print("new \(type)")
			let newPair = PortalPairNode()
			newPair.name = "portal"
			newPair.setFirst(at: position)
			portals[type] = newPair
			addChild(newPair)
		}
	}
	
	func createPlayer() {
		player = SKSpriteNode(imageNamed: "player")
		player.position = CGPoint(x: 96, y: 672)
		player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
		player.physicsBody?.allowsRotation = false
		player.physicsBody?.linearDamping = 0.5
		
		player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
		player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
		player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
		addChild(player)
	}
	
	//	MARK: Methods to test in a simulator
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			lastTouchPosition = location
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			lastTouchPosition = location
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		lastTouchPosition = nil
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		lastTouchPosition = nil
	}
	
	//	MARK: Compiler directives
	override func update(_ currentTime: TimeInterval) {
		
		guard isGameOver == false else { return }
		
		#if targetEnvironment(simulator)
			if let currentTouch = lastTouchPosition {
				let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
				physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
			}
		#else
			if let accelerometerData = motionManager.accelerometerData {
				physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -30, dy: accelerometerData.acceleration.x * 30)
			}
		#endif
	}
	
	//	MARK: Physics Contact Delegate methods
	func didBegin(_ contact: SKPhysicsContact) {
		if contact.bodyA.node == player {
			playerCollided(with: contact.bodyB.node!)
		} else if contact.bodyB.node == player {
			playerCollided(with: contact.bodyA.node!)
		}
	}
	
	func playerCollided(with node: SKNode) {
		if node.name == "vortex" {
			player.physicsBody?.isDynamic = false
			isGameOver = true
			score -= 1
			
			let move = SKAction.move(to: node.position, duration: 0.25)
			let scale = SKAction.scale(to: 0.0001, duration: 0.25)
			let remove = SKAction.removeFromParent()
			let sequence = SKAction.sequence([move, scale, remove])
			player.run(sequence) { [unowned self] in
				self.createPlayer()
				self.isGameOver = false
			}
		} else if node.name == "star" {
			node.removeFromParent()
			score += 1
		} else if node.name == "finish" {
			
			removeAllChildren()
			
			lastTouchPosition = nil
			portals.removeAll()
			currentLevel = "level2"
			
			didMove(to: self.view!)
		} else if node.name == "first" || node.name == "second" {
			
			let pair = node.parent as! PortalPairNode
			pair.disable()
			
			let newPosition = node.name == "first" ? pair.second.position : pair.first.position
			let move = SKAction.move(to: node.position, duration: 0.25)
			let scale = SKAction.scale(to: 0.0001, duration: 0.25)
			let move2 = SKAction.move(to: newPosition, duration: 0)
			let scale2 = SKAction.scale(to: 1, duration: 0.25)
			
			let sequence = SKAction.sequence([move, scale, move2, scale2])
			player.run(sequence)
		}
	}
	
}
