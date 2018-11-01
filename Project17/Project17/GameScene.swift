//
//  GameScene.swift
//  Project17
//
//  Created by Angel Vázquez on 10/30/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum SequenceType: Int {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain
}

enum ForceBomb {
    case never, always, random
}

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var livesImages = [SKSpriteNode]()
    var lives = 3
    
    //  Slices
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    
    var activeSlicePoints = [CGPoint]()
    
    //  Sound
    var isSwooshSoundActive = false
    
    //  Enemies
    var activeEnemies = [SKSpriteNode]()
    
    //  Bombs
    var bombSoundEffect: AVAudioPlayer!
    
    //  Randomize enemies
    var popupTime = 0.9
    var sequence: [SequenceType]!
    var sequencePosition = 0
    var chainDelay = 3.0
    var nextSequenceQueued = true
    
    var gameEnded = false
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
        
        createScore()
        createLives()
        createSlices()
        
        //  Create enemies in various ways.
        sequence = [.oneNoBomb, .oneNoBomb, .twoWithOneBomb, .twoWithOneBomb, .three, .one, .chain]
        
        for _ in 0 ... 1000 {
            let nextSequence = SequenceType(rawValue: RandomInt(min: 2, max: 7))!
            sequence.append(nextSequence)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.tossEnemies()
        }
    }
    
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //  Removes existing points in slices array.
        activeSlicePoints.removeAll(keepingCapacity: true)
        
        //  Get touch location, add it to the slices array.
        if let touch = touches.first {
            let location = touch.location(in: self)
            activeSlicePoints.append(location)
            
            //  Clear slice shapes.
            redrawActiveSlice()
            
            //  Remove actions attached to the shapes. Important if they are in the middle of a fadeOut()
            activeSliceBG.removeAllActions()
            activeSliceFG.removeAllActions()
            
            activeSliceBG.alpha = 1
            activeSliceFG.alpha = 1
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameEnded {
            return
        }
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        
        activeSlicePoints.append(location)
        redrawActiveSlice()
        
        //  Check sound
        if !isSwooshSoundActive {
            playSwooshSound()
        }
        
        let nodesAtPoint = nodes(at: location)
        
        for node in nodesAtPoint {
            if node.name == "enemy" {
                //  Destroy penguin
                let emitter = SKEmitterNode(fileNamed: "sliceHitEnemy")!
                emitter.position = node.position
                addChild(emitter)
                
                node.name = ""
                
                node.physicsBody?.isDynamic = false
                
                let scaleOut = SKAction.scale(to: 0.001, duration: 0.2)
                let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                let group = SKAction.group([scaleOut, fadeOut])
                
                let seq = SKAction.sequence([group, SKAction.removeFromParent()])
                node.run(seq)
                
                score += 1
                
                let index = activeEnemies.index(of: node as! SKSpriteNode)!
                activeEnemies.remove(at: index)
                
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            } else  if node.name == "bomb" {
                //  Destroy bomb
                let emitter = SKEmitterNode(fileNamed: "sliceHitBomb")!
                emitter.position = node.parent!.position
                addChild(emitter)
                
                node.name = ""
                
                node.parent?.physicsBody?.isDynamic = false
                
                let scaleOut = SKAction.scale(to: 0.001, duration: 0.2)
                let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                let group = SKAction.group([scaleOut, fadeOut])
                
                let seq = SKAction.sequence([group, SKAction.removeFromParent()])
                
                node.parent?.run(seq)
                
                let index = activeEnemies.index(of: node.parent as! SKSpriteNode)!
                activeEnemies.remove(at: index)
                
                run(SKAction.playSoundFileNamed("explosion.caf", waitForCompletion: false))
                endGame(triggeredByBomb: true)
            }
        }
    }
    
    //  The user stops touching the screen.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }
    
    //  The touches are interrupted by a system call.
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if activeEnemies.count > 0 {
            for node in activeEnemies {
                if node.position.y < -140 {
                    node.removeAllActions()
                    
                    if node.name == "enemy" {
                        node.name = ""
                        subtractLife()
                        
                        node.removeFromParent()
                        
                        if let index = activeEnemies.index(of: node) {
                            activeEnemies.remove(at: index)
                        }
                    } else if node.name == "bombContainer" {
                        node.name = ""
                        node.removeFromParent()
                        
                        if let index = activeEnemies.index(of: node) {
                            activeEnemies.remove(at: index)
                        }
                    }
                    
                    
                }
            }
        } else {
            if !nextSequenceQueued {
                DispatchQueue.main.asyncAfter(deadline: .now() + popupTime) { [unowned self] in
                    self.tossEnemies()
                }
                nextSequenceQueued = true
            }
        }
        
        var bombCount = 0
        
        for node in activeEnemies {
            if node.name == "bombContainer" {
                bombCount += 1
                break
            }
        }
        
        if bombCount ==  0 {
            //  stop the fuse sound
            if bombSoundEffect != nil {
                bombSoundEffect.stop()
                bombSoundEffect = nil
            }
        }
        
        
    }
    
    
    
    //MARK: Methods
    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        gameScore.position = CGPoint(x: 8, y: 8)
    }
    
    func createLives() {
        for i in 0 ..< 3 {
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
            addChild(spriteNode)
            
            livesImages.append(spriteNode)
        }
    }
    
    func createSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 2
        
        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9
        
        activeSliceFG.strokeColor = UIColor.white
        activeSliceFG.lineWidth = 5
        
        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }
    
    func redrawActiveSlice() {
        //  Not enough data to draw a path.
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            return
        }
        
        //  Remove oldest points to keep only 12.
        while activeSlicePoints.count > 12 {
            activeSlicePoints.remove(at: 0)
        }
        
        //  Start line at position of first swipe, then iterate over the remaining points.
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])
        
        for i in 1 ..< activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }
        
        //  Update slice shape paths to draw them.
        activeSliceBG.path = path.cgPath
        activeSliceFG.path = path.cgPath
    }
    
    func playSwooshSound() {
        isSwooshSoundActive = true
        
        let randomNumber = RandomInt(min: 1, max: 3)
        let soundName = "swoosh\(randomNumber).caf"
        
        let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        
        run(swooshSound) { [unowned self] in
            self.isSwooshSoundActive = false
        }
    }
    
    func createEnemy(forceBomb: ForceBomb = .random) {
        var enemy: SKSpriteNode
        
        var enemyType = RandomInt(min: 0, max: 6)
        
        if forceBomb == .never {
            enemyType = 1
        } else if forceBomb == .always {
            enemyType = 0
        }
        
        if enemyType == 0 {
            //  Create a SKSpriteNode that acts as a container for the bomb image and the fuse particle emitter.
            enemy = SKSpriteNode()
            enemy.zPosition = 1
            enemy.name = "bombContainer"
            
            //  Add bomb to the container
            let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
            bombImage.name = "bomb"
            enemy.addChild(bombImage)
            
            //  Sound effect is stopped and destroyed if it's playing
            if bombSoundEffect != nil {
                bombSoundEffect.stop()
                bombSoundEffect = nil
            }
            
            //  Creation of the bomb sound
            let path = Bundle.main.path(forResource: "sliceBombFuse.caf", ofType: nil)!
            let url = URL(fileURLWithPath: path)
            let sound = try! AVAudioPlayer(contentsOf: url)
            bombSoundEffect = sound
            sound.play()
            
            //  Add a particle emitter node at the end of the bomb image, and added to the container.
            let emitter = SKEmitterNode(fileNamed: "sliceFuse")!
            emitter.position = CGPoint(x: 76, y: 64)
            enemy.addChild(emitter)
            
            
        } else {
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
            enemy.name = "enemy"
        }
        
        //  Position. Assign random position off the bottom edge of the screen
        let randomPosition = CGPoint(x: RandomInt(min: 64, max: 960), y: -128)
        enemy.position = randomPosition
        
        //  How fast something should spin
        let randomAngularVelocity = CGFloat(RandomInt(min: -6, max: 6)) / 2.0
        var randomXVelocity = 0
        
        //  Create random X velocity based on enemy's position.
        if randomPosition.x < 256 {
            randomXVelocity = RandomInt(min: 8, max: 15)
        } else if randomPosition.x < 512 {
            randomXVelocity = RandomInt(min: 3, max: 5)
        } else if randomPosition.x < 768 {
            randomXVelocity = -RandomInt(min: 3, max: 5)
        } else {
            randomXVelocity = -RandomInt(min: 8, max: 15)
        }
        
        //  Create random Y velocity to make things fly at different speeds.
        let randomYVelocity = RandomInt(min: 24, max: 32)
        
        //  Circular body and collisionBitMask equal to 0 so that they don't collide.
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0
        
        addChild(enemy)
        activeEnemies.append(enemy)
        
    }
    
    func tossEnemies() {
        
        if gameEnded {
            return
        }
        
        popupTime *= 0.991
        chainDelay *= 0.99
        
        physicsWorld.speed *= 1.02
        
        let sequenceType = sequence[sequencePosition]
        
        switch sequenceType {
        case .oneNoBomb:
            createEnemy(forceBomb: .never)
        case .one:
            createEnemy()
        case .twoWithOneBomb:
            createEnemy(forceBomb: .never)
            createEnemy(forceBomb: .always)
        case .two:
            createEnemy()
            createEnemy()
        case .three:
            createEnemy()
            createEnemy()
            createEnemy()
        case .four:
            createEnemy()
            createEnemy()
            createEnemy()
            createEnemy()
        case .chain:
            createEnemy()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0)) { [unowned self] in
                self.createEnemy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 2)) { [unowned self] in
                self.createEnemy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 3)) { [unowned self] in
                self.createEnemy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 4)) { [unowned self] in
                self.createEnemy()
            }
            
        case .fastChain:
            createEnemy()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0)) { [unowned self] in
                self.createEnemy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 2)) { [unowned self] in
                self.createEnemy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 3)) { [unowned self] in
                self.createEnemy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 4)) { [unowned self] in
                self.createEnemy()
            }
        }
        
        sequencePosition += 1
        nextSequenceQueued = false
    }
    
    func subtractLife() {
        lives -= 1
        
        run(SKAction.playSoundFileNamed("wrong.caf", waitForCompletion: false))
        
        var life: SKSpriteNode
        
        if lives == 2 {
            life = livesImages[0]
        } else if lives == 1 {
            life = livesImages[1]
        } else {
            life = livesImages[2]
            endGame(triggeredByBomb: false)
        }
        
        life.texture = SKTexture(imageNamed: "sliceLifeGone")
        life.xScale = 1.3
        life.yScale = 1.3
        life.run(SKAction.scale(to: 1, duration: 0.1))
    }
    
    
    func endGame(triggeredByBomb: Bool) {
        if gameEnded {
            return
        }
        
        gameEnded = true
        physicsWorld.speed = 0
        isUserInteractionEnabled = false
        
        if bombSoundEffect != nil {
            bombSoundEffect.stop()
            bombSoundEffect = nil
        }
        
        if triggeredByBomb {
            livesImages[0].texture = SKTexture(imageNamed: "sliceLifeGone")
            livesImages[1].texture = SKTexture(imageNamed: "sliceLifeGone")
            livesImages[2].texture = SKTexture(imageNamed: "sliceLifeGone")
        }
    }
}
