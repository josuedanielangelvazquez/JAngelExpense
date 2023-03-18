//
//  HomeTableViewCell.swift
//  JAngelExpense
//
//  Created by MacBookMBA6 on 14/03/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var costolbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var Fechalbl: UILabel!
    @IBOutlet weak var Imagelbl: UIImageView!
    @IBOutlet weak var StackView: UIStackView!

    @IBOutlet weak var costo: UIView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
