//
//  TableViewController.swift
//  CurrencyConversion
//
//  Created by Pedro Nascimento on 07/02/20.
//  Copyright © 2020 PedroNascimento. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var conversions: Conversions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let decoded  = UserDefaults.standard.data(forKey: "historico") {
            do {
                let values = try JSONDecoder().decode(Conversions.self, from: decoded)
                self.conversions = values
                self.tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversions?.conversions.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell {
            
            if let value  = conversions?.conversions {
                cell.configure(conversion: value[indexPath.row])
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
