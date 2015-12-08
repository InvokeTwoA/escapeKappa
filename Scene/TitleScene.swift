import SpriteKit
class TitleScene: BaseScene {
    override func didMoveToView(view: SKView) {
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.adHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y7 : CGFloat = point_y6 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y8 : CGFloat = point_y7 - CGFloat(CommonConst.textBlankHeight * 2)
        setCenterBigText("走れ、勇者かっぱ", key_name: "title", point_y: point_y1)
        setCenterBigText("Run, Kappa Hero", key_name: "sub_title", point_y: point_y2)
        setCenterButton("START", key_name: "start", point_y: point_y3)
        setCenterButton("Rule", key_name: "rule", point_y: point_y5)
        setCenterButton("Score", key_name: "score", point_y: point_y6)
        setCenterButton("Option", key_name: "option", point_y: point_y7)
        setCenterButton("他のアプリ", key_name: "hoka", point_y: point_y8)
        setCharacter()
    }
    
    override func checkTochEvent(name: String) {
        switch name {
        case "start":
            goGameScene()
        case "hoka":
            goHoka()
        case "rule":
            goRule()
        case "score":
            goScore()
        case "option":
            goOption()
        default:
            return
        }
    }
    
    func setCharacter(){
        setImage("kappa_32_32", key_name: "pic", point: CGPointMake(CGRectGetMinX(self.frame) + 40, CGRectGetMidY(self.frame) ))
        setImage("maou_32_32", key_name: "pic", point: CGPointMake(CGRectGetMaxX(self.frame) - 40, CGRectGetMidY(self.frame)))
        setImage("skelton_32_32", key_name: "pic", point: CGPointMake(CGRectGetMaxX(self.frame) - 40, CGRectGetMidY(self.frame) + 50))
        setImage("knight_32_32", key_name: "pic", point: CGPointMake(CGRectGetMaxX(self.frame) - 40, CGRectGetMidY(self.frame) - 50))

    }
    
    // 他のアプリ画面へ
    func goHoka(){
        let appID = CommonConst.kappaSagaId
        let itunesURL:String = "itms-apps://itunes.apple.com/app/bars/id\(appID)"
        let url = NSURL(string:itunesURL)
        let app:UIApplication = UIApplication.sharedApplication()
        app.openURL(url!)
    }
    
    // ゲーム画面へ
    func goGameScene(){
        CommonData.setData("map_page", value: 0)
        let secondScene = StageSelectScene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    
    func goRule(){
        let secondScene = RuleScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func goScore(){
        let secondScene = ScoreScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func goOption(){
        let secondScene = OptionScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func onClickMyButton(sender : UIButton){
        print("hoge")
    }
}
