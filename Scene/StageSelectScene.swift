import SpriteKit
class StageSelectScene: BaseScene {
    let _page : Int = CommonData.getDataByInt("map_page")
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
        if _page == 0 {
            stageBox("１章　はしれ、かっぱ", key: "stage1", point_y:  point_y3)
            stageBox("２章　見切れ、かっぱ", key: "stage2", point_y:  point_y4)
            stageBox("３章　まもれ、かっぱ", key: "stage3", point_y:  point_y5)
            stageBox("４章　逃げろ、かっぱ", key: "stage4", point_y:  point_y6)
            stageBox("終章　たおせ、かっぱ", key: "stage5", point_y:  point_y7)
            setCenterButton("外伝へ", key_name: "next", point_y: point_y8)
        } else {
            setCenterButton("裏面１ 重力世界のかっぱ", key_name: "stage6", point_y: point_y3)
            setCenterButton("裏面２ 絶体絶命のかっぱ", key_name: "stage7", point_y: point_y4)
            setCenterButton("前のステージへ", key_name: "back", point_y: point_y8)
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
        case "stage1":
            goStage1()
        case "stage2":
            goStage2Scene()
        case "stage3":
            goStage3Scene()
        case "stage4":
            goStage4Scene()
        case "stage5":
            goStage5Scene()
        case "stage6":
            goStage6Scene()
        case "stage7":
            goStage7Scene()
        case "next":
            CommonData.setData("map_page", value: 1)
            reloadScene()
        case "back":
            CommonData.setData("map_page", value: 0)
            reloadScene()
        default:
            return
        }
    }
    
    func reloadScene(){
        let secondScene = StageSelectScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func goStage1(){
        if CommonData.getDataByInt("high_score_stage1") == 0 {
            let alert: UIAlertController = UIAlertController(title:"ステージ１説明",
                message: "iPhoneを傾ければカッパがその方向に動きます。\n\n炎をよけながら、敵に体当たりをして点数を稼ぎましょう。\n\nHPが減ったら薬に触れれば回復ができます。",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            let yesAction: UIAlertAction = UIAlertAction(title: "OK",
                style: UIAlertActionStyle.Default,
                handler:{
                    (action:UIAlertAction) -> Void in
                    self.goStage1Scene()
            })
            alert.addAction(yesAction)
            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        } else {
            goStage1Scene()
        }
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
    func goStage6Scene(){
        let secondScene = Stage6Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    func goStage7Scene(){
        let secondScene = Stage7Scene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    
}
