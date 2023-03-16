//
//  DB.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 13/03/23.
//

import Foundation
import SQLite3
class DB{
    let path = "Document.JAngelExpense.sql"
    var  db : OpaquePointer? = nil
    
    init() {
        db = OpenConexion()
    }
    func OpenConexion() -> OpaquePointer? {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
           
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) == SQLITE_OK
        {
            print("Conexion Correcta")
            print( filePath.path())
            return db
            
        }
        else{
            print("Error")
            return nil
        }
      
    }
    
}
