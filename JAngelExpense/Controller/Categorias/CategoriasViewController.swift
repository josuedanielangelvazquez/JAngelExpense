//
//  CategoriasViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 15/03/23.
//

import UIKit
import SQLite3
class CategoriasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var stacksearch: UIStackView!
    var idSubcategoria = 0
    var nameSubcategory = ""
    var busquedanormal = true
    var CategoriaArray = [categorias]()
    var subcategoriasarray = [SubCategorias]()
    let categoriasviewmodel = CategoriasViewModel()
    var seccion = 0
    let alert = UIAlertController(title: nil, message: "Se agrego correctamente", preferredStyle: .alert)
    let alertfalse = UIAlertController(title: nil, message: "Ocurrio un Error", preferredStyle: .alert)
    let Ok = UIAlertAction(title: "Ok", style: .default)
    var numer = 1
    @IBOutlet weak var CategoriasTaableView: UITableView!
    @IBOutlet weak var Searchtext: UITextField!
    @IBOutlet weak var searchbutton: UIButton!
    
    @IBOutlet weak var viewadorn: UIView!
    
    
    override func viewDidLoad() {
        viewadorn.layer.cornerRadius = 20
        stacksearch.layer.cornerRadius = 20
        stacksearch.layer.borderColor = nil
        stacksearch.layer.borderWidth = 0
        Searchtext.layer.cornerRadius = 30
        searchbutton.layer.cornerRadius = 20
        
    
        super.viewDidLoad()
        alert.addAction(Ok)
        alertfalse.addAction(Ok)
        CategoriasTaableView.delegate = self
        CategoriasTaableView.dataSource = self
        view.addSubview(CategoriasTaableView)
        
        CategoriasTaableView.register(UINib(nibName: "SubcategoriasTableViewCell", bundle: .main), forCellReuseIdentifier: "subcategoriascell")
        
    }
    override func viewWillAppear(_ animated: Bool) {

        loadData()
    }
    
    func loadData(){
        let  result = categoriasviewmodel.getall()
        if result.Correct == true{
            
            CategoriaArray = result.Objects as! [categorias]
            print(CategoriaArray)
            CategoriasTaableView.reloadData()
            
        }
        else
        {
            self.present(alertfalse, animated: true)
            print(result.ErrorMessage)
        }
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if busquedanormal == true{

            return CategoriaArray.count
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if busquedanormal == true{
            var name = CategoriaArray[section].NameCategorias
            seccion = section

            return name}
        else{
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if busquedanormal == true{
            return CategoriaArray[section].subcategorias!.count}
        else{
            return subcategoriasarray.count
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcategoriascell", for: indexPath as IndexPath) as! SubcategoriasTableViewCell
        if busquedanormal == true{
            cell.NameSubcategorie.text = CategoriaArray[indexPath.section].subcategorias![indexPath.row].nameSubCategoria
        }
        else{
            cell.NameSubcategorie.text = subcategoriasarray[indexPath.row].nameSubCategoria

        }
        
        return cell
    }
    func searchbynombre(){
        busquedanormal = false
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if busquedanormal == true{
            nameSubcategory = CategoriaArray[indexPath.section].subcategorias![indexPath.row].nameSubCategoria
            idSubcategoria = CategoriaArray[indexPath.section].subcategorias![indexPath.row].IdSubcategorias
        }
        else{
            nameSubcategory = subcategoriasarray[indexPath.row].nameSubCategoria
            idSubcategoria = subcategoriasarray[indexPath.row].IdSubcategorias
        }
        performSegue(withIdentifier: "seguesmovements", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesmovements"{
            let detail = segue.destination as! movementsbycategoryViewController
            detail.subcategorianame = nameSubcategory
            detail.idSubcategory = idSubcategoria
        }
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
