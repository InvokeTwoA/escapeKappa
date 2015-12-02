import SpriteKit
class OptionScene: BaseScene {
    let _defaultSpeed : Int = CommonConst.defaultSpeed
    override func didMoveToView(view: SKView) {
        setKappa()
        setWorld()
        setDx()
        setMotion()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.adHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight * 3)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight * 3)
        
        if CommonData.getDataByInt("music_off") == 0 {
            setCenterButton("プレイ中の音楽をオフにする", key_name: "music_off", point_y: point_y1)
        } else {
            setCenterButton("プレイ中の音楽をオンにする", key_name: "music_on", point_y: point_y1)
        }
        setCenterText("音楽　(C)PANICPUMPKIN", key_name: "copyright", point_y: point_y2)
        
        var dx = CommonData.getDataByInt("dx")
        if dx == 0 {
            dx = _defaultSpeed
        }
        setCenterText("カッパの速度: \(dx)", key_name: "speed", point_y: point_y3)
        setCenterButton("速度を変更する", key_name: "change_speed", point_y: point_y4)
        setCenterButton("初期設定に戻す", key_name: "reset", point_y: point_y5)

        setBackButton("タイトルに戻る")
    }
    
    override func checkTochEvent(name: String) {
        switch name {
        case "music_on":
            CommonData.setData("music_off", value: 0)
            reloadScene()
        case "music_off":
            CommonData.setData("music_off", value: 1)
            reloadScene()
        case "change_speed":
            changeSpeed()
        case "reset":
            reset()
            reloadScene()
        case "back":
            goTitleScene()
        default:
            return
        }
    }
    
    func changeSpeed(){
        let alert: UIAlertController = UIAlertController(title:"希望するカッパの速度を入力してください",
            message: "※数値が高いほどカッパは速くなります。\n可能範囲は \(CommonConst.minSpeed)~\(CommonConst.maxSpeed)\n数値以外の入力の場合は\(_defaultSpeed)になります。\n\n初期値\(_defaultSpeed)",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "設定完了",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                // 入力したテキストを保存
                let textField = alert.textFields![0]
                
                let input : Int? = Int(textField.text!)
                if(input < CommonConst.minSpeed || input > CommonConst.maxSpeed){
                    CommonData.setData("dx", value: self._defaultSpeed)
                } else {
                    CommonData.setData("dx", value: input!)
                }
                self.reloadScene()
        })
        alert.addAction(yesAction)
        // UIAlertControllerにtextFieldを追加
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
        }
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func reset(){
        CommonData.setData("music_off", value: 0)
        CommonData.setData("dx", value: _defaultSpeed)
    }
    
    func reloadScene(){
        let secondScene = OptionScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    // タイトル画面へ
    func goTitleScene(){
        let secondScene = TitleScene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
        // 加速度の処理
        if let accelerometerData = motionManager.accelerometerData {
            setVelocity(accelerometerData.acceleration.x, y: accelerometerData.acceleration.y)
        }
    }
}
