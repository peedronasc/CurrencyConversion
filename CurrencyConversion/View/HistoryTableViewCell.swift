//
//  HistoryTableViewCell.swift
//  CurrencyConversion
//
//  Created by Pedro Nascimento on 07/02/20.
//  Copyright © 2020 PedroNascimento. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyFromLabel: UILabel!
    @IBOutlet weak var oldValueLabel: UILabel!
    @IBOutlet weak var currencyToLabel: UILabel!
    @IBOutlet weak var newValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(conversion: Conversion) {
        currencyFromLabel.text = conversion.currencyFrom
        currencyToLabel.text = conversion.currencyTo
        oldValueLabel.text = "R$ \(conversion.oldValue)"
        newValueLabel.text = "R$ \(conversion.newValue)"
    }
}
