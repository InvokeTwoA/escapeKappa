/*
* 共通のUIなどを実装するクラス
*/

import Foundation
import SpriteKit

class CommonUI {

    class func normalText(text: String, name: String, point: CGPoint) -> SKLabelNode {
        // ボタン
        let label : SKLabelNode = SKLabelNode(fontNamed:CommonConst.font_bold)
//        let label = SKLabelNode(fontNamed:"Chalkduster")
        label.text = text
        label.fontSize = 18
        label.position = point;
        label.fontColor = UIColor.whiteColor()
        label.name = name
        return label
    }

    class func bigText(text: String, name: String, point: CGPoint) -> SKLabelNode {
        // ボタン
        let label : SKLabelNode = SKLabelNode(fontNamed:CommonConst.font_bold)
        label.text = text
        label.fontSize = 32
        label.position = point;
        label.fontColor = UIColor.whiteColor()
        label.name = name
        return label
    }
    
    /*
    * ボタンを返す関数。背景色は白で、文字色は黒。表示する文字数が多いと横幅が増える
    * text: ボタンに表示する文字列
    * name: タグ名。イベントの検出に使われる
    * point: 座標
    */
    class func normalButton(text: String, name: String, point: CGPoint) -> SKSpriteNode {
        var size : CGSize
        let width : CGFloat
        let height : CGFloat = 30
        //print("文字の長さは \(text.utf16Count)\n")
        if text.utf16.count <= 5 {
            width = 100
        } else {
            // 1文字16と考えて、文字超過分の幅を増やす
            width = CGFloat(100+(text.utf16.count-5)*16)
        }
        size = CGSizeMake(width, 30)
        
        // ボタン枠組み（背景）
        let background : SKSpriteNode = SKSpriteNode(color: UIColor.whiteColor(), size: size)
        background.position = point
        background.zPosition = 100
        background.name = name
        
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(width, height))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = worldCategory
        physic.collisionBitMask = 0
        physic.linearDamping = 0
        physic.friction = 0
        background.physicsBody = physic
        
        // ボタン
        let button : SKLabelNode = SKLabelNode(fontNamed:CommonConst.font_regular)
        button.text = text
        button.fontSize = 18
        button.position = CGPointMake(0, -button.frame.size.height/2+3);
        button.fontColor = UIColor.blackColor()
        button.name = name
        
        background.addChild(button)
        return background
    }
}

