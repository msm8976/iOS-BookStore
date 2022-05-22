//
//  ListTableViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let user:String = UserAccount.user
    var bookdict:[String:[bookInfo]]=[:]
    var bookkind:[String]=[]
    let themeColor = UIColor.init(red: (0 / 255.0), green: (191 / 255.0), blue: (165 / 255.0), alpha: 1);
    var needReload:Bool=true
    
    @IBAction func logoutTapped(_ sender: Any) {
        let loginvc = storyboard?.instantiateViewController(withIdentifier: "loginnav")
        self.view.window?.rootViewController = loginvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for bookinfo in bookList.booklist{
            if bookdict[bookinfo.kind] == nil{
                bookkind.append(bookinfo.kind)
                bookdict[bookinfo.kind]=[]
            }
            bookdict[bookinfo.kind]?.append(bookinfo)
        }
        //print(bookdict)
        let xib = UINib(nibName: "ListCellTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "cell1")
        tableView.rowHeight = 160
        self.tableView.sectionIndexColor = themeColor
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return bookkind.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookdict[bookkind[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return bookkind[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ListCellTableViewCell
        let booklist=bookdict[bookkind[indexPath.section]]!
        cell.imageView!.downloadAsyncFrom(url: booklist[indexPath.row].pic)
        cell.cellName.text=booklist[indexPath.row].title
        cell.cellPrice.text=booklist[indexPath.row].price
        if indexPath.row==booklist.count-1 && needReload{
            needReload=false
            tableView.reloadData()
        }
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return bookkind
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        nav!.tabBarItem.badgeValue=String(UserCart.getCart().count)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookinfovc=segue.destination as? BookInfoViewController else {return}
        let indexPath=tableView.indexPathForSelectedRow
        bookinfovc.bookinfo=bookdict[bookkind[indexPath!.section]]![indexPath!.row]
        bookinfovc.hideAddCart=false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showbookinfo", sender: self)
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        //guard let bookinfovc=segue.source as? BookInfoViewController else {return}
    }
    
}
