import SpriteKit

class FireNode: SKSpriteNode {
    let width = 32
    let height = 32
    let half_height = 16
    class func makeEnemy() -> FireNode {
        let enemy = FireNode(imageNamed: "fire_32_32")
        enemy.userData =
            [
                "hp" : 3,
                "str" : 2,
                "def": 6,
                "mdef": 0,
                "gold": 3,
                "score": 1,
                "name" : "フレイム"
        ]
        enemy.name = "enemy"
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(12, 12))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = fireCategory
        physic.contactTestBitMask = downWorldCategory | upWorldCategory
        physic.collisionBitMask = worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        self.physicsBody = physic
    }    
}