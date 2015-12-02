import SpriteKit
import Social
class ScoreScene: BaseScene {
    var _total_score : Int = 0
    override func didMoveToView(view: SKView) {
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.adHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y7 : CGFloat = point_y6 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y8 : CGFloat = point_y7 - CGFloat(CommonConst.textBlankHeight * 2)
        setCenterText("High Score", key_name: "text", point_y: point_y1)
        
        let high_score1 = CommonData.getDataByInt("high_score_stage1")
        setCenterText("Stage1 : \(high_score1)", key_name: "text", point_y: point_y2)

        let high_score2 = CommonData.getDataByInt("high_score_stage2")
        setCenterText("Stage2 : \(high_score2)", key_name: "text", point_y: point_y3)

        let high_score3 = CommonData.getDataByInt("high_score_stage3")
        setCenterText("Stage3 : \(high_score3)", key_name: "text", point_y: point_y4)

        let high_score4 = CommonData.getDataByInt("high_score_stage4")
        setCenterText("Stage4 : \(high_score4)", key_name: "text", point_y: point_y5)
        
        let high_score5 = CommonData.getDataByInt("high_score_stage5")
        setCenterText("Stage5 : \(high_score5)", key_name: "text", point_y: point_y6)

        _total_score = high_score1 + high_score2 + high_score3 + high_score4 + high_score5
        setCenterText("Total : \(_total_score)", key_name: "text", point_y: point_y7)

        setCenterButton("結果をつぶやく", key_name: "tweet", point_y: point_y8)
        
        setBackButton("タイトルに戻る")
    }
    
    override func checkTochEvent(name: String) {
        switch name {
        case "back":
            goTitleScene()
        case "tweet":
            setTweet()
        default:
            return
        }
    }
    
    func setTweet(){
        let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterCmp.setInitialText("勇者LV \(_total_score) #走れ、勇者かっぱ")
        let image = CommonUtil.screenShot(self.view!)
        twitterCmp.addImage(image)
        let currentViewController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController!
        
        //ツイート画面を表示
        currentViewController?.presentViewController(twitterCmp, animated: true, completion: nil)
    }
    
    // タイトル画面へ
    func goTitleScene(){
        let secondScene = TitleScene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
}
