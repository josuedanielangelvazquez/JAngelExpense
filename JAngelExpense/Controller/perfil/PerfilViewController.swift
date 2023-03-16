//
//  PerfilViewController.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 15/03/23.
//

import UIKit

class PerfilViewController: UIViewController {

    let defaults = UserDefaults.standard
    var currentbalance =  0.0
    @IBOutlet weak var CurrentBalancelb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        let currentbalancedefault = defaults.double(forKey: "CurrentBalance")
       currentbalance = currentbalancedefault
       CurrentBalancelb.text = "$\(currentbalance)"
        
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
