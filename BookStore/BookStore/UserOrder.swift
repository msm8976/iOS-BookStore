//
//  UserOrder.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/21.
//

import Foundation

class UserOrder{
    static var user:String="default"
    
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        user=UserAccount.user
        let createSql = "CREATE TABLE IF NOT EXISTS UserOrder('orderid' TEXT NOT NULL PRIMARY KEY ,'username' TEXT , 'bookls' TEXT , 'price' TEXT , 'num' TEXT);"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return}
        sqlite.closeDB()
    }
    
    static func addOrder(bookls:[String],price:String)->String{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return ""}
        let orderid:String=String(Int(Date().timeIntervalSince1970))
        let value=orderid+"','"+user+"','"+bookls.joined(separator: " ")+"','"+price+"','"+String(bookls.count)
        let createSql = "INSERT INTO UserOrder(orderid,username,bookls,price,num) VALUES('"+value+"');"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return ""}
        sqlite.closeDB()
        return orderid
    }
    
    static func getOrder()->[[String : AnyObject]]{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return []}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserOrder WHERE username='"+user+"';")
        sqlite.closeDB()
        return queryResult!
    }
    
    static func clean() -> Bool
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return false}
        let clean = "DELETE FROM UserOrder;"
        if !sqlite.execNoneQuerySQL(sql:clean){sqlite.closeDB();return false}
        sqlite.closeDB()
        return true
    }
    
    static func show() -> [[String : AnyObject]]?
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return nil}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserOrder;")
        sqlite.closeDB()
        return queryResult!
    }
    
    static func drop(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        let drop = "DROP TABLE UserOrder;"
        if !sqlite.execNoneQuerySQL(sql:drop){sqlite.closeDB();return}
        sqlite.closeDB()
        return
    }
}
