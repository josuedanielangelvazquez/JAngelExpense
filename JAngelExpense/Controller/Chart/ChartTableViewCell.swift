//
//  ChartTableViewCell.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 21/03/23.
//

import UIKit
import Charts
class ChartTableViewCell: UITableViewCell {

//    Contenedores
    
    @IBOutlet weak var ViewContainer: UIView!
    
//----
    
    @IBOutlet weak var Categorialbl: UILabel!
    @IBOutlet weak var chartchart: PieChartView!
    var expense = 0
    var Income = 0
    var valorsdata = [PieChartDataEntry]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        loadData()
        
    }
    func loadData(){
        DispatchQueue.main.async { [self] in
            var expensechart = PieChartDataEntry(value:  Double(expense))
            var incomechart = PieChartDataEntry(value: Double(Income))
            chartchart.chartDescription.text = ""
            valorsdata = [expensechart, incomechart]
            expensechart.label = "Expense"
            incomechart.label = "Income"
            let chartDataset = PieChartDataSet(entries: valorsdata, label: "")
            let chartData = PieChartData(dataSet: chartDataset)
            let colors = [UIColor(named: "Expense"), UIColor(named: "Income")]
            
            chartDataset.colors = colors as! [NSUIColor]
            chartchart.data = chartData
        }
    }
    
}
