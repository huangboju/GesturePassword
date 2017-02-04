//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Security

protocol Storagable {

    func setStr(_ value: String, key: String)
    func str(forKey name: String) -> String?
    func removeValue(forKey name: String)
}

struct LockKeychain: Storagable {

    private let keychain: Keychain
    
    init() {
        keychain = Keychain()
    }

    func setStr(_ value: String, key: String) {
        keychain[key] = value
    }

    func str(forKey name: String) -> String? {
        return keychain[name]
    }

    func removeValue(forKey name: String) {
        do {
            try keychain.remove(name)
        } catch let error {
            print(error, "delete failure")
        }
    }
}

struct LockUserDefaults: Storagable {

    private let defaults: UserDefaults
    
    init() {
        defaults = UserDefaults.standard
    }
    
    func setStr(_ value: String, key: String) {
        defaults.set(value, forKey: key)
        //如果程序意外退出数据不会被系统写入到该文件，所以，要使用synchronize()命令直接同步到文件里
        defaults.synchronize()
    }

    func str(forKey name: String) -> String? {
        return defaults.string(forKey: name)
    }

    func removeValue(forKey name: String) {
        defaults.removeObject(forKey: name)
    }

//    func setInt(_ value: Int, key: String) {
//        let defaults = UserDefaults.standard
//        defaults.set(value, forKey: key)
//        defaults.synchronize()
//    }
//
//    func int(forKey name: String) -> Int {
//        return UserDefaults.standard.integer(forKey: name)
//    }
//
//    func setFloat(_ value: Float, key: String) {
//        let defaults = UserDefaults.standard
//        defaults.set(value, forKey: key)
//        defaults.synchronize()
//    }
//
//    func float(forKey name: String) -> Float {
//        return UserDefaults.standard.float(forKey: name)
//    }
//
//    func setBool(_ value: Bool, key: String) {
//        let defaults = UserDefaults.standard
//        defaults.set(value, forKey: key)
//        defaults.synchronize()
//    }
//
//    func bool(forKey name: String) -> Bool {
//        return UserDefaults.standard.bool(forKey: name)
//    }

    //MARK: - 归档
//    func archiveRoot(_ object: AnyObject, toFile path: String) -> Bool {
//        return NSKeyedArchiver.archiveRootObject(object, toFile: path)
//    }
//
//    func removeRootObjectWithFile(_ path: String) -> Bool {
//        return archiveRoot("" as AnyObject, toFile: path)
//    }
//
//    func unarchiveObjectWithFile(_ path: String) -> AnyObject? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as AnyObject?
//    }
}
