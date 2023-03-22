//
//  ViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 13/03/23.
//

import UIKit
import iOSDropDown
class ViewController: UIViewController, UITextFieldDelegate {
    let modelExpenses : Expenses? = nil
    let expensesviewmodel = ExpensesViewModel()
    let categoriasviewmodel = CategoriasViewModel()
    var db = DB()
    var idCategory = 0
    var idsubcategory = 0
    @IBOutlet weak var Balance: UILabel!
    
    @IBOutlet weak var SelectTipedidselect: UISegmentedControl!
    @IBOutlet weak var Amounttext: UITextField!
    @IBOutlet weak var IncomeorExpensetext: UITextField!
    
    
    @IBOutlet weak var Categoria: DropDown!
    
    @IBOutlet weak var subcategorie: DropDown!
    @IBOutlet weak var Datedate: UIDatePicker!
    @IBOutlet weak var Tiposegment: UISegmentedControl!
    let defaults = UserDefaults.standard
    var idTipo = 1
    var currentbalance = 0.0
    override func viewDidLoad() {
        Amounttext.delegate = self
        super.viewDidLoad()
        db.OpenConexion()
        Tiposegment.selectedSegmentIndex = 0
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == Amounttext{
            let allowingChars = "0123456789."
            let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
            let validString = string.rangeOfCharacter(from: numberOnly) == nil
                   return validString
             }
        return true
        }
    override func viewWillAppear(_ animated: Bool) {
        getbalance()
        loadCategory()
        Categoria.didSelect{ selectedText, index, id in self.loadsubcategorias(idcategoria: id)
        }

    }
    func getbalance(){
         let currentbalancedefault = defaults.double(forKey: "CurrentBalance")
        currentbalance = currentbalancedefault
        Balance.text = "$\(currentbalance)"

    }
    func loadsubcategorias(idcategoria : Int){
        subcategorie.optionIds = []
        subcategorie.optionArray = []
        let result = categoriasviewmodel.getsubcategoriesbyIdCategory(idCategory: idcategoria)
        if result.Correct == true{
            for subcategories in result.Objects! as! [SubCategorias]{
                subcategorie.optionIds?.append(subcategories.IdSubcategorias)
                subcategorie.optionArray.append(subcategories.nameSubCategoria)
                subcategorie.didSelect{[self](selectedText, index, id) in
                    subcategorie.selectedRowColor = .systemIndigo
                    subcategorie.arrowSize = 10
                    subcategorie.arrowColor = .systemIndigo
                    self.subcategorie.text = String(selectedText)
                    self.idsubcategory = id
                }
            }
        }
        else{
            
        }
    }
    func loadCategory(){
        Categoria.optionIds = []
        Categoria.optionArray = []
        let result = categoriasviewmodel.getall()
        if result.Correct == true{
            for categories in result.Objects! as! [categorias]{
                Categoria.optionIds?.append(categories.IdCategorias)
                Categoria.optionArray.append(categories.NameCategorias)
            }
            Categoria.didSelect{ [self](selectedText , index ,id) in
                Categoria.selectedRowColor = .systemIndigo
                Categoria.arrowSize = 10
                Categoria.arrowColor = .systemIndigo
                self.Categoria.text = String(selectedText)
                self.idCategory = id
                
                
            }
            
        }}

                              
    func addExpenses(){
        var result = Result()
        guard let name = IncomeorExpensetext.text, IncomeorExpensetext.text != nil, IncomeorExpensetext.text != "" else{
            IncomeorExpensetext.backgroundColor = .red
            return
        }
        guard let amount = Double(Amounttext.text!), Amounttext.text != nil, Amounttext.text != "" else{
            Amounttext.backgroundColor = .red
            return
        }
        let IdSubcategoria = Int(subcategorie.text!)
        let idtipobalance = Int()
        let iduser = 1
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat =  "dd/MM/yyyy HH:mm"
        let stringFromDate: String = dateFormater.string(from: self.Datedate.date) as String
        
       
       
                if currentbalance <= 0, idTipo == 1 ||  amount > currentbalance, idTipo == 1{
            let alert  = UIAlertController(title: nil, message: "No tienes los fondos necesarios ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
        }
        else{
            result.Object  = Expenses(idValance: 0, Name: name, cantidad: amount, IdTipoBalance: idTipo, IdSubCategorie: idsubcategory , IdUser: iduser, fecha: stringFromDate)
        result = expensesviewmodel.Addexpense(expense: result.Object as! Expenses)
            if idTipo == 1{
                currentbalance -= amount
                Balance.text = String(currentbalance)
            }
            else{
                currentbalance += amount
                Balance.text = String(currentbalance)

            }
        if result.Correct == true{
            let alert = UIAlertController(title: nil, message: "Se agrego Correctamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
            else{
                let alert = UIAlertController(title: "Error", message: "Ocurrio un Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)}
        }
}
    func validacion(){
   
       
        addExpenses()
    }

    @IBAction func TipoSegment(_ sender: Any) {
        if Tiposegment.selectedSegmentIndex == 0{
            viewWillAppear(true)
            idTipo = 1
        }
        else {
            viewWillAppear(true)
            idTipo = 2
        }
    
    }
    
    @IBAction func AddAction(_ sender: Any) {
      
        let amount = Double(Amounttext.text!)
        if amount! > currentbalance, idTipo == 1{
            let alert = UIAlertController(title: nil, message: "No tienes fondos suficientes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            Amounttext.text = nil
            IncomeorExpensetext.text = nil
            Categoria.text = nil
            subcategorie.text = nil
        }
        else{
            addExpenses()
        }
        
    }
    
}

