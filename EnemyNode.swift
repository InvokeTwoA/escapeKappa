import SpriteKit

class SlimeNode: SKSpriteNode {
    let width = 32
    let height = 32
    let half_height = 16
    class func makeEnemy() -> SlimeNode {
        let enemy = SlimeAnimateNode()        
        enemy.userData =
            [
                "hp" : 1,
                "str" : 1,
                "score": 2,
                "name" : "スライム"
        ]
        enemy.name = "enemy"
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(CommonConst.enemyTileWidth),32))
        physic.affectedByGravity = false
        physic.allowsRotation = true
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = downWorldCategory | enemyCategory | worldCategory | fireCategory
        physic.collisionBitMask = downWorldCategory | heroCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        self.physicsBody = physic
    }
    
    class func SlimeAnimateNode() -> SlimeNode {

        let s1 : SKTexture = SKTexture(imageNamed: "slime1")
        let s2 : SKTexture = SKTexture(imageNamed: "slime2")
        let action = SKAction.animateWithTextures([s1, s2], timePerFrame: 1.00)
        let enemy : SlimeNode = SlimeNode(imageNamed: "slime1")
        enemy.runAction(SKAction.repeatActionForever(action))

//        let enemy : SlimeNode = SlimeNode(imageNamed: "slime1")
        return enemy
    }    
}