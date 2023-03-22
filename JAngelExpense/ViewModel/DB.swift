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
            let createtableUserQuery = "CREATE TABLE IF NOT EXISTS Users (IdUser INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT)"
            let createtableTipo = "CREATE TABLE IF NOT EXISTS Tipo (IdTipoBalance INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, NameTipo TEXT)"
            let createtableCategoriasQuery = "CREATE TABLE IF NOT EXISTS Categorias (IdCategoria INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, NameCategoria TEXT)"
            let createtablesubCategoriesQuery = "CREATE TABLE IF NOT EXISTS SubCategoria (IdSubcategoria INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, NameSubcategoria TEXT, IdCategoria INTEGER, FOREIGN KEY (IdCategoria) references Categorias(IdCategoria))"
            let createtablebalanceQuery = "CREATE TABLE IF NOT EXISTS Balance (IdBalance INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Name TEXT, Cantidad Double, IdTipo INTEGER, IdSubcategoria INTEGER, IdUsuario INTEGER, Fecha TEXT, FOREIGN KEY (IdTipo) REFERENCES Tipo(IdTipoBalance), FOREIGN KEY (IdSubcategoria) REFERENCES SubCategoria(IdSubcategoria))"
            
            if sqlite3_exec(db, createtableUserQuery, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
            if sqlite3_exec(db, createtableTipo, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
            if sqlite3_exec(db, createtableCategoriasQuery, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
            
            if sqlite3_exec(db, createtablesubCategoriesQuery, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
            if sqlite3_exec(db, createtablebalanceQuery, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
            
            
            else{
                print("Everything is fine")
            }
            return db

        }
        else{
            print("Error")
            return nil
        }
      
    }
    
    
}
