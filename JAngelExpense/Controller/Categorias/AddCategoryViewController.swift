//
//  AddCategoryViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 17/03/23.
//

import UIKit
import iOSDropDown
class AddCategoryViewController: UIViewController {
    var categoriasviewmodel = CategoriasViewModel()
    @IBOutlet weak var segmentselect: UISegmentedControl!
    
    @IBOutlet weak var subCathegory: UITextField!
    @IBOutlet weak var Category: UITextField!
    @IBOutlet weak var textcategory: UILabel!
    @IBOutlet weak var ButtonAdd: UIButton!
    
    var idCategory = 0

    @IBOutlet weak var Categorytosubcategory: DropDown!
    var categories = categorias(IdCategorias: 0, NameCategorias: "")
    
    
    
    let alert = UIAlertController(title: nil, message: "Se agrego correctament", preferredStyle: .alert)
    let alertfalse = UIAlertController(title: nil, message: "Surgio un Error", preferredStyle: .alert)
    let Ok = UIAlertAction(title: "Ok", style: .default)
    override func viewDidLoad() {
        alert.addAction(Ok)
        alertfalse.addAction(Ok)
        super.viewDidLoad()
        subCathegory.isHidden = true
        Categorytosubcategory.isHidden = true
        segmentselect.selectedSegmentIndex = 0
        loadCategory()

        // Do any additional setup after loading the view.
    }
    
    func loadCategory(){
        Categorytosubcategory.optionIds = []
        Categorytosubcategory.optionArray = []
        let result = categoriasviewmodel.getall()
        if result.Correct == true{
            for categories in result.Objects! as! [categorias]{
                Categorytosubcategory.optionIds?.append(categories.IdCategorias)
                Categorytosubcategory.optionArray.append(categories.NameCategorias)
            }
            Categorytosubcategory.didSelect{ [self](selectedText , index ,id) in
                Categorytosubcategory.selectedRowColor = .systemIndigo
                Categorytosubcategory.arrowSize = 10
                Categorytosubcategory.arrowColor = .systemIndigo
                
                self.Categorytosubcategory.text = String(id)
                self.idCategory = id
                
                
            }
            
        }}
        func addCategories(){
            let name = Category.text
            let cat = categorias(IdCategorias: 0, NameCategorias: name!)
            
            let result =  categoriasviewmodel.addCategoria(categoria: cat)
            if result.Correct == true {
                self.present(alert, animated: true)
            }
            else{
                self.present(alertfalse, animated: true)
                
            }
            
            
        }
        func addSubcategories(){
            let namesubcategory = subCathegory.text
            let idcategoria = Int(idCategory)
            let subcat = SubCategorias(IdSubcategorias: 0, nameSubCategoria: namesubcategory!, idCategoria: idcategoria)
            let result = categoriasviewmodel.addSubCategoria(subcategoria: subcat)
            if result.Correct == true{
                self.present(alert, animated: true)
            }
            else{
                self.present(alertfalse, animated: true)
            }
        }
        
    

    @IBAction func segmentselectaction(_ sender: Any) {
        if segmentselect.selectedSegmentIndex == 0 {
            subCathegory.isHidden = true
            Categorytosubcategory.isHidden = true
            Category.isHidden = false
            ButtonAdd.setTitle("Add Category", for: .normal)
            textcategory.text = "Add Category"

        }
        else{
            viewWillAppear(true)
            subCathegory.isHidden = false
            Categorytosubcategory.isHidden = false
            Category.isHidden = true
            ButtonAdd.setTitle("Add SubCategory", for: .normal)
            textcategory.text = "Add SubCategory"

            

        }

    }
    
    
  
    
    @IBAction func AddAction(_ sender: Any) {
        if segmentselect.selectedSegmentIndex == 0{
            addCategories()}
        else{
            addSubcategories()
        }
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
