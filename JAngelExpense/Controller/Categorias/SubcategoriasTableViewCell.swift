//
//  SubcategoriasTableViewCell.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 15/03/23.
//

import UIKit

class SubcategoriasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NameSubcategorie : UILabel!
    @IBOutlet weak var ImageSubcategorie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    @IBAction func Subcategoriassegues(_ sender: Any) {
    }
}
