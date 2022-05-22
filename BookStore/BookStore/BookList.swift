//
//  BookList.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import Foundation

class bookInfo:NSObject, Codable
{
    var id:String = ""
    var kind:String = ""
    var title:String = ""
    var author:String = ""
    var publisher:String = ""
    var code:String = ""
    var price:String = ""
    var desc:String = ""
    var pic:String = ""
    
    private enum CodingKeys: String, CodingKey{
        case id
        case kind
        case title
        case author
        case publisher
        case code
        case price
        case desc = "description"
        case pic
    }
    
    override init(){
    }
    
    override var description: String {
        //return "title:\(title) price:\(price)"
        return "\(desc)"
    }
}

class bookListResponse:NSObject, Codable
{
    var code:Int=0
    var result:[bookInfo] = []
    var message:String = ""
   
    private enum CodingKeys: String, CodingKey{
        case code
        case result
        case message
    }
}

class bookList
{
    static let shared:bookList = bookList()

    static var booklist:[bookInfo] = []
    
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        let createSql = "CREATE TABLE IF NOT EXISTS Books('id' TEXT NOT NULL PRIMARY KEY , 'kind' TEXT , 'title' TEXT , 'author' TEXT , 'publisher' TEXT , 'code' TEXT , 'price' TEXT , 'description' TEXT , 'pic' TEXT);"
        if !sqlite.execNoneQuerySQL(sql:createSql){sqlite.closeDB();return}
        if booklist.count==0{
            print("api获取失败，使用本地数据库")
            let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM Books;")
            for qr in queryResult!{
                let data: Data = try! JSONSerialization.data(withJSONObject: qr, options: .fragmentsAllowed)
                let tempbookinfo=try! JSONDecoder().decode(bookInfo.self, from:data)
                booklist.append(tempbookinfo)
            }
            //print(booklist)
            sqlite.closeDB()
            return
        }
        let clean = "DELETE FROM Books"
        if !sqlite.execNoneQuerySQL(sql:clean){sqlite.closeDB();return}
        var insertsql=""
        for bookinfo in booklist{
            insertsql = "INSERT INTO Books(id,kind,title,author,publisher,code,price,description,pic) VALUES('"+bookinfo.id+"','"+bookinfo.kind+"','"+bookinfo.title+"','"+bookinfo.author+"','"+bookinfo.publisher+"','"+bookinfo.code+"','"+bookinfo.price+"','"+bookinfo.description+"','"+bookinfo.pic+"');"
            if !sqlite.execNoneQuerySQL(sql:insertsql){sqlite.closeDB();return}
        }
        sqlite.closeDB()
    }
    
    static func initBookList()
    {
        let url = URL(string: "http://zy.whu.edu.cn/cs/api/book/list")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let booklistresponse = try? JSONDecoder().decode(bookListResponse.self, from:data)
            {
                booklist=booklistresponse.result
                //print(booklist)
            }
        }
        task.resume()
    }
    
    static func getBookInfoById(id:String) -> [String:AnyObject]? {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return nil}
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM Books WHERE id = '"+id+"';")
        sqlite.closeDB()
        return queryResult?[0]
    }
    
}
