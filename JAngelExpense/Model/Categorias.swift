//
//  Categorias.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 15/03/23.
//

import Foundation
struct SubCategorias{
    var IdSubcategorias : Int
    var nameSubCategoria : String
    var idCategoria : Int
    
}
struct categorias{
    var IdCategorias : Int
    var NameCategorias : String
    var subcategorias : [SubCategorias]?
}

