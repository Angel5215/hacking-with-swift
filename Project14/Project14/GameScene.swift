//
//  GameScene.swift
//  Project14
//
//  Created by Angel Vázquez on 9/29/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	
	var slots = [WhackSlot]()
	
	var gameScore: SKLabelNode!
	
	var popupTime = 0.85
	
	var numRounds = 0
	
	var score = 0 {
		didSet {
			gameScore.text = "Score: \(score)"
		}
	}

    override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "whackBackground")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
		
		gameScore = SKLabelNode(fontNamed: "Chalkduster")
		gameScore.text = "Score: 0"
		gameScore.position = CGPoint(x: 8, y: 8)
		gameScore.horizontalAlignmentMode = .left
		gameScore.fontSize = 48
		addChild(gameScore)
		
		for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + i * 170, y: 410)) }
		for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + i * 170, y: 320)) }
		for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + i * 170, y: 230)) }
		for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + i * 170, y: 140)) }
		
		//	Execute a closure after a time has been reached
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
			self.createEnemy()
		}
		
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			let tappedNodes = nodes(at: location)
			
			
			
			for node in tappedNodes {
			
				print(node.name == "charFriend", node.name == "charEnemy")

				if node.name == "charFriend" {
					let whackSlot = node.parent!.parent! as! WhackSlot
					if !whackSlot.isVisible { continue }
					if whackSlot.isHit { continue }
					
					print("Tapped a good penguin")
					
					whackSlot.hit()
					score -= 5
					
					run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
					
				} else if node.name == "charEnemy" {
					let whackSlot = node.parent!.parent! as! WhackSlot
					if !whackSlot.isVisible { continue }
					if whackSlot.isHit { continue }
					
					print("Score!")
					
					whackSlot.charNode.xScale = 0.85
					whackSlot.charNode.yScale = 0.85
					
					whackSlot.hit()
					score += 1
					
					run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
				}
			}
		}
    }
	
	func createSlot(at position: CGPoint) {
		let slot = WhackSlot()
		slot.configure(at: position)
		addChild(slot)
		slots.append(slot)
	}
	
	func createEnemy() {
		
		numRounds += 1
		
		if numRounds >= 30 {
			for slot in slots {
				slot.hide()
			}
			
			let gameOver = SKSpriteNode(imageNamed: "gameOver")
			gameOver.position = CGPoint(x: 512, y: 384)
			gameOver.zPosition = 1
			addChild(gameOver)
			
			return
		}
		
		popupTime *= 0.991
		
		slots = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: slots) as! [WhackSlot]
		slots[0].show(hideTime: popupTime)
		
		if RandomInt(min: 0, max: 12) > 4 {
			slots[1].show(hideTime: popupTime)
		}
		if RandomInt(min: 0, max: 12) > 8 {
			slots[2].show(hideTime: popupTime)
		}
		if RandomInt(min: 0, max: 12) > 10 {
			slots[3].show(hideTime: popupTime)
		}
		if RandomInt(min: 0, max: 12) > 11 {
			slots[4].show(hideTime: popupTime)
		}
		
		let minDelay = popupTime / 2.0
		let maxDelay = popupTime * 2
		
		let delay = RandomDouble(min: minDelay, max: maxDelay)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
			self.createEnemy()
		}
	}
	
	
}
