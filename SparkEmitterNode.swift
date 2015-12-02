import SpriteKit

class SparkEmitterNode: SKEmitterNode {
    
    class func makeSpark() -> SKEmitterNode {
        let path = NSBundle.mainBundle().pathForResource("spark", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        particle.zPosition = 1
        particle.numParticlesToEmit = 100 // 何個、粒を出すか。
        particle.particleBirthRate = 200 // 一秒間に何個、粒を出すか。
        particle.particleSpeed = 80 // 粒の速度
        particle.xAcceleration = 0
        particle.yAcceleration = 0 // 加速度を0にすることで、重力がないようになる。
        return particle
    }
}