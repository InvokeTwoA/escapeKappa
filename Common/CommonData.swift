/*
* CommonData.swift
* データの保存、取得などを行うクラス
* データは UserDefault に保存
*/
import Foundation
class CommonData {
    
    class func setData(key: String, value: NSObject) {
        //print("set data. key = \(key). value = \(value) \n")
        let user_default = NSUserDefaults.standardUserDefaults()
        user_default.setObject(value, forKey: key)
        
        // キーidの値を削除
        // ud.removeObjectForKey("lv")
    }
    
    class func isDataExist(key: String) -> Bool {
        if (NSUserDefaults.standardUserDefaults().objectForKey(key) != nil) {
            return true
        }else {
            return false
        }
    }
    
    class func getDataByInt(key: String) -> Int {
        if isDataExist(key) {
            return NSUserDefaults.standardUserDefaults().integerForKey(key)
        } else {
            return 0
        }
    }
    
    class func getDataByNSTimeInterval(key: String) -> NSTimeInterval {
        if isDataExist(key) {
            return NSUserDefaults.standardUserDefaults().objectForKey(key) as! NSTimeInterval
        } else {
            return 0.0
        }
    }
    
    class func getDataByString(key: String) -> String {
        if isDataExist(key) {
            return NSUserDefaults.standardUserDefaults().stringForKey(key)!
        } else {
            return "";
        }
    }
    
    class func getDataByBool(key: String) -> Bool {
        if isDataExist(key) && getDataByInt(key) == 1 {
            return true
        } else {
            return false
        }
    }
    
    // データをプラスする
    class func plus(key: String, value : Int) {
        let current_data : Int = getDataByInt(key)
        setData(key, value: current_data + value)
    }
    
    // データをマイナスする
    class func minus(key: String, value : Int) {
        let current_data : Int = getDataByInt(key)
        setData(key, value: current_data - value)
    }

}