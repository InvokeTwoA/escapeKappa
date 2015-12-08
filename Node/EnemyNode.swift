import SpriteKit

class EnemyNode: SKSpriteNode {
    let width = 32
    let height = 32
    let half_height = 16
    class func makeEnemy(name : String, score : Int) -> EnemyNode {
        let enemy = EnemyNode(imageNamed: name)
        enemy.userData =
            [
                "hp" : 1,
                "score": score,
                "name" : name
        ]
        enemy.name = name
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(30,32))
        physic.affectedByGravity = true
        physic.allowsRotation = true
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = downWorldCategory | enemyCategory | worldCategory | fireCategory | itemCategory | houseCategory | bossCategory
        physic.collisionBitMask = downWorldCategory | heroCategory | worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        self.physicsBody = physic
    }
}