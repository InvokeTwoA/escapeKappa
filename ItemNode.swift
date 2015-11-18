import SpriteKit

class NikuNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    class func makeEnemy() -> NikuNode {
        let enemy = NikuNode(imageNamed: "niku_32_32")
        enemy.zPosition = 999
        enemy.setPhysic()
        enemy.userData =
            [
                "hp" : 1,
                "score": 10,
        ]
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = itemCategory
        physic.contactTestBitMask = downWorldCategory
        physic.collisionBitMask = worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
}