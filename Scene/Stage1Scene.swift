import SpriteKit
class Stage1Scene: GameScene {
    
    override func setStageValue() {
        _stage = 1
    }
    
    override func checkScore(){
        if _score >= CommonConst.clearScore {
            CommonData.setData("stage2_flag", value: 1)
        }
    }

}
