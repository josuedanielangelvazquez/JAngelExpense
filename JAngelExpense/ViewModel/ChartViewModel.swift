//
//  ChartViewModel.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 21/03/23.
//

import Foundation
class ChartViewModel{
    var subcategorias = [SubCategorias]()
    var expenseviewmodel = ExpensesViewModel()
    var categoriasviewmodel = CategoriasViewModel()
    func getCurrentBalance()->Result{
        var currentBalances = [CurentBalance]()
        var result = Result()
        var result2 = Result()
        
        result = categoriasviewmodel.getallSubcategorias()
        if result.Correct == true{
            subcategorias = result.Objects as! [SubCategorias]
            for subcategoria in subcategorias{
                result2 = expenseviewmodel.getbCurrentBalancebycategoria(idSubcategoria: subcategoria.IdSubcategorias, subcategoria: subcategoria.nameSubCategoria)
                
                if result2.Correct == true{
                    var currentbalance = result2.Object as! CurentBalance
                    if currentbalance.Expense == 0, currentbalance.Income == 0{
                        print("la subclase \(currentbalance.SubCategoria) esta vacia")
                    }
                    else{
                        currentBalances.append(result2.Object as! CurentBalance)
                    }
                    
                }
            }
        }
        result2.Objects = currentBalances
        return result2
    }
    
    
}
