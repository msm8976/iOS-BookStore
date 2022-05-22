//
//  LoginViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/4.
//

import UIKit

class LoginViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var loginUserInput: UITextField!
    
    @IBOutlet weak var loginPwdInput: UITextField!
    
    @IBOutlet weak var loginTint: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserAccount.initDB()
        loginUserInput.text=defaults.string(forKey: "username")
        bookList.initBookList()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if !UserAccount.isUserExist(username: loginUserInput.text!){
            loginTint.text = "用户不存在"
            loginTint.textColor = .red
            defaults.set("",forKey: "username")
        }else if UserAccount.login(username: loginUserInput.text!, password: loginPwdInput.text!){
            loginTint.text = "登录成功"
            loginTint.textColor = .green
            UserAccount.user=loginUserInput.text!
            bookList.initDB()
            UserCart.initDB()
            UserOrder.initDB()
            defaults.set(loginUserInput.text!,forKey: "username")
            let tabvc = storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
            self.view.window?.rootViewController = tabvc
        }else{
            loginTint.text = "用户名或密码错误"
            loginTint.textColor = .red
            defaults.set(loginUserInput.text!,forKey: "username")
        }
    }
    
}
