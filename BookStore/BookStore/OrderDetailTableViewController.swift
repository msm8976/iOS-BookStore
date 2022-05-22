//
//  OrderDetailTableViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/21.
//

import UIKit

class OrderDetailTableViewController: UITableViewController {
    
    var orderbooklist:[bookInfo]=[]
    var orderbookidlist:[String]=[]
    var needReload:Bool=true

    override func viewDidLoad() {
        super.viewDidLoad()
        orderbooklist=bookList.booklist.filter({
            for id in orderbookidlist{
                if $0.id == id{
                    return true
                }
            }
            return false
        })
        let xib = UINib(nibName: "ListCellTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "cell4")
        tableView.rowHeight = 160
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderbooklist.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! ListCellTableViewCell
        cell.imageView?.downloadAsyncFrom(url: orderbooklist[indexPath.row].pic)
        cell.cellName.text=orderbooklist[indexPath.row].title
        cell.cellPrice.text=orderbooklist[indexPath.row].price
        if indexPath.row==orderbookidlist.count-1 && needReload{
            needReload=false
            tableView.reloadData()
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookinfovc=segue.destination as? BookInfoViewController else {return}
        let indexPath=tableView.indexPathForSelectedRow
        bookinfovc.bookinfo=orderbooklist[indexPath!.row]
        bookinfovc.hideAddCart=true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showorderbookinfo", sender: self)
    }

}
