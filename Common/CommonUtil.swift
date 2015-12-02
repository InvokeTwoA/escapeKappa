/*
* 便利な関数
*/
import Foundation
import SpriteKit
class CommonUtil {
    // 0 から max までの乱数
    class func rnd(max : Int) -> Int {
        if(max <= 0){
            return 0
        }
        let rand = Int(arc4random_uniform(UInt32(max)))
        return rand
    }
    
    // スクリーンショットを取得
    class func screenShot(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenShot
    }
    
    /* 使用メモリを出力 */
    class func report_memory() {
        var info = task_basic_info()
        var count = mach_msg_type_number_t(sizeofValue(info))/4
        let kerr: kern_return_t = withUnsafeMutablePointer(&info) {
            
            task_info(mach_task_self_,
                task_flavor_t(TASK_BASIC_INFO),
                task_info_t($0),
                &count)
            
        }
        if kerr == KERN_SUCCESS {
            print("Memory in use (in bytes): \(info.resident_size)")
        }
        else {
            print("Error with task_info(): " +
                (String.fromCString(mach_error_string(kerr)) ?? "unknown error"))
        }
    }
}