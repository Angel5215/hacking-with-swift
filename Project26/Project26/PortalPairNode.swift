//
//  PortalPairNode.swift
//  Project26
//
//  Created by Angel Vázquez on 12/21/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import SpriteKit

class PortalPairNode: SKNode {
	
	var first: SKSpriteNode!
	var second: SKSpriteNode!
	
	var isPairDisabled = false {
		didSet {
			if isPairDisabled {
				first.texture = SKTexture(imageNamed: "disabledPortal")
				second.texture = SKTexture(imageNamed: "disabledPortal")
				
				first.removeAllActions()
				second.removeAllActions()
				
				first.physicsBody?.contactTestBitMask = 0
				second.physicsBody?.contactTestBitMask = 0
			}
		}
	}
	
	func disable() {
		isPairDisabled = true
	}
	
	func setFirst(at position: CGPoint) {
		first = createPortal(at: position)
		first.name = "first"
		addChild(first)
	}
	
	func setSecond(at position: CGPoint) {
		second = createPortal(at: position)
		second.name = "second"
		addChild(second)
	}
	
	func createPortal(at position: CGPoint) -> SKSpriteNode {
		let node = SKSpriteNode(imageNamed: "portal")
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
		
		let scaleDown = SKAction.scale(to: 0.80, duration: 0.5)
		let reverse = SKAction.scale(to: 1, duration: 0.5)
		let rotate = SKAction.rotate(byAngle: CGFloat.pi / 4, duration: 1)
		let sequence = SKAction.sequence([scaleDown, reverse])
		let group = SKAction.group([sequence, rotate])
		let repeatForever = SKAction.repeatForever(group)
		node.run(repeatForever)
		
		node.physicsBody?.categoryBitMask = CollisionTypes.portal.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		node.position = position
		
		return node
	}
}
