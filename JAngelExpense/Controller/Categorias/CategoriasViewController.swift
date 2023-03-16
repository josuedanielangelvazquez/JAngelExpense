//
//  CategoriasViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 15/03/23.
//

import UIKit
import SQLite3
class CategoriasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var subcategoriaarray2 = [SubCategorias]()
    var subcategoriasarray = [SubCategorias]()
    let categoriasviewmodel = CategoriasViewModel()
    let alert = UIAlertController(title: nil, message: "Se agrego correctamente", preferredStyle: .alert)
    let alertfalse = UIAlertController(title: nil, message: "Ocurrio un Error", preferredStyle: .alert)
    let Ok = UIAlertAction(title: "Ok", style: .default)
    @IBOutlet weak var CategoriasTaableView: UITableView!
    
    @IBOutlet weak var Searchtext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(Ok)
        alertfalse.addAction(Ok)
        CategoriasTaableView.delegate = self
        CategoriasTaableView.dataSource = self
        view.addSubview(CategoriasTaableView)
        
        CategoriasTaableView.register(UINib(nibName: "SubcategoriasTableViewCell", bundle: .main), forCellReuseIdentifier: "subcategoriascell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        subcategoriasarray.count
loadData()
    }
    func loadData(){
        
        let result = categoriasviewmodel.getallSubcategorias()
        if result.Correct == true{
            
            subcategoriasarray = result.Objects as! [SubCategorias]
            CategoriasTaableView.reloadData()
            
        }
        else
        {
            self.present(alertfalse, animated: true)
            print(result.ErrorMessage)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategoriasarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcategoriascell", for: indexPath as IndexPath) as! SubcategoriasTableViewCell
        cell.NameSubcategorie.text = subcategoriasarray[indexPath.row].nameSubCategoria
        return cell
    }
    func searchbynombre(){
        subcategoriasarray = [SubCategorias]()
        let result =  categoriasviewmodel.getbyNombre(nombrecategoria: Searchtext.text!)
        if result.Correct == true{
            subcategoriasarray = result.Objects as! [SubCategorias]
            CategoriasTaableView.reloadData()
        }
        else{
            self.present(alertfalse, animated: true)
        }
    }
    func addCategory(){
        
    }
    func addSubCategory(){}
    

    @IBAction func AddCategoriasAction(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Selectd a option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Add a Category", style: .default){ action in
            self.addCategory()
        })
        alert.addAction(UIAlertAction(title: "Add a Subcategory", style: .default){
            action in
            self.addSubCategory()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        cancel.setValue(UIColor.systemRed, forKey: "titleTextColor")
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    @IBAction func SearchAction(_ sender: Any) {
        searchbynombre()
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
