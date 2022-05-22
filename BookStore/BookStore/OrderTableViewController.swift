//
//  OrderTableViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var orderinfo:[[String : AnyObject]]=[]
    var tempbookidlist:[String]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 96
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderinfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! OrderCellTableViewCell
        cell.id.text=orderinfo[indexPath.row]["orderid"] as? String
        cell.price.text=orderinfo[indexPath.row]["price"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        cell.time.text=dateFormatter.string(from:Date(timeIntervalSince1970: Double(cell.id.text!)!))
        cell.num.text=orderinfo[indexPath.row]["num"] as? String

            
        // Configure the cell...
        return cell
        
    }

    override func viewWillAppear(_ animated: Bool) {
        orderinfo=UserOrder.getOrder()
        tableView.reloadData()
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        nav!.tabBarItem.badgeValue=String(UserCart.getCart().count)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let orderdetailvc=segue.destination as? OrderDetailTableViewController else {return}
        let indexPath=tableView.indexPathForSelectedRow
        let bookstr=orderinfo[indexPath!.row]["bookls"] as! String
        orderdetailvc.title=orderinfo[indexPath!.row]["orderid"] as? String
        orderdetailvc.orderbookidlist=bookstr.components(separatedBy: " ")
    }


}
