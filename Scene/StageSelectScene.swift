import SpriteKit
class StageSelectScene: BaseScene {
    override func didMoveToView(view: SKView) {
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.adHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y7 : CGFloat = point_y6 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y8 : CGFloat = point_y7 - CGFloat(CommonConst.textBlankHeight * 2)
//        let point_y9 : CGFloat = point_y8 - CGFloat(CommonConst.textBlankHeight * 2)
        setCenterBigText("ステージ選択", key_name: "title", point_y: point_y1)
        setCenterText("300点以上で次のステージ解放", key_name: "title", point_y: point_y2)
//        setCenterButton("オープニング", key_name: "opening", point_y: point_y3)
        stageBox("1章　はしれ、かっぱ", key: "stage1", point_y:  point_y4)
        stageBox("2章　見切れ、かっぱ", key: "stage2", point_y:  point_y5)
        stageBox("3章　まもれ、かっぱ", key: "stage3", point_y:  point_y6)
        stageBox("4章　逃げろ、かっぱ", key: "stage4", point_y:  point_y7)
        stageBox("5章　たおせ、かっぱ", key: "stage5", point_y:  point_y8)
        if CommonData.getDataByInt("stage6_flag") == 1 {
            setCenterButton("エンディング", key_name: "ending", point_y: point_y8)
        }
    }
    
    func stageBox(title: String, key: String, point_y: CGFloat){
        if CommonData.getDataByInt("\(key)_flag") == 1 || key == "stage1" {
            setCenterButton(title, key_name: key, point_y: point_y)
        } else {
            setCenterText("???", key_name: "no", point_y: point_y)
        }
    }
    
    
    override func checkTochEvent(name: String) {
        switch name {
        case "opening":
            print("opening")
        case "stage1":
            goStage1Scene()
        case "stage2":
            goStage2Scene()
        case "stage3":
            goStage3Scene()
        case "stage4":
            goStage4Scene()
        case "stage5":
            goStage5Scene()
        case "ending":
        print("ending")
        default:
            return
        }
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
    func goStage1Scene(){
        let secondScene = Stage1Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    func goStage2Scene(){
        let secondScene = Stage2Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    func goStage3Scene(){
        let secondScene = Stage3Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    func goStage4Scene(){
        let secondScene = Stage4Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    func goStage5Scene(){
        let secondScene = Stage5Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    func goRule(){
        let secondScene = RuleScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
        
    }
}
