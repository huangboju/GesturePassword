//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Security

protocol Storagable {

    func set(_ value: String, forKey key: String)

    func str(forKey key: String) -> String?
    
    func set(_ value: Int, forKey key: String)

    func integer(forKey key: String) -> Int

    func removeValue(forKey key: String)
}

struct LockKeychain: Storagable {

    private let keychain: Keychain

    init() {
        keychain = Keychain()
    }
    
    func set(_ value: String, forKey key: String) {
        keychain[key] = value
    }

    func str(forKey key: String) -> String? {
        return keychain[key]
    }
    
    func set(_ value: Int, forKey key: String) {
        keychain[key] = value.description
    }
    
    func integer(forKey key: String) -> Int {
        return  Int(keychain[key] ?? "0") ?? 0
    }

    func removeValue(forKey key: String) {
        do {
            try keychain.remove(key)
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

    func set(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
        // 如果程序意外退出数据不会被系统写入到该文件，所以，要使用synchronize()命令直接同步到文件里
        defaults.synchronize()
    }

    func str(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    func set(_ value: Int, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func integer(forKey key: String) -> Int {
        return  defaults.integer(forKey: key)
    }

    func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
