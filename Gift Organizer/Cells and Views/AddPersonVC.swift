//
//  AddPersonVC.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/25/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class AddPersonVC: AddPerson {
    
    let DH = DataHandler.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        setUpNavBar()
        setUpViews()
        
    }
    
    func setUpViews() {
        self.addView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
    }
    
    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.handleSave))
    }
    
    //Save button is pressed
    @objc func handleSave(){
        let newPerson = People()
        if let name = self.nameTextField.text {
            newPerson.fullName = name
        }
        if let group = self.groupTextField.text {
            newPerson.groupSection = group
        }
        if let budget = Double(self.budgetTextField.text!) {
            newPerson.totalBudget = budget
        }
        if let notes = self.notesTextField.text {
            newPerson.note = notes
        }
        if let img = self.imgView.image {
            newPerson.imageView.image = img
        }
        
        DH.data.append(newPerson)
        self.navigationController?.popViewController(animated: true)
    }
    

    
    
}
