//
//  ExpensesViewModel.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 14/03/23.
//

import Foundation
import SQLite3

class ExpensesViewModel{
    
    func Addexpense(expense : Expenses) -> Result{
        
        var result = Result(Correct: false)
        let context = DB.init()
        let query = "Insert INTO Balance( Name, Cantidad, IdTipo, IdSubcategoria, IdUsuario, Fecha) VALUES(?,?,?,?,?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                
                sqlite3_bind_text(statement, 1, (expense.Name as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, Double(expense.cantidad))
                sqlite3_bind_int(statement, 3, Int32(expense.IdTipoBalance))
                sqlite3_bind_int(statement, 4, Int32(expense.IdSubCategorie))
                sqlite3_bind_int(statement, 5, Int32(expense.IdUser))
                sqlite3_bind_text(statement, 6, (expense.fecha as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                }
                else
                {
                    result.Correct = false
                }
            }
        } catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
        
    }
    func getall()->Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdBalance, Name, Cantidad, IdTipo, IdSubcategoria, IdUsuario, Fecha FROM Balance"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    var expenses = Expenses(idValance: 0, Name: "", cantidad: 0.0, IdTipoBalance: 0, IdSubCategorie: 0, IdUser: 0, fecha: "")
                    expenses.idValance = Int(sqlite3_column_int(statement, 0))
                    expenses.Name = String(cString: sqlite3_column_text(statement, 1))
                    expenses.cantidad = Double(sqlite3_column_int(statement, 2))
                    expenses.IdTipoBalance = Int(sqlite3_column_int(statement, 3))
                    expenses.IdSubCategorie = Int(sqlite3_column_int(statement, 4))
                    expenses.IdUser = Int(sqlite3_column_int(statement, 5))
                    expenses.fecha = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Objects?.append(expenses)
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
    
    func getbysubcategory(idSubcategory : Int)->Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdBalance, Name, Cantidad, IdTipo, IdSubcategoria, IdUsuario, Fecha FROM Balance WHERE ((IdSubcategoria = \(idSubcategory)))"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    
                    var expenses = Expenses(idValance: 0, Name: "", cantidad: 0.0, IdTipoBalance: 0, IdSubCategorie: 0, IdUser: 0, fecha: "")
                    expenses.idValance = Int(sqlite3_column_int(statement, 0))
                    expenses.Name = String(cString: sqlite3_column_text(statement, 1))
                    expenses.cantidad = Double(sqlite3_column_int(statement, 2))
                    expenses.IdTipoBalance = Int(sqlite3_column_int(statement, 3))
                    expenses.IdSubCategorie = Int(sqlite3_column_int(statement, 4))
                    expenses.IdUser = Int(sqlite3_column_int(statement, 5))
                    expenses.fecha = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Objects?.append(expenses)
                }
                result.Correct = true
            }
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
    func getbCurrentBalancebycategoria(idSubcategoria : Int, subcategoria : String)->Result{
        var Expense = 0
        var Income = 0
        var idtipo = 0
        var result = Result()
        let context = DB.init()
        let query = "SELECT  IdTipo, Cantidad FROM Balance where (IdSubcategoria = \(idSubcategoria))"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                while sqlite3_step(statement) == SQLITE_ROW{
                    idtipo = Int(sqlite3_column_int(statement, 0))
                    if idtipo == 1{
                        Expense = Expense + Int(sqlite3_column_int(statement, 1))
                    }
                    else{
                        Income = Income + Int(sqlite3_column_int(statement, 1))
                    }
                    
                }
                result.Correct = true
                result.Object = CurentBalance(IdSubcategoria: idSubcategoria, SubCategoria: subcategoria, Expense: Expense, Income: Income)
                
            }
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
    return result
    }

}
