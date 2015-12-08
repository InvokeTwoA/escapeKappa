import SpriteKit
class FireEmitterNode: SKEmitterNode {
    class func makeFire() -> SKEmitterNode {
        let path = NSBundle.mainBundle().pathForResource("fire", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        particle.zPosition = 1
        particle.numParticlesToEmit = 50 // 何個、粒を出すか。
        particle.particleBirthRate = 100 // 一秒間に何個、粒を出すか。
        particle.particleSpeed = 40 // 粒の速度
        particle.xAcceleration = 0
        particle.yAcceleration = 0
        return particle
        
    }
    
}