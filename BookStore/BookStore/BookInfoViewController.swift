//
//  BookInfoViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/20.
//

import UIKit

class BookInfoViewController: UIViewController {

    @IBOutlet weak var bookPic: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookDescLabel: UILabel!
    @IBOutlet weak var bookPubLabel: UILabel!
    @IBOutlet weak var bookCodeLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var addCartBtn: UIButton!
    
    var bookinfo:bookInfo?
    var bookid:String=""
    var hideAddCart:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(bookinfo)
        bookid=bookinfo!.id
        bookPic.downloadAsyncFrom(url: bookinfo!.pic)
        bookNameLabel.text=bookinfo!.title
        bookAuthorLabel.text=bookinfo!.author
        bookDescLabel.text="介绍："+bookinfo!.desc
        bookPubLabel.text="出版社："+bookinfo!.publisher
        bookCodeLabel.text="书号："+bookinfo!.code
        bookPriceLabel.text=bookinfo!.price
        addCartBtn.isHidden=hideAddCart
    }
    
    @IBAction func addCartTapped(_ sender: Any) {
        var msg:String=""
        if UserCart.isCartExist(bookid: bookid){
            msg="购物车已存在本图书"
        }else if UserCart.addCart(bookid: bookid){
            msg="添加购物车成功"
        }else{
            msg="添加失败"
        }
        let dialog = UIAlertController(title:"提示", message:msg, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title:"确定",style: .default,handler:{(act:UIAlertAction) in self.performSegue(withIdentifier: "addCart", sender: self)}))
        present(dialog, animated:true, completion:nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
