//
//  DebugViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/20.
//

import UIKit

class DebugViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserAccount.initDB()
        UserCart.initDB()
        UserOrder.initDB()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func eggTapped(_ sender: Any) {
        print("好难 啊 我有点看不懂 我也是六年级啊\n不过我有亲身体会,这种题目要自己做\n要不然还是会不懂的 要不你去问问老师 父母 或同学")
        
    }
    
    @IBAction func showAccountTapped(_ sender: Any) {
        print(UserAccount.show()!)
    }
    
    @IBAction func clearAccountTapped(_ sender: Any) {
        print(UserAccount.clean())
    }
    
    @IBAction func bookListTapped(_ sender: Any) {
        bookList.initBookList()
        print(bookList.booklist)
    }
    
    @IBAction func showCartTapped(_ sender: Any) {
        print(UserCart.show()!)
    }
    
    @IBAction func cleanCartTapped(_ sender: Any) {
        print(UserCart.clean())
    }
    
    @IBAction func showOrderTapped(_ sender: Any) {
        print(UserOrder.show()!)
    }
    
    @IBAction func cleanOrderTapped(_ sender: Any) {
        print(UserOrder.clean())
    }
    
    @IBAction func dropSqlTapped(_ sender: Any) {
        let dialog = UIAlertController(title:"提示", message:"确定删除所有数据库及表结构吗", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        dialog.addAction(UIAlertAction(title: "确定删除", style: .destructive, handler: {(act:UIAlertAction) in UserOrder.drop();UserCart.drop();UserAccount.drop();print("润了润了")}))
        present(dialog, animated:true, completion:nil)
    }
    
}
