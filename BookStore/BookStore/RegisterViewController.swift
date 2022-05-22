//
//  RegisterViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/4.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserAccount.initDB()
        // Do any additional setup after loading the view.
    }
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var regUserInput: UITextField!
    
    @IBOutlet weak var regPwdInput: UITextField!
    
    @IBOutlet weak var regTint: UILabel!
    

    @IBAction func regOKTapped(_ sender: Any) {
        if UserAccount.isUserExist(username: regUserInput.text!){
            regTint.text = "用户名已存在"
            regTint.textColor = .red
        }else if UserAccount.register(username: regUserInput.text!, password: regPwdInput.text!){
            regTint.text = "注册成功"
            regTint.textColor = .green
            defaults.set(regUserInput.text!,forKey: "username")
            self.navigationController?.popViewController(animated: true)
            //self.dismiss(animated: true, completion: nil)
        }else{
            regTint.text = "注册失败"
            regTint.textColor = .red
        }
    }
    
    @IBAction func regCancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    

}
