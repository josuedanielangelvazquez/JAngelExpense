//
//  ChartViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 21/03/23.
//

import UIKit

@available(iOS 16.0, *)
class ChartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chartviewmodel = ChartViewModel()
    var currentbalances = [CurentBalance]()
    
    
    
    @IBOutlet weak var charTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        charTableView.backgroundView = nil
        charTableView.backgroundColor = nil
        charTableView.delegate = self
        charTableView.dataSource = self
        view.addSubview(charTableView)
        charTableView.register(UINib(nibName: "ChartTableViewCell", bundle: .main), forCellReuseIdentifier: "chartcell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loaddata()

    }
    
    func loaddata(){
        var result = Result()
        result = chartviewmodel.getCurrentBalance()
        if result.Correct == true{
            currentbalances = result.Objects as! [CurentBalance]
            charTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentbalances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartcell", for: indexPath as! IndexPath) as! ChartTableViewCell
        cell.layer.cornerRadius = 15
        cell.ViewContainer.layer.cornerRadius = 15
        cell.ViewContainer.layer.shadowColor = UIColor.black.cgColor
        cell.ViewContainer.layer.shadowOpacity = 0.4
        cell.ViewContainer.layer.shadowOffset = .zero
        cell.ViewContainer.layer.shadowRadius = 0.4
        cell.Categorialbl.text = String(currentbalances[indexPath.row].SubCategoria)
        cell.Income = currentbalances[indexPath.row].Income
        cell.expense = currentbalances[indexPath.row].Expense
        return cell
    }
    
    


}
