//
//  UIImageViewExtension.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import Foundation

import UIKit

extension UIImageView{
    func downloadAsyncFrom(url:String){
        let urlNet=URL(string: url)
        let task=URLSession.shared.dataTask(with: urlNet!){(data,response,error) in
            if let nsd=data{
                DispatchQueue.main.async {
                    self.image = UIImage(data: nsd, scale: 1)
                    self.contentMode = .scaleAspectFit
                    //UITableView.reload()
                }
            }
        }
        task.resume()
    }
}
