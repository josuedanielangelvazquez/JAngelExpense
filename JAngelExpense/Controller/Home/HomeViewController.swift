//
//  HomeViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 14/03/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var CurrentBalancelbl: UILabel!
    @IBOutlet weak var Incomelbl: UILabel!
    @IBOutlet weak var Expenselbl: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var GetDate: UILabel!
    
    
    @IBOutlet weak var Arrowred: UIImageView!
    
    @IBOutlet weak var arrowgreen: UIImageView!
    
    let defaults = UserDefaults.standard
    var Expense = 0.0
    var Income = 0.0
    var Currentbalance = 0.0
    let expensesviewmodel = ExpensesViewModel()
    var expenses = [Expenses]()
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.backgroundView = nil
        TableView.backgroundColor = nil
        TableView.delegate = self
        TableView.dataSource = self
        view.addSubview(TableView)
        self.TableView.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "Homecell")
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        getDate()
        actualizarlbls()
}
    func getDate(){
        let date = Date()
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = "MMMM yyyy"
         let horamodificacion = dateformatter.string(from: date)
        GetDate.text = horamodificacion
    }
    
    func actualizarlbls(){
        Expense = 0.0
        Income = 0.0
        Currentbalance = 0.0
        for suma in expenses{
            if suma.IdTipoBalance == 1{
              Expense +=  suma.cantidad
            }
            else{
                Income += suma.cantidad}
        }
            Expenselbl.text = "$\(Expense)"
            Incomelbl.text = "$\(Income)"
            Currentbalance = Income - Expense
            CurrentBalancelbl.text = "$\(Currentbalance)"
            defaults.set(Currentbalance, forKey: "CurrentBalance")
        print(defaults)
    }
    func loadData(){
        var result = Result()
        result = expensesviewmodel.getall()
        expenses = result.Objects as! [Expenses]
        TableView.reloadData()
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Homecell", for: indexPath as IndexPath) as! HomeTableViewCell
        

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
                print (Income)
        }

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
