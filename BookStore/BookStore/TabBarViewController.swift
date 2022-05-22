//
//  TabBarViewController.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import UIKit

class TabBarViewController: UITabBarController {
    let themeColor = UIColor.init(red: (0 / 255.0), green: (191 / 255.0), blue: (165 / 255.0), alpha: 1);
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = themeColor
        // Do any additional setup after loading the view.
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
