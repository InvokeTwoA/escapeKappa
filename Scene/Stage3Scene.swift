import SpriteKit
class Stage3Scene: GameScene {
    
    override func checkScore(){
        if _score >= CommonConst.clearScore {
            CommonData.setData("stage4_flag", value: 1)
        }
    }
    
    override func setStageValue() {
        _stage = 3
        _maxhp = 40
        _hp = 40
        setHouse()
    }
    
    func setHouse(){
        let total_block = Int(self.frame.size.width)/32
        let height: CGFloat = CGFloat(CommonConst.footerHeight + 32 )
        for ( var i = 0; i < total_block ; i++ ) {
            if i%2 == 0 {
                continue
            }
            // オブジェクトを描画
            let object = HouseNode.makeEnemy()
            object.position = CGPointMake(16 + 32*CGFloat(i), height)
            self.addChild(object)
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
        case 50 ..< 55:
            return "fire"
        default:
            return ""
        }
    }
    
    override func isMaxEnemy(enemy_num : Int) -> Bool {
        if _lv < 7 && enemy_num > 1 {
            return true
        } else if _lv < 19 && enemy_num > 2 {
            return true
        } else if _lv < 37 && enemy_num > 3 {
            return true
        } else if _lv < 50 && enemy_num > 4 {
            return true
        } else if enemy_num > 5 {
            return true
        }
        return false
    }
    
    override func hitHouse(enemyBody: SKPhysicsBody){
        makeSpark(enemyBody.node?.position)
        
        damaged(1, point: (enemyBody.node?.position)!, color: UIColor.redColor())
        enemyBody.node?.removeFromParent()
    }
    
    // カッパを高い場所に描画
    override func setKappa() {
        _kappa = KappaNode.makeKappa()
        _kappa.setPhysic()
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.footerHeight + 32 + 10 + 50))
        _kappa.position = point
        self.addChild(_kappa)
    }
}
