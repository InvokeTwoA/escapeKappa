import SpriteKit
import CoreMotion
import AVFoundation
class GameScene: GameBaseScene  {
    var _hp : Int       = 30
    var _maxhp : Int = 30
    var _lv = 1
    
    var _lifeBarWidth : CGFloat = 0.0
    
    var _lastUpdateTimeInterval : NSTimeInterval = 0
    var _timeSinceStart : NSTimeInterval = 0
    var _timeSinceLastSecond : NSTimeInterval = 0
    
    var _stageHeight : CGFloat = 0.0
    
    var _score : Int = 0
    var _game_over_flag : Bool = false
    var _ready_flag : Bool = false
    var _count_start_flag = false
    
    var _stage = 1
    var _high_score = 0
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        setWorld()
        setFooter()
        setStageValue()
        setHeader()
        setKappa()
        setDx()
        setMotion()
        prepareBGM("tanoshii")
        self.physicsWorld.contactDelegate = self
        _stageHeight = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.footerHeight)
    }
    
    func setHighScore() {
        _high_score = CommonData.getDataByInt("high_score_stage\(_stage)")
    }
    
    func setStageValue(){
    
    }
    
    func setHeader(){
        let header_height = CommonConst.headerHeight - CommonConst.adHeight
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMaxY(frame) - CGFloat(CommonConst.adHeight + header_height/2))
        let size : CGSize = CGSizeMake(CGRectGetMaxX(frame), CGFloat(header_height))
        let color : UIColor = UIColor(red:0.2,green:0.2,blue:0.2,alpha:1.0)
        
        let background : SKSpriteNode = SKSpriteNode(color: color, size: size)
        background.position = point
        background.zPosition = 90
        background.name = "header_status"
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = worldCategory | upWorldCategory
        background.physicsBody = physic
        
        // スコア表示
        let score : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        score.text = "SCORE : 0"
        score.fontSize = 18
        score.position = CGPointMake(0, 0)
        score.fontColor = UIColor.whiteColor()
        score.name = "score"
        background.addChild(score)

        setHighScore()
        let high_score : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        high_score.text = "HIGH_SCORE: \(_high_score)"
        high_score.fontSize = 18
        high_score.position = CGPointMake(0, -25)
        high_score.fontColor = UIColor.whiteColor()
        high_score.name = "high_score"
        background.addChild(high_score)

        self.addChild(background)
    }
    
    // ライフなどを表示するフッターを表示
    func setFooter(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMinY(frame) + CGFloat(CommonConst.footerHeight)/2)
        let size : CGSize = CGSizeMake(CGRectGetMaxX(frame), CGFloat(CommonConst.footerHeight))
        let color : UIColor = UIColor(red:0.2,green:0.2,blue:0.2,alpha:1.0)
        let footer : SKSpriteNode = SKSpriteNode(color: color, size: size)
        footer.position = point
        footer.name = "footer_status"
        footer.zPosition = 10
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = downWorldCategory | worldCategory
        footer.physicsBody = physic
        
        let blackBar = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(_lifeBarWidth, CGFloat(CommonConst.lifeBarHeight)))
        blackBar.position = CGPointMake(-1*CGRectGetMidX(self.frame) + 30, -20)
        blackBar.anchorPoint = CGPointMake(0, 0)
        blackBar.zPosition = 11
        footer.addChild(blackBar)
        
        _lifeBarWidth = self.frame.size.width - 100
        let yellowBar = SKSpriteNode(color: UIColor.yellowColor(), size: CGSizeMake(_lifeBarWidth, CGFloat(CommonConst.lifeBarHeight)))
        yellowBar.position = CGPointMake( -1 * CGRectGetMidX(self.frame) + 30, -20)
        yellowBar.name = "life_bar"
        yellowBar.anchorPoint = CGPointMake(0, 0)
        yellowBar.zPosition = 12
        footer.addChild(yellowBar)
        
        let hpLabel :SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        hpLabel.position = CGPointMake(-1 * CGRectGetMidX(self.frame)/2, 20)
        hpLabel.fontSize = 18
        hpLabel.text = "HP : \(_hp) / \(_maxhp)"
        hpLabel.name = "hp_label"
        hpLabel.fontColor = UIColor.whiteColor()
        footer.addChild(hpLabel)
        
        self.addChild(footer)
    }
    
    // HPに変化があったのでライフバーを変更
    func changeLifeBar(){
        let life_bar : SKSpriteNode? = childNodeWithName("footer_status")?
            .childNodeWithName("life_bar") as? SKSpriteNode
        var width: Double = Double(_hp)/Double(_maxhp) * Double(_lifeBarWidth)
        if (width <= 0) {
            width = 1
        }
        life_bar!.size = CGSizeMake(CGFloat(width), CGFloat(CommonConst.lifeBarHeight))
    }
    
    // HPに変化があったのでライフバーの文字表示を変更
    func changeLifeLabel(){
        if _hp <= 0 {
            _hp = 0
        } else if _hp > _maxhp {
            _hp = _maxhp
        }
        let life_label : SKLabelNode? = childNodeWithName("footer_status")?
            .childNodeWithName("hp_label") as? SKLabelNode
        life_label!.text = "HP : \(_hp) / \(_maxhp)"
    }
    override func checkTochEvent(name: String) {
    }
    func generateEnemy(){
        let total_block = Int(self.frame.size.width)/32
        var enemy_num = 0
        let from_right = CommonUtil.rnd(2)
        let height: CGFloat = CGFloat(_stageHeight-17) + CGFloat(CommonConst.footerHeight)
        for ( var i = 0; i < total_block ; i++ ) {
            if CommonUtil.rnd(2) == 0 {
                continue
            }
            let object_type = chaseObjectType()
            if object_type == "" {
                continue
            }
            var object : SKSpriteNode = EnemyNode.makeEnemy("skelton_32_32", score: 2)
            switch object_type {
            case "item":
                object = ItemNode.makeEnemy()
                enemy_num += 1
            case "fire" :
                object = FireNode.makeEnemy()
                enemy_num += 1
            default:
                object = chaseEnemy()
                enemy_num += 1
            }
            setVelocity(object.physicsBody!)
            if isMaxEnemy(enemy_num) {
                continue
            }

            // オブジェクトを描画
            if from_right == 0 {
                object.position = CGPointMake(CGRectGetMaxX(self.frame) - 16 - 32*CGFloat(i), height)
            } else {
                object.position = CGPointMake(16 + 32*CGFloat(i), height)
            }
            self.addChild(object)
        }
    }
    
    func setVelocity(object: SKPhysicsBody){
        object.velocity =  CGVectorMake(0, CGFloat(-200 - _lv))
    }
    
    func isMaxEnemy(enemy_num : Int) -> Bool {
        if _lv < 3 && enemy_num > 1 {
            return true
        } else if _lv < 13 && enemy_num > 2 {
            return true
        } else if _lv < 27 && enemy_num > 3 {
            return true
        } else if _lv < 37 && enemy_num > 4 {
            return true
        } else if enemy_num > 5 {
            return true
        }
        return false
    }
    
    // オブジェクトの種別を選択
    func chaseObjectType() -> String{
        switch CommonUtil.rnd(100) {
        case 0 ..< 5:
            return "item"
        case 5 ..< 50:
            return "enemy"
        case 50 ..< 60+_lv:
            return "fire"
        default:
            return ""
        }
    }
    // 敵を選択
    func chaseEnemy() -> EnemyNode {
        switch CommonUtil.rnd(100) {
        case 0 ..< 1:
            return EnemyNode.makeEnemy("metal_slime_32_32", score: 30)
        case 1 ..< 10:
            return EnemyNode.makeEnemy("maou_32_32", score: 5)
        case 10 ..< 30:
            return EnemyNode.makeEnemy("knight_32_32", score: 3)
        case 30 ..< 60:
            return EnemyNode.makeEnemy("miira_32_32", score: 2)
        case 60 ..< 100:
            return EnemyNode.makeEnemy("skelton_32_32", score: 1)
        default:
            return EnemyNode.makeEnemy("metal_slime_32_32", score: 50)
        }
    }
    
    // 敵と衝突時
    func hitEnemy(heroBody: SKPhysicsBody, enemyBody: SKPhysicsBody){
        makeSpark(heroBody.node?.position, size: "mini")

        // 敵を吹き飛ばす
        let enemyNode: SKSpriteNode = enemyBody.node as! SKSpriteNode
        enemyNode.userData?.setValue(0, forKey: "hp")
        enemyBody.applyImpulse(CGVectorMake(0, 7), atPoint: CGPointMake(0,28))
    }

    // 炎と衝突時
    func hitFire(heroBody: SKPhysicsBody, fireBody: SKPhysicsBody){
        makeFire(heroBody.node?.position)
        damaged(7, point: (heroBody.node?.position)!, color: UIColor.redColor())
        fireBody.node?.removeFromParent()
    }
    
    // アイテムと衝突時
    func hitItem(heroBody: SKPhysicsBody, itemBody: SKPhysicsBody){
        if itemBody.node!.userData?.valueForKey("type") as! String == "green" {
            heal(5, point: (itemBody.node?.position)!)
        } else {
            hpMaxUp(5, point: (itemBody.node?.position)!)
        }
        _score+=5
        updateScore()
        itemBody.node?.removeFromParent()
    }
    
    func updateScore(){
        let score_label : SKLabelNode? = childNodeWithName("header_status")?
            .childNodeWithName("score") as? SKLabelNode
        score_label!.text = "SCORE : \(_score)"
        if _lv * 10 <= _score {
            lvUp()
        }
    }
    
    func lvUp(){
        // 以前の表示が残っていたら消す
        let pre_label : SKLabelNode? = childNodeWithName("lv") as? SKLabelNode
        if pre_label != nil {
            pre_label!.removeFromParent()
        }
        _lv = Int(_score/10) + 1
        setCenterBigFadeText("LV \(_lv)", key_name: "lv", point_y: CGRectGetMidY(self.frame), duration: 4)
        lvHeal()
    }
    
    func lvHeal(){
    }
    
    // HPが0以下になったらゲームオーバー
    func damaged(value: Int, point: CGPoint, color : UIColor){
        let damage : Int = value
        _hp -= damage
        changeLifeBar()
        changeLifeLabel()
        displayDamage(damage, point: point, color: color)
        if(_hp <= 0 ){
            youDead()
        }
    }
    
    func heal(value: Int, point: CGPoint){
        _hp += value
        displayDamage(value, point: point, color: UIColor.yellowColor())
        if(_hp > _maxhp ){
            _hp = _maxhp
        }
        changeLifeBar()
        changeLifeLabel()
    }
    
    func hpMaxUp(value: Int, point: CGPoint){
        _hp += 1
        _maxhp += 1
        displayDamage(1, point: point, color: UIColor.yellowColor())
        changeLifeBar()
        changeLifeLabel()
    }
    
    // ダメージを数字で表示
    func displayDamage(value: Int, point: CGPoint, color: UIColor){
        let location = CGPointMake(point.x, point.y + 50.0)
        let label = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.text = "\(value)"
        label.position = location
        label.fontColor = color
        label.fontSize = 25
        label.zPosition = 90
        self.addChild(label)
        
        let fade : SKAction = SKAction.fadeOutWithDuration(4)
        label.runAction(fade)
    }
    
    // 敵同士が衝突した時
    func crashEnemy(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody){
        makeSpark(firstBody.node?.position)

        let score1 = firstBody.node?.userData?.valueForKey("score") as! Int
        let score2 = secondBody.node?.userData?.valueForKey("score") as! Int
        _score += score1 + score2
        updateScore()
        
        firstBody.node?.removeFromParent()
        secondBody.node?.removeFromParent()
    }
    
    // 敵が壁に衝突した時
    func breakEnemy(enemyBody: SKPhysicsBody){
        makeSpark(enemyBody.node?.position)
        let score = enemyBody.node?.userData?.valueForKey("score") as! Int
         _score += score
        updateScore()
        enemyBody.node?.removeFromParent()
    }
    
    func hitHouse(enemyBody: SKPhysicsBody){
    
    }
    
    func removeFire(){
    
    }
    
    func hitBoss(enemyBody : SKPhysicsBody, bossBody: SKPhysicsBody) {
    
    }
    
    // 衝突判定
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.node == nil || secondBody.node == nil {
            return
        }
        
        // 衝突判定
        if (firstBody.categoryBitMask & heroCategory != 0 ) {
            heroContact(firstBody, contactBody: secondBody)
        } else if (firstBody.categoryBitMask & enemyCategory != 0 ) {
            enemyContact(firstBody, contactBody: secondBody)
        } else if (firstBody.categoryBitMask & fireCategory != 0 ) {
            fireContact(firstBody, contactBody: secondBody)
        } else if (firstBody.categoryBitMask & itemCategory != 0 ) {
            itemContact(firstBody, contactBody: secondBody)
        } else if (firstBody.categoryBitMask & bossCategory != 0 ) {
            bossContact(firstBody, contactBody: secondBody)
        }
    }
    
    // 主人公の衝突判定
    func heroContact(heroBody: SKPhysicsBody, contactBody: SKPhysicsBody){
        if contactBody.categoryBitMask & enemyCategory != 0 {
            hitEnemy(heroBody, enemyBody: contactBody)
        } else if contactBody.categoryBitMask & fireCategory != 0 {
            hitFire(heroBody, fireBody: contactBody)
        } else if contactBody.categoryBitMask & itemCategory != 0 {
            hitItem(heroBody, itemBody: contactBody)
        }
    }
    
    // 敵の衝突判定
    func enemyContact(enemyBody: SKPhysicsBody, contactBody: SKPhysicsBody){
        if contactBody.categoryBitMask & downWorldCategory != 0 {
            let enemyNode: SKSpriteNode = enemyBody.node as! SKSpriteNode
            let enemyHP : Int = enemyNode.userData?.valueForKey("hp") as! Int
            if enemyHP == 0 {
                breakEnemy(enemyBody)
            } else {
                enemyBody.node?.removeFromParent()
            }
        } else if contactBody.categoryBitMask & worldCategory != 0 {
            let enemyNode: SKSpriteNode = enemyBody.node as! SKSpriteNode
            let enemyHP : Int = enemyNode.userData?.valueForKey("hp") as! Int
            if enemyHP == 0 {
                breakEnemy(enemyBody)
            }
        } else if contactBody.categoryBitMask & fireCategory != 0 {
            breakEnemy(enemyBody)
        } else if contactBody.categoryBitMask & enemyCategory != 0 {
            crashEnemy(enemyBody, secondBody: contactBody)
        } else if contactBody.categoryBitMask & itemCategory != 0 {
            crashEnemy(enemyBody, secondBody: contactBody)
        } else if contactBody.categoryBitMask & houseCategory != 0 {
            hitHouse(enemyBody)
        } else if contactBody.categoryBitMask & bossCategory != 0 {
            hitBoss(enemyBody, bossBody: contactBody)
        }
    }
    
    // 炎の衝突判定
    func fireContact(fireBody: SKPhysicsBody, contactBody: SKPhysicsBody){
        if contactBody.categoryBitMask & downWorldCategory != 0 {
            fireBody.node?.removeFromParent()
            removeFire()
        }
    }
    // アイテムの衝突判定
    func itemContact(itemBody: SKPhysicsBody, contactBody: SKPhysicsBody){
        if contactBody.categoryBitMask & downWorldCategory != 0 {
            itemBody.node?.removeFromParent()
        }
    }
    
    // ボスの衝突判定
    func bossContact(itemBody: SKPhysicsBody, contactBody: SKPhysicsBody){
    }
    
    func youDead(){
        _game_over_flag = true
        goGameOver()
        stopBGM()
    }
    
    // ゲームオーバー画面へ
    func goGameOver(){
        if _score > _high_score {
            CommonData.setData("high_score_stage\(_stage)", value: _score)
        }
        CommonData.setData("score", value: _score)
        CommonData.setData("stage", value: _stage)
        checkScore()
        let secondScene = GameOverScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 4)
        changeScene(secondScene, tr: tr)
    }
    func checkScore(){
    }

    
    func readyStartCount3(){
        if _count_start_flag == true {
            return
        }
        updateScore()
        _count_start_flag = true
        setCenterBigFadeText("3", key_name: "count3", point_y: CGRectGetMidY(self.frame), duration: 0.5)
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("readyStartCount2"), userInfo: nil, repeats: false)
    }
    func readyStartCount2(){
        let pre_label : SKLabelNode? = childNodeWithName("count3") as? SKLabelNode
        if pre_label != nil {
            pre_label!.removeFromParent()
        }
        setCenterBigFadeText("2", key_name: "count2", point_y: CGRectGetMidY(self.frame), duration: 0.5)
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("readyStartCount1"), userInfo: nil, repeats: false)
    }
    func readyStartCount1(){
        setCenterBigFadeText("1", key_name: "count1", point_y: CGRectGetMidY(self.frame), duration: 0.5)
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("readyStart"), userInfo: nil, repeats: false)
    }
    func readyStart(){
        playBGM()
        setCenterBigFadeText("Start", key_name: "count_start", point_y: CGRectGetMidY(self.frame), duration: 1.5)
        _ready_flag = true
    }

    override func update(currentTime: CFTimeInterval) {
        if _ready_flag == false {
            readyStartCount3()
            return
        } else if _game_over_flag == true {
             return
        }
        
        // 時間関係の処理
        let timeSinceLast : CFTimeInterval = currentTime - _lastUpdateTimeInterval
        _timeSinceStart += timeSinceLast
        _timeSinceLastSecond += timeSinceLast
        if (_timeSinceLastSecond >= 0.5) {
            _timeSinceLastSecond = 0
            generateEnemy()
        }
        _lastUpdateTimeInterval = currentTime
        
        // 加速度の処理
        if let accelerometerData = motionManager.accelerometerData {
            setVelocity(accelerometerData.acceleration.x, y: accelerometerData.acceleration.y)
        }
    }
}
