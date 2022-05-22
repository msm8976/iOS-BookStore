//
//  UserCart.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/20.
//

import Foundation

class UserCart{
    static var user:String="default"
    
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        user=UserAccount.user
        print(user)
        let createSql = "CREATE TABLE IF NOT EXISTS UserCart('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,'username' TEXT , 'bookid' TEXT);"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return}
        sqlite.closeDB()
    }
    
    static func addCart(bookid:String)->Bool{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return false}
        let createSql = "INSERT INTO UserCart(username,bookid) VALUES('"+user+"','"+bookid+"');"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return false}
        sqlite.closeDB()
        return true
    }
    
    static func delCart(bookid:String)->Bool{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return false}
        let deleteSql = "DELETE FROM UserCart WHERE bookid='"+bookid+"';"
        if !sqlite.execNoneQuerySQL(sql:deleteSql){sqlite.closeDB();return false}
        sqlite.closeDB()
        return true
    }
    
    static func delUserCart(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        let deleteSql = "DELETE FROM UserCart WHERE username='"+user+"';"
        if !sqlite.execNoneQuerySQL(sql:deleteSql){sqlite.closeDB();return}
        sqlite.closeDB()
    }
    
    static func isCartExist(bookid:String)->Bool{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return false}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserCart WHERE username='"+user+"' AND bookid='"+bookid+"';")
        sqlite.closeDB()
        return queryResult!.count==1
    }
    
    static func getCart()->[String]{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return []}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserCart WHERE username='"+user+"';")
        sqlite.closeDB()
        var idlist:[String]=[]
        for qr in queryResult!{
            idlist.append(qr["bookid"] as! String)
        }
        return idlist
    }
    
    static func clean() -> Bool
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return false}
        let clean = "DELETE FROM UserCart;"
        if !sqlite.execNoneQuerySQL(sql:clean){sqlite.closeDB();return false}
        sqlite.closeDB()
        return true
    }
    
    static func show() -> [[String : AnyObject]]?
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return nil}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserCart;")
        sqlite.closeDB()
        return queryResult!
    }
    
    static func drop(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        let drop = "DROP TABLE UserCart;"
        if !sqlite.execNoneQuerySQL(sql:drop){sqlite.closeDB();return}
        sqlite.closeDB()
        return
    }
}
