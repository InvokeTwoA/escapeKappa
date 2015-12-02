import SpriteKit
class Stage5Scene: GameScene {
    var _bossHP = 50
    override func checkScore(){
        if _score >= CommonConst.clearScore {
            CommonData.setData("stage5_flag", value: 1)
        }
    }
    
    override func setStageValue() {
        _stage = 5
        _maxhp = 30
        _hp = 30
        changeLifeBar()
        changeLifeLabel()
        setDragon()
        updateScore()
    }
    
    func setDragon(){
        let object = BossNode.makeObject()
        object.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + 32))
        self.addChild(object)
    }
    
    override func bossContact(bossBody: SKPhysicsBody, contactBody: SKPhysicsBody){
        if contactBody.categoryBitMask & horizonWorldCategory != 0 {
            if _ready_flag == false {
                return
            }
            let object = FireNode.makeEnemy()
            object.position = (bossBody.node?.position)!
            
            // カッパに向かって突撃してくる
            let duration : Int = CommonUtil.rnd(3) + 1
            let action : SKAction = SKAction.moveTo(_kappa.position, duration: NSTimeInterval(duration))
            action.timingMode = SKActionTimingMode.EaseIn
            object.runAction(action, completion:
                {
                    object.removeFromParent()
                }
            )
            self.addChild(object)
        }
    }

    override func hitBoss(enemyBody: SKPhysicsBody, bossBody: SKPhysicsBody) {
        let enemyNode: SKSpriteNode = enemyBody.node as! SKSpriteNode
        let enemyHP : Int = enemyNode.userData?.valueForKey("hp") as! Int
        let score : Int = enemyNode.userData?.valueForKey("score") as! Int
        if enemyHP == 0 {
            makeSpark(enemyNode.position)
            _score += score
            updateScore()
            
            _bossHP -= 1 + CommonUtil.rnd(3)
            if _bossHP <= 0 {
                _score *= 3
                updateScore()
                gameClear()
            }
            enemyBody.node?.removeFromParent()
        }
    }
    
    func gameClear(){
        _game_over_flag = true
        stopBGM()
        let high_score = CommonData.getDataByInt("high_score_stage\(_stage)")
        if _score > high_score {
            CommonData.setData("high_score_stage\(_stage)", value: _score)
        }
        CommonData.setData("score", value: _score)
        CommonData.setData("stage", value: _stage)
        checkScore()
        let secondScene = GameClearScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 4)
        changeScene(secondScene, tr: tr)
    }
    
    override func crashEnemy(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
            return
    }
    
    override func updateScore(){
        let score_label : SKLabelNode? = childNodeWithName("header_status")?
            .childNodeWithName("score") as? SKLabelNode
        score_label!.text = "SCORE : \(_score)　BossHP: \(_bossHP)"
        if _lv * 10 <= _score {
            lvUp()
        }
    }
    
    // オブジェクトの種別を選択
    // 回復アイテムは出現しない
    override func chaseObjectType() -> String{
        switch CommonUtil.rnd(100) {
        case 0 ..< 10:
            return "item"
        case 10 ..< 50:
            return "enemy"
        case 85 ..< 85 + _lv:
            return "fire"
        default:
            return ""
        }
    }
}
