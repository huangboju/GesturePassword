//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

struct LockArchive {
    static func setStr(_ value: String?, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    static func str(forKey name: String) -> String? {
        return UserDefaults.standard.string(forKey: name)
    }

    static func removeValue(forKey name: String) {
        setStr(nil, key: name)
    }

    static func setInt(_ value: Int, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    static func int(forKey name: String) -> Int {
        return UserDefaults.standard.integer(forKey: name)
    }

    static func setFloat(_ value: Float, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        //如果程序意外退出数据不会被系统写入到该文件，所以，要使用synchronize()命令直接同步到文件里
        defaults.synchronize()
    }

    static func float(forKey name: String) -> Float {
        return UserDefaults.standard.float(forKey: name)
    }

    static func setBool(_ value: Bool, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    static func bool(forKey name: String) -> Bool {
        return UserDefaults.standard.bool(forKey: name)
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
