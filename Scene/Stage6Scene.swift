import SpriteKit
class Stage6Scene: GameScene {
    
    override func setStageValue() {
        _hp = 15
        _maxhp = 15
        _stage = 6
        self.physicsWorld.gravity = CGVectorMake(0.0, -2.0)
    }

    // lvアップ時に重力変更
    override func lvHeal(){
        let gravity : CGFloat = CGFloat(-2 - _lv/10)
        self.physicsWorld.gravity = CGVectorMake(0.0, gravity)
    }
    
    override func checkScore(){
        if _score >= CommonConst.clearScore {
            CommonData.setData("stage7_flag", value: 2)
        }
    }
    
    override func setVelocity(object: SKPhysicsBody){
        object.velocity =  CGVectorMake(0, CGFloat(-1 * CommonUtil.rnd(_lv)))
    }
    
    // 敵同士が衝突した時 　片方がHP０ならば爆発
    override func crashEnemy(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
        makeSpark(firstBody.node?.position)
        
        let hp1 = firstBody.node?.userData?.valueForKey("hp") as! Int
        let hp2 = secondBody.node?.userData?.valueForKey("hp") as! Int
        if hp1 != 0 && hp2 != 0 {
            return
        }
        let score1 = firstBody.node?.userData?.valueForKey("score") as! Int
        let score2 = secondBody.node?.userData?.valueForKey("score") as! Int
        _score += score1 + score2
        updateScore()
        
        firstBody.node?.removeFromParent()
        secondBody.node?.removeFromParent()
    }
}