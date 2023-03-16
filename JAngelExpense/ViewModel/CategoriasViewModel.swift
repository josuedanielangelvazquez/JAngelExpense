//
//  Categorias.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 15/03/23.
//

import Foundation
import SQLite3
class  CategoriasViewModel{
    
    func getallSubcategorias()->Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdSubcategoria, NameSubcategoria, IdCategoria FROM SubCategoria"
        var statement : OpaquePointer? = nil
        do{
                   if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                       result.Objects = []
                       while sqlite3_step(statement) == SQLITE_ROW{
                          
                          var subcategorias = SubCategorias(IdSubcategorias: 0, nameSubCategoria: "", idCategorias: categorias(IdCategorias: 0, NameCategorias: ""))
                           subcategorias.IdSubcategorias = Int(sqlite3_column_int(statement, 0))
                           subcategorias.nameSubCategoria = String(cString: sqlite3_column_text(statement, 1))
                           subcategorias.idCategorias.IdCategorias = Int(sqlite3_column_int(statement, 2))
                         
                           result.Objects?.append(subcategorias)
                       }
                       result.Correct = true
                       
                   }
                 
               }  catch let error {
                   result.Correct = false
                   result.Ex = error
                   result.ErrorMessage = error.localizedDescription
               }
      
        return result
    }
    
    func getbyNombre(nombrecategoria: String)->Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdSubcategoria, NameSubcategoria, IdCategoria FROM SubCategoria WHERE NameSubcategoria LIKE LTRIM(RTRIM('\(nombrecategoria)')||'%')"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db
                                      , query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var subcategorias = SubCategorias(IdSubcategorias: 0, nameSubCategoria: "", idCategorias: categorias(IdCategorias: 0, NameCategorias: ""))
                     subcategorias.IdSubcategorias = Int(sqlite3_column_int(statement, 0))
                     subcategorias.nameSubCategoria = String(cString: sqlite3_column_text(statement, 1))
                     subcategorias.idCategorias.IdCategorias = Int(sqlite3_column_int(statement, 2))
                   
                     result.Objects?.append(subcategorias)
                }
                result.Correct = true
            }
        }
        catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    func getall()->Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdCategoria, NameCategoria FROM Categorias"
        var statement : OpaquePointer? = nil
        do{
                   if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                       result.Objects = []
                       while sqlite3_step(statement) == SQLITE_ROW{
                          
                          var categorias = categorias(IdCategorias: 0, NameCategorias: "")
                           categorias.IdCategorias = Int(sqlite3_column_int(statement, 0))
                           categorias.NameCategorias = String(cString: sqlite3_column_text(statement, 1))
                         
                           result.Objects?.append(categorias)
                       }
                       result.Correct = true
                       
                   }
                 
               }  catch let error {
                   result.Correct = false
                   result.Ex = error
                   result.ErrorMessage = error.localizedDescription
               }
        return result
        
    }
    
}
