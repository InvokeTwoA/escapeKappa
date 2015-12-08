//ゲームオーバー画面
import SpriteKit
import Social
import GameKit
class GameOverScene: GameBaseScene {
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
        setCenterText("残念！　君の冒険は", key_name: "text1", point_y: y1)
        setCenterText("ここで終わってしまった。", key_name: "text1", point_y: y2)
        setCenterText("ステージ\(_stage)", key_name: "text1", point_y: y3)
        setCenterText("SCORE: \(_score)", key_name: "text1", point_y: y4)
        
        // ステータスによって文言変更
        _score_text_y1 = y5
        _score_text_y2 = y6
        _score_text_y3 = y7
        displayScoreText()
        
        // ハイスコア送信
        reportScore()
        
        setCenterButton("ランキングを見る", key_name: "high_score", point_y: y8)
        setCenterButton("もう一回挑戦する", key_name: "retry", point_y: y9)
        setCenterButton("タイトルに戻る", key_name: "back", point_y: y10)
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            let nextScene = TitleScene(size: self.frame.size)
            let tr = SKTransition.flipHorizontalWithDuration(1)
            changeScene(nextScene, tr: tr)
        } else if name == "retry" {
            retryStage()
        } else if name == "high_score" {
            showLeaderboardScore()
        }
    }
    
    func retryStage(){
        let tr = SKTransition.flipHorizontalWithDuration(1)
        switch _stage {
        case 1:
            changeScene(Stage1Scene(size: self.frame.size), tr: tr)
        case 2:
            changeScene(Stage2Scene(size: self.frame.size), tr: tr)
        case 3:
            changeScene(Stage3Scene(size: self.frame.size), tr: tr)
        case 4:
            changeScene(Stage4Scene(size: self.frame.size), tr: tr)
        case 5:
            changeScene(Stage5Scene(size: self.frame.size), tr: tr)
        case 6:
            changeScene(Stage6Scene(size: self.frame.size), tr: tr)
        case 7:
            changeScene(Stage7Scene(size: self.frame.size), tr: tr)

        default:
            print("stage=\(_stage)")
            changeScene(TitleScene(size: self.frame.size), tr: tr)
        }
    }
    
    func displayScoreText(){
        switch _score {
        case 0 ..< 50:
            _nickname = "評価：　初心者勇者"
            outputText("薬を飲んでHPを回復しよう", text2: "炎は絶対に避けること！")
        case 50 ..< 150:
            _nickname = "評価：　まあまあ勇者"
            outputText("この調子で頑張れば", text2: "モテモテになること間違いなし")
        case 150 ..< 300:
            _nickname = "評価：　けっこう勇者"
            outputText("ちょっとモテてきた", text2: "バレンタインが楽しみだ")
        case 300 ..< 500:
            _nickname = "評価：　かなり勇者"
            outputText("飲み会によく呼ばれる", text2: "人気者のカッパ")
        case 500 ..< 700:
            _nickname = "評価：　もはや勇者"
            outputText("その気になれば", text2: "魔王も倒す自信あり")
        case 700 ..< 1000:
            _nickname = "評価：　絶対に勇者"
            outputText("人からサインを求められる", text2: "外出時はサングラス必須")
        case 1000 ..< 1400:
            _nickname = "評価：　絶対に勇者"
            outputText("勇者といえばカッパ", text2: "カッパと言えば勇者")
        case 1400 ..< 2000:
            _nickname = "評価：　真の勇者"
            outputText("こんな偉業", text2: "なかなかできる事じゃないよ")
        case 2000 ..< 3000:
            _nickname = "評価：　伝説の勇者"
            outputText("結婚したい勇者ナンバー１", text2: "イケメンといえば君のことだ")
        default:
            _nickname = "評価：　究極の勇者"
            outputText("魔王も泣いて逃げ出す", text2: "君こそナンバーワンだ！")
        }
    }
    
    func outputText(text1: String, text2: String){
        setCenterText(_nickname, key_name: "text1", point_y: _score_text_y1)
        setCenterText(text1, key_name: "text1", point_y: _score_text_y2)
        setCenterText(text2, key_name: "text1", point_y: _score_text_y3)
    }
    
    

}
