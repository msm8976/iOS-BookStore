//
//  PaySuccessViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/21.
//

import UIKit

class PaySuccessViewController: UIViewController {
    
    var orderid=""
    var booknum=0
    var sumprice=""

    override func viewDidLoad() {
        super.viewDidLoad()
        orderID.text=orderid
        bookNum.text=String(booknum)
        sumPrice.text=sumprice
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日\nHH:mm:ss"
        payTime.text=dateFormatter.string(from:Date(timeIntervalSince1970: Double(orderid)!))
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var bookNum: UILabel!
    @IBOutlet weak var sumPrice: UILabel!
    @IBOutlet weak var payTime: UILabel!
    
    
    @IBAction func OKTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
