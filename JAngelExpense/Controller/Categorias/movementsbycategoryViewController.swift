//
//  movementsbycategoryViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 21/03/23.
//

import UIKit

class movementsbycategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var Subcategorylbl: UILabel!
    
    @IBOutlet weak var tableviewmovements: UITableView!
    var idSubcategory = 0
    var subcategorianame = ""
    var expensesviewmodel = ExpensesViewModel()
    var expenses = [Expenses]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewmovements.delegate = self
        tableviewmovements.dataSource = self
        view.addSubview(tableviewmovements)
        tableviewmovements.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "Homecell")
        loadData()
        Subcategorylbl.text = subcategorianame
    }
    func loadData(){
        var result = expensesviewmodel.getbysubcategory(idSubcategory: idSubcategory)
        if result.Correct == true{
            expenses = result.Objects as! [Expenses]
            tableviewmovements.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Homecell", for: indexPath as! IndexPath) as! HomeTableViewCell
        cell.layer.cornerRadius = 15
        cell.StackView.layer.cornerRadius = 15
        cell.costo.layer.cornerRadius = 15
        cell.StackView.layer.shadowColor = UIColor.black.cgColor
        cell.StackView.layer.shadowOpacity = 0.4
        cell.StackView.layer.shadowOffset = .zero
        cell.StackView.layer.shadowRadius = 0.4
        cell.Fechalbl.text = expenses[indexPath.row].fecha
        print(expenses[indexPath.row].fecha)
        cell.namelbl.text = expenses[indexPath.row].Name
        if expenses[indexPath.row].IdTipoBalance == 1{
            cell.costolbl.textColor = .red
            cell.costolbl.text = "-\(expenses[indexPath.row].cantidad)"
        }
        else if expenses[indexPath.row].IdTipoBalance == 2{
            cell.costolbl.text = "+\(expenses[indexPath.row].cantidad)"
            cell.costolbl.textColor = .green
        }

        return cell
    }
    


}
