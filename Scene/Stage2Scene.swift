import SpriteKit
class Stage2Scene: GameScene {
    
    override func setStageValue() {
        _hp = 20
        _maxhp = 20
        _stage = 2
    }
    
    override func checkScore(){
        if _score >= CommonConst.clearScore {
            CommonData.setData("stage3_flag", value: 1)
        }
    }
    
    override func setVelocity(object: SKPhysicsBody){
        object.velocity =  CGVectorMake(0, CGFloat(-100 - CommonUtil.rnd(200 + _lv)))
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
