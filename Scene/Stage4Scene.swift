import SpriteKit
class Stage4Scene: GameScene {
    
    override func checkScore(){
        if _score >= CommonConst.clearScore {
            CommonData.setData("stage5_flag", value: 1)
        }
    }
    
    override func setStageValue() {
        _stage = 4
        _maxhp = 60
        _hp = 60
        changeLifeBar()
        changeLifeLabel()
    }
    
    override func lvHeal(){
        heal(1, point: _kappa.position)
    }
        
    override func removeFire(){
        _score += CommonUtil.rnd(2) + 1
        updateScore()
    }
    
    override func isMaxEnemy(enemy_num : Int) -> Bool {
        if _lv < 15 && enemy_num > 3 {
            return true
        } else if _lv < 30 && enemy_num > 4 {
            return true
        } else if _lv < 45 && enemy_num > 5 {
            return true
        } else if _lv < 60 && enemy_num > 6 {
            return true
        } else if enemy_num > 7 {
            return true
        }
        return false
    }
    
    override func chaseObjectType() -> String{
        return "fire"
    }
}
