import Foundation
import SpriteKit
import AVFoundation
import CoreMotion
class BaseScene: SKScene, SKPhysicsContactDelegate, AVAudioPlayerDelegate {
    var _kappa : KappaNode = KappaNode.makeKappa()
    var _audioPlayer:AVAudioPlayer!
    let motionManager = CMMotionManager()
    
    var _dx : Int = CommonData.getDataByInt("dx")
    let _music_off = CommonData.getDataByBool("music_off")
    
    // 上がいて使う
    func baseSetting(){
    }
    func prepareBGM(fileName : String){
        if _music_off == true {
            return
        }
        let bgm_path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!)
        var audioError:NSError?
        do {
            _audioPlayer = try AVAudioPlayer(contentsOfURL: bgm_path)
        } catch let error as NSError {
            audioError = error
            _audioPlayer = nil
        }
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        _audioPlayer.delegate = self
        _audioPlayer.prepareToPlay()
    }
    
    func playBGM(){
        if _music_off == true {
            return
        }
        _audioPlayer.numberOfLoops = -1;
        if ( !_audioPlayer.playing ){
            _audioPlayer.play()
        }
    }
    
    func stopBGM(){
        if _music_off == true {
            return
        }
        if ( _audioPlayer.playing ){
            _audioPlayer.stop()
        }
    }
    
    /* 文章系 */
    func setLeftText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:point_y)
        let startButton: SKLabelNode = CommonUI.normalText(text, name: key_name, point: point)
        self.addChild(startButton)
    }
    
    func setCenterText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let startButton: SKLabelNode = CommonUI.normalText(text, name: key_name, point: point)
        self.addChild(startButton)
    }
    
    func setCenterFadeText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let label: SKLabelNode = CommonUI.normalText(text, name: key_name, point: point)
        self.addChild(label)
        let fade : SKAction = SKAction.fadeOutWithDuration(4)
        label.runAction(fade)
    }
    func setCenterBigText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let startButton: SKLabelNode = CommonUI.bigText(text, name: key_name, point: point)
        self.addChild(startButton)
    }
    func setCenterBigFadeText(text: String, key_name: String, point_y : CGFloat, duration: NSTimeInterval){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let label: SKLabelNode = CommonUI.bigText(text, name: key_name, point: point)
        self.addChild(label)
        let fade : SKAction = SKAction.fadeOutWithDuration(duration)
        label.runAction(fade)
    }
    
    func setCenterButton(display_name: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let startButton: SKSpriteNode = CommonUI.normalButton(display_name, name: key_name, point: point)
        self.addChild(startButton)
    }
    
    func setPicture(path: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:point_y)
        let picture = SKSpriteNode(imageNamed: path)
        picture.name = key_name
        picture.position = point
        self.addChild(picture)
    }
    
    func setImage(path: String, key_name: String, point: CGPoint){
        let chara = SKSpriteNode(imageNamed: path)
        chara.position = point
        self.addChild(chara)
    }

    
    // 戻るボタンを画面下に設置
    func setBackButton(text : String) {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + CGFloat( CommonConst.textBlankHeight))
        let startButton: SKSpriteNode = CommonUI.normalButton(text, name: "back", point: point)
        self.addChild(startButton)
    }
    
    func changeScene(secondScene: SKScene, tr : SKTransition){
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
    }
    
    // タッチイベント
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            if (touchedNode.name != nil) {
                checkTochEvent(touchedNode.name!)
            }
        }
    }

    func checkTochEvent(name :String){
    }
    
    func setWorldPhysic(size: CGSize) -> SKPhysicsBody {
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = wallCategory
        return physic
    }

    func setDownWorld(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame))
        let size : CGSize = CGSizeMake(CGRectGetMaxX(self.frame), 1.0)
        let ground : SKSpriteNode = SKSpriteNode(color: UIColor.grayColor(), size: size)
        ground.position = point
        ground.zPosition = 100
        ground.physicsBody = setWorldPhysic(size)
        self.addChild(ground)
    }
    
    func setUpWorld(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame))
        let size : CGSize = CGSizeMake(CGRectGetMaxX(self.frame), 1.0)
        let ground : SKSpriteNode = SKSpriteNode(color: UIColor.grayColor(), size: size)
        ground.position = point
        ground.zPosition = 100
        ground.physicsBody = setWorldPhysic(size)
        self.addChild(ground)
    }
    
    // 左の壁
    func setLeftWorld(){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(frame), y: CGRectGetMidY(self.frame))
        let size : CGSize = CGSizeMake(1, self.frame.height)
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = horizonWorldCategory | worldCategory
        let background : SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
        background.position = point
        background.zPosition = 100
        background.physicsBody = physic
        self.addChild(background)
    }
    
    // 右の壁
    func setRightWorld(){
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(frame), y: CGRectGetMidY(self.frame))
        let size : CGSize = CGSizeMake(1, self.frame.height)
        let background : SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
        background.position = point
        background.zPosition = 100
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = horizonWorldCategory | worldCategory
        background.physicsBody = physic
        self.addChild(background)
    }
    
    // 衝突時など、火花を出す
    func makeSpark(location: CGPoint?, size :String = "normal"){
        if location == nil {
            return
        }
        let particle : SKEmitterNode
        if size == "normal" {
            particle = SparkEmitterNode.makeSpark()
        } else {
            particle = SparkEmitterNode.makeMiniSpark()
        }
        particle.position = location!
        particle.zPosition = 1
        
        let fade : SKAction = SKAction.fadeOutWithDuration(4)
        particle.runAction(fade)
        self.addChild(particle)
    }
    
    // 火を出す
    func makeFire(location: CGPoint?){
        if location == nil {
            return
        }
        let particle = FireEmitterNode.makeFire()
        particle.position = location!
        particle.zPosition = 1
        let fade : SKAction = SKAction.fadeOutWithDuration(3)
        particle.runAction(fade)
        self.addChild(particle)
    }
    
    // カッパを描画
    func setKappa() {
        _kappa = KappaNode.makeKappa()
        _kappa.setPhysic()
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.footerHeight + 32 + 10))
        _kappa.position = point
        self.addChild(_kappa)
    }
    
    func setWorld(){
        setRightWorld()
        setLeftWorld()
        setUpWorld()
        setDownWorld()
    }
    
    func setMotion(){
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates()
    }
    
    func setDx(){
        if _dx == 0 {
            _dx = CommonConst.defaultSpeed
        }
    }
    
    func setVelocity(x : Double, y : Double){
        let dx = CGFloat(Double(_dx)*x)
        _kappa.physicsBody?.velocity = CGVectorMake(dx, 0)
    }

    
    

}
