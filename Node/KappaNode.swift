import SpriteKit

class KappaNode: SKSpriteNode {
    class func makeKappa() -> KappaNode {
        
        let s1 : SKTexture = SKTexture(imageNamed: "kappa_32_32")
        let s2 : SKTexture = SKTexture(imageNamed: "kappa2_32_32")
        let s3 : SKTexture = SKTexture(imageNamed: "kappa3_32_32")
        let action = SKAction.animateWithTextures([s1, s2, s1, s3, s2], timePerFrame: 0.05)
        let kappa : KappaNode = KappaNode(imageNamed: "kappa_32_32")
        kappa.runAction(SKAction.repeatActionForever(action))
        kappa.name = "kappa"
        return kappa
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(32,32))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = heroCategory
        physic.contactTestBitMask = coinCategory | worldCategory | wallCategory | enemyCategory | itemCategory |  downWorldCategory | fireCategory
        physic.collisionBitMask = worldCategory | wallCategory | horizonWorldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
}