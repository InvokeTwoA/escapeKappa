//ゲームオーバー画面
import SpriteKit
import Social
class GameClearScene: BaseScene {
    var _score = CommonData.getDataByInt("score")
    var _stage = CommonData.getDataByInt("stage")
    var _nickname = "勇者"
    var _score_text_y1 : CGFloat = 0
    var _score_text_y2 : CGFloat = 0
    var _score_text_y3 : CGFloat = 0
    override func didMoveToView(view: SKView) {
        let y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.adHeight + CommonConst.textBlankHeight)
        let y2 = y1 - CGFloat(CommonConst.textBlankHeight)
        let y3 = y2 - CGFloat(CommonConst.textBlankHeight*2)
        let y4 = y3 - CGFloat(CommonConst.textBlankHeight*2)
        let y5 = y4 - CGFloat(CommonConst.textBlankHeight)
        let y6 = y5 - CGFloat(CommonConst.textBlankHeight*2)
        let y7 = y6 - CGFloat(CommonConst.textBlankHeight)
        let y8 = y7 - CGFloat(CommonConst.textBlankHeight*2)
        let y9 = y8 - CGFloat(CommonConst.textBlankHeight*2)
        let y10 = y9 - CGFloat(CommonConst.textBlankHeight*2)
        
        // 共通文言
        setCenterText("Thank you for Playing", key_name: "text1", point_y: y1)
        setCenterText("君こそ真の勇者！", key_name: "text1", point_y: y2)
        setCenterText("ステージ\(_stage)", key_name: "text1", point_y: y3)
        setCenterText("SCORE: \(_score)", key_name: "text1", point_y: y4)
        
        setCenterButton("結果をつぶやく", key_name: "tweet", point_y: y8)
        setCenterButton("もう一回挑戦する", key_name: "retry", point_y: y9)
        setCenterButton("タイトルに戻る", key_name: "back", point_y: y10)
        setImage("knight_32_32",  key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) + 100, y:y5))
        setImage("miira_32_32",   key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) + 50, y:y5))
        setImage("maou_32_32",    key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame),      y:y5))
        setImage("skelton_32_32", key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) - 50, y:y5))
        setImage("fire_32_32",    key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) - 100, y:y5))
        setImage("kappa_32_32",   key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame),      y:y6))
        setImage("miku_32_32",    key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) + 50, y:y6))
        setImage("fighter_32_32", key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) - 50, y:y6))
        setImage("sister_32_32",  key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) - 100, y:y6))
        setImage("witch_32_32",   key_name: "p", point: CGPoint(x:CGRectGetMidX(self.frame) + 100, y:y6))
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            let nextScene = TitleScene(size: self.frame.size)
            let tr = SKTransition.flipHorizontalWithDuration(1)
            changeScene(nextScene, tr: tr)
        } else if name == "retry" {
            retryStage()
        } else if name == "tweet" {
            setTweet()
        }
    }
    
    func setTweet(){
        let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        twitterCmp.setInitialText("ゲームクリア！　スコア:\(_score) \(_nickname)  #走れ、勇者かっぱ")
        let image = CommonUtil.screenShot(self.view!)
        twitterCmp.addImage(image)
        let currentViewController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController!
        
        //ツイート画面を表示
        currentViewController?.presentViewController(twitterCmp, animated: true, completion: nil)
    }
    
    func retryStage(){
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(Stage5Scene(size: self.frame.size), tr: tr)
    }
}
