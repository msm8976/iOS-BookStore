//
//  CartTableViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var idlist:[String]=[]
    var infodict:[String:[String:String]]=[:]
    var sumprice:Float=0
    @IBOutlet weak var priceBtn: UIBarButtonItem!
    
    @IBAction func payTapped(_ sender: Any) {
        if idlist.count != 0{
            let dialog = UIAlertController(title:"提示", message:"是否确认支付本订单", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            dialog.addAction(UIAlertAction(title: "支付", style: .default, handler: {(act:UIAlertAction) in self.performSegue(withIdentifier: "pay", sender: self)}))
            present(dialog, animated:true, completion:nil)
        }else{
            let dialog = UIAlertController(title:"提示", message:"购物车中不存在商品", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            present(dialog, animated:true, completion:nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserCart.getCart().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text=infodict[idlist[indexPath.row]]?["title"]
        cell.detailTextLabel?.text=infodict[idlist[indexPath.row]]?["author"]
        sumprice+=(Float((infodict[idlist[indexPath.row]]?["price"])!)!)
        // Configure the cell...

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sumprice=0
        idlist=UserCart.getCart()
        for id in idlist{
            infodict[id]=bookList.getBookInfoById(id: id) as? [String:String]
        }
        tableView.reloadData()
        self.navigationController?.tabBarItem.badgeValue=String(idlist.count)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.02) {
            self.priceBtn.title="总价："+String(Float(lroundf(10*self.sumprice))/10.0)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if UserCart.delCart(bookid:idlist[indexPath.row]){
                tableView.deleteRows(at: [indexPath], with: .fade)
                viewWillAppear(true)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let payvc=segue.destination as? PaySuccessViewController else {return}
        payvc.orderid=UserOrder.addOrder(bookls: idlist,price: String(Float(lroundf(10*sumprice))/10.0))
        payvc.booknum=idlist.count
        payvc.sumprice=String(Float(lroundf(10*sumprice))/10.0)
        UserCart.delUserCart()
    }

}
