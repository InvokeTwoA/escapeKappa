import SpriteKit
import Social
import GameKit
class GameBaseScene: BaseScene, GKGameCenterControllerDelegate  {
    func getTotalScore() -> Int {
        var high_score = 0
        for i in 1...7 {
            high_score += CommonData.getDataByInt("high_score_stage\(i)")
        }
        return high_score
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil);
    }

    func showLeaderboardScore() {
        let localPlayer = GKLocalPlayer()
        localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifier : String?, error : NSError?) -> Void in
            if error != nil {
                print("game center show error. \(error!.description)")
            } else {
                let gameCenterController:GKGameCenterViewController = GKGameCenterViewController()
                gameCenterController.gameCenterDelegate = self
                gameCenterController.viewState = GKGameCenterViewControllerState.Leaderboards
                gameCenterController.leaderboardIdentifier = "grp.hashire.kappa"
                self.view?.window?.rootViewController?.presentViewController(gameCenterController, animated: true, completion: nil)
            }
        })
    }
    
    // スコアを送信するGKScoreクラスを生成
    func reportScore() {
        let score = getTotalScore()
        print("send score \(score)")
        let myScore = GKScore(leaderboardIdentifier: "grp.hashire.kappa")
        myScore.value = Int64(score)
        GKScore.reportScores([myScore], withCompletionHandler: { (error) -> Void in
            if error != nil {
                print("game center send error. \(error!.code).\(error!.description)")
            } else {
                print("game center send success")
            }
        })
    }
    
    func reportAchievement(achievementId: String) {
        let myAchievement = GKAchievement(identifier: achievementId)
        myAchievement.percentComplete = 100
        GKAchievement.reportAchievements([myAchievement], withCompletionHandler:
            { (error) -> Void in
                if error != nil {
                    print(error!.code)
                }
        })
    }
}
