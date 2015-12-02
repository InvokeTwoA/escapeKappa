//ゲームオーバー画面
import SpriteKit
import Social
class RuleScene: BaseScene {
    var _score = CommonData.getDataByInt("score")
    var _nickname = "勇者"
    var _page = CommonData.getDataByInt("rule_page")
    override func didMoveToView(view: SKView) {
        let y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.adHeight + CommonConst.textBlankHeight)
        let y2 = y1 - CGFloat(CommonConst.textBlankHeight)
        let y3 = y2 - CGFloat(CommonConst.textBlankHeight)
        let y4 = y3 - CGFloat(CommonConst.textBlankHeight)
        let y5 = y4 - CGFloat(CommonConst.textBlankHeight*2)
        let y6 = y5 - CGFloat(CommonConst.textBlankHeight*2)
        let y7 = y6 - CGFloat(CommonConst.textBlankHeight*2)
        let y8 = y7 - CGFloat(CommonConst.textBlankHeight*2)
        let y9 = y8 - CGFloat(CommonConst.textBlankHeight*2)
        // 共通文言
        if _page == 0 {
            setCenterText("スマホを傾けてカッパを動かそう", key_name: "text1", point_y: y1)
            setCenterText("炎をよけながら、敵に体当たりだ！", key_name: "text1", point_y: y2)
            setCenterText("ピンチになったら薬で回復しよう", key_name: "text1", point_y: y3)
            setPicture("kusuri_32_32", key_name: "pic4", point_y: y4)
            setCenterText("HP + 5", key_name: "text4", point_y: y4)
            setPicture("fire_32_32", key_name: "pic4", point_y: y5)
            setCenterText("HP - 7", key_name: "text4", point_y: y5)
            setPicture("skelton_32_32", key_name: "pic4", point_y: y6)
            setCenterText("score + 1", key_name: "text4", point_y: y6)
            setPicture("miira_32_32", key_name: "pic4", point_y: y7)
            setCenterText("score + 2", key_name: "text4", point_y: y7)
            setPicture("knight_32_32", key_name: "pic4", point_y: y8)
            setCenterText("score + 3", key_name: "text4", point_y: y8)
            setPicture("maou_32_32", key_name: "pic4", point_y: y9)
            setCenterText("score + 5", key_name: "text4", point_y: y9)
        
            setBackButton("ルールその２へ")
        } else {
            setCenterText("たまーにレアアイテムが出現", key_name: "text1", point_y: y1)
            setCenterText("薬はモンスターに触れちゃダメ", key_name: "text1", point_y: y2)
            setCenterText("めざせハイスコア！", key_name: "text1", point_y: y3)
            setPicture("kusuri_yellow_32_32", key_name: "pic4", point_y: y4)
            setCenterText("MAXHP + 1", key_name: "text4", point_y: y4)
            setPicture("metal_slime_32_32", key_name: "pic4", point_y: y5)
            setCenterText("score + 30", key_name: "text4", point_y: y5)
            setCenterText("家が魔物が触れるとHP-1", key_name: "text1", point_y: y6)
            setPicture("house_32_32", key_name: "pic4", point_y: y7)
            setCenterText("HP -1", key_name: "text4", point_y: y7)
            
            setPicture("dragon_32_32", key_name: "pic4", point_y: y8)
            setCenterText("SCORE * 3", key_name: "text4", point_y: y8)

            setBackButton("タイトルに戻る")
        }
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            let tr = SKTransition.flipHorizontalWithDuration(1)
            if _page == 0 {
                CommonData.setData("rule_page", value: 1)
                let nextScene = RuleScene(size: self.frame.size)
                changeScene(nextScene, tr: tr)
            } else {
                CommonData.setData("rule_page", value: 0)
                let nextScene = TitleScene(size: self.frame.size)
                changeScene(nextScene, tr: tr)
            }
        }
    }
    

}
