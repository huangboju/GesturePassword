//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

struct LockArchive {
    static func setStr(_ value: String?, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    static func strFor(_ key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    static func removeValueFor(_ key: String) {
        setStr(nil, key: key)
    }

    static func setInt(_ value: Int, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    static func intFor(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }

    static func setFloat(_ value: Float, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        //如果程序意外退出数据不会被系统写入到该文件，所以，要使用synchronize()命令直接同步到文件里
        defaults.synchronize()
    }

    static func floatFor(_ key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }

    static func setBool(_ value: Bool, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    static func boolFor(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

    //MARK: - 归档
    static func archiveRoot(_ object: AnyObject, toFile path: String) -> Bool {
        return NSKeyedArchiver.archiveRootObject(object, toFile: path)
    }

    static func removeRootObjectWithFile(_ path: String) -> Bool {
        return archiveRoot("" as AnyObject, toFile: path)
    }

    func unarchiveObjectWithFile(_ path: String) -> AnyObject? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as AnyObject?
    }
}
