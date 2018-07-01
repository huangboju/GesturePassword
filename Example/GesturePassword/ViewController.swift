//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class ViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let data: [String] = [
        "设置密码",
        "验证密码",
        "修改密码",
        ]
    
    let operationDict = [
        "设置密码": "setPassword",
        "验证密码": "verifyPassword",
        "修改密码": "modifyPassword",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "手势密码"
        view.addSubview(tableView)
    }
    
    @objc func setPassword() {
        AppLock.set(controller: self)
    }
    
    @objc func verifyPassword() {
        AppLock.verify(controller: self)
        //        AppLock.verify(controller: self, success: { _ in
        //            print("验证成功")
        //        }, forget: { _ in
        //            print("忘记密码")
        //            self.navigationItem.prompt = "忘记密码"
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
        //                self.navigationItem.prompt = nil
        //            })
        //        }, overrunTimes: { _ in
        //            print("次数超限")
        //        })
    }
    
    @objc func modifyPassword() {
        AppLock.modify(controller: self)
        //        AppLock.modify(controller: self, success: { _ in
        //            print("success")
        //        }, forget: { _ in
        //            print("forget")
        //        })
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let operationName = operationDict[data[indexPath.row]] else {
            return
        }
        perform(Selector(operationName))
    }
}
