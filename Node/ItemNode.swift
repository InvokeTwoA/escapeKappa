import SpriteKit

class ItemNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    class func makeEnemy() -> ItemNode {
        switch CommonUtil.rnd(100) {
        case 0 ..< 10:
            let enemy = ItemNode(imageNamed: "kusuri_blue_32_32")
            enemy.zPosition = 999
            enemy.setPhysic()
            enemy.userData =
                [
                    "type": "blue",
                    "hp": 1,
                    "score": 15,
            ]
            return enemy
        default:
            let enemy = ItemNode(imageNamed: "kusuri_32_32")
            enemy.zPosition = 999
            enemy.setPhysic()
            enemy.userData =
                [
                    "type": "green",
                    "hp" : 1,
                    "score": 10,
            ]
            return enemy
        }
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = itemCategory
        physic.contactTestBitMask = downWorldCategory
        physic.collisionBitMask = worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
}