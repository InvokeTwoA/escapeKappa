import SpriteKit
class Stage7Scene: GameScene {
    var _bossHP = 55
    override func checkScore(){
    }
    
    override func setStageValue() {
        _stage = 7
        _maxhp = 25
        _hp = 25
        changeLifeBar()
        changeLifeLabel()
        setDragon()
    }
    
    func setDragon(){
        let object = BossNode.makeObject()
        object.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + 32))
        self.addChild(object)

        let object2 = BossNode.makeObject()
        object2.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + 32))
        self.addChild(object2)
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
        makeSpark(enemyNode.position)
        if enemyHP == 0 {
            _score += score
            updateScore()
            _bossHP -= 1 + CommonUtil.rnd(3)
            if _bossHP <= 0 {
                let position1 = CGPointMake(enemyNode.position.x + 100 , enemyNode.position.y + 100)
                let position2 = CGPointMake(enemyNode.position.x + 50, enemyNode.position.y + 50)
                let position3 = CGPointMake(enemyNode.position.x - 50, enemyNode.position.y + -50)
                let position4 = CGPointMake(enemyNode.position.x - 100, enemyNode.position.y + -100)
                makeSpark(position1)
                makeSpark(position2)
                makeSpark(position3)
                makeSpark(position4)
                
                _score *= 3
                updateScore()
                gameClear()
                bossBody.node?.removeFromParent()
            }
            enemyBody.node?.removeFromParent()
        }
    }
    
    func gameClear(){
        if _game_over_flag == true {
            return
        }
        _game_over_flag = true
        stopBGM()
        let high_score = CommonData.getDataByInt("high_score_stage\(_stage)")
        if _score > high_score {
            CommonData.setData("high_score_stage\(_stage)", value: _score)
        }
        CommonData.setData("score", value: _score)
        CommonData.setData("stage", value: _stage)
        checkScore()
        reportAchievement("grp.hashireKappa.tassei4")
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("goClearScene"), userInfo: nil, repeats: false)
    }
    
    func goClearScene(){
        let secondScene = GameClearScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 4)
        changeScene(secondScene, tr: tr)
    }
    override func crashEnemy(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
        return
    }
    
    override func updateScore(){
        if _game_over_flag == true {
            return
        }
        let score_label : SKLabelNode? = childNodeWithName("header_status")?
            .childNodeWithName("score") as? SKLabelNode
        score_label!.text = "SCORE : \(_score)  BossHP: \(_bossHP)"
        if _lv * 10 <= _score {
            lvUp()
        }
    }
    
    // オブジェクトの種別を選択
    override func chaseObjectType() -> String{
        switch CommonUtil.rnd(100) {
        case 0 ..< 10:
            return "item"
        case 10 ..< 50:
            return "enemy"
        case 90 ..< 90 + _lv:
            return "fire"
        default:
            return ""
        }
    }
}