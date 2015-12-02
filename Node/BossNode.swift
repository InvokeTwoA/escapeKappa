import SpriteKit

class BossNode: SKSpriteNode {
    let width = 64
    let height = 64
    let half_height = 32
    class func makeObject() -> BossNode {
        let enemy = BossNode(imageNamed: "dragon_64_64")
        enemy.zPosition = 999
        enemy.setPhysic()
        enemy.physicsBody!.velocity = CGVectorMake(200, 0)
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(30,32))
        physic.affectedByGravity = false
        physic.allowsRotation = true
        physic.categoryBitMask = bossCategory
        physic.contactTestBitMask = horizonWorldCategory | enemyCategory
        physic.collisionBitMask = horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0

        self.physicsBody = physic
    }
}