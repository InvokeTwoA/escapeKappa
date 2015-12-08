import UIKit
import SpriteKit

class GameViewController: UIViewController,NADViewDelegate  {
    private var nadView: NADView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = TitleScene(size: UIScreen.mainScreen().bounds.size)
        scene.scaleMode = .AspectFill
        let skView = self.view as! SKView
/*
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true
*/
        showAd()
        skView.presentScene(scene)
    }
    
    // How to set the orientation.
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }

    func showAd(){
        nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: CommonConst.adHeight), isAdjustAdSize: true)
        nadView.setNendID(CommonConst.adKey, spotID: CommonConst.adSpot)
        nadView.isOutputLog = false
        nadView.delegate = self
        nadView.load()
        self.view?.addSubview(nadView)
    }
    
    func nadViewDidFinishLoad(adView: NADView!) {
    }
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        self.view = SKView(frame: frame)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    /*
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
