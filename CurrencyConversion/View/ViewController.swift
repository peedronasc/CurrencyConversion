//
//  ViewController.swift
//  CurrencyConversion
//
//  Created by Pedro Nascimento on 05/02/20.
//  Copyright © 2020 PedroNascimento. All rights reserved.
//

import UIKit
import IQDropDownTextField
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var currencyFromField: IQDropDownTextField!
    @IBOutlet weak var currencyToField: IQDropDownTextField!
    @IBOutlet weak var newValueField: UITextField!
    
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHistoryButton()
        configure()
    }
    
    func configure() {
        if let rates = ConversionController.rates {
            currencyFromField.isOptionalDropDown = false
            currencyToField.isOptionalDropDown = false
            currencyFromField.itemList = rates
            currencyToField.itemList = rates
        }
    }
    
    func addHistoryButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Histórico", style: .done, target: self, action: #selector(self.action(sender:)))
    }
    
    @objc
    func action(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "history", sender: nil)
    }

    @IBAction func didTapGo(_ sender: Any) {
        
        if let valueString = valueField.text,
            let doubleValue = Double(valueString),
            let curencyFrom = currencyFromField.selectedItem,
            let curencyTo = currencyToField.selectedItem {
            
            self.view.endEditing(true)
            convertion(currencyFrom: curencyFrom, currencyTo: curencyTo, value: doubleValue)
            
        } else {
           showError()
        }
    }
    
    
    func showError() {
        let alert  = UIAlertController(title: "Ops", message: "Preencha todos os campos", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func convertion(currencyFrom: String, currencyTo: String, value: Double) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ConversionController.getCurrencys(currency: currencyFrom) { (currency) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let rates = currency?.rates,
                let valueCurrencyTo = rates[currencyTo] {
                
                let result = value * valueCurrencyTo
                self.newValueField.text = "R$ \(result)"
                
                let conversion = Conversion(currencyFrom: currencyFrom, currencyTo: currencyTo, oldValue: value, newValue: result)
                self.saveHistory(value: conversion)
            } else {
                    self.showError()
            }
        }
    }
    
    
    func saveHistory(value: Conversion) {
        
        if let decoded  = UserDefaults.standard.data(forKey: "historico") {
            do {
                var conversions = try JSONDecoder().decode(Conversions.self, from: decoded)
                conversions.conversions.append(value)
                
                do {
                    let data = try JSONEncoder().encode(conversions)
                    UserDefaults.standard.set(data, forKey: "historico")
                } catch {
                    
                }
            } catch {
                
            }
        } else {
            do {
                
                let convertions = Conversions(conversions: [value])
                let data = try JSONEncoder().encode(convertions)
                UserDefaults.standard.set(data, forKey: "historico")
            } catch {
                
            }
            
        }
        
    }
    
}

