//
//  UserAccount.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/4.
//

import Foundation

class UserAccount{
    static var user:String="default"
    
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        let createSql = "CREATE TABLE IF NOT EXISTS UserAccount('username' TEXT NOT NULL PRIMARY KEY , 'password' TEXT);"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return}
        sqlite.closeDB()
    }
    
    static func isUserExist(username:String)->Bool{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return false}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserAccount WHERE username='"+username+"';")
        sqlite.closeDB()
        return queryResult!.count==1
    }
    
    static func register(username:String,password:String) -> Bool
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return false}
        let createSql = "INSERT INTO UserAccount(username,password) VALUES('"+username+"','"+password+"');"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return false}
        sqlite.closeDB()
        return true
    }
    
    static func login(username:String,password:String) -> Bool
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return false}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserAccount WHERE username='"+username+"' AND password='"+password+"';")
        sqlite.closeDB()
        return queryResult!.count==1
    }
    
    static func clean() -> Bool
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return false}
        let clean = "DELETE FROM UserAccount"
        if !sqlite.execNoneQuerySQL(sql:clean){sqlite.closeDB();return false}
        sqlite.closeDB()
        return true
    }
    
    static func show() -> [[String : AnyObject]]?
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return nil}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM UserAccount;")
        sqlite.closeDB()
        return queryResult
    }
    
    static func drop(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        let drop = "DROP TABLE UserAccount;"
        if !sqlite.execNoneQuerySQL(sql:drop){sqlite.closeDB();return}
        sqlite.closeDB()
        return
    }

}
