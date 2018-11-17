//
//  PeopleVC.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/25/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class PeopleVC: UITableViewController {
    
    let DH = DataHandler.standard
    let cellId = "cellId"
    let addPersonVC = AddPerson()
    let editPersonVC = AddPerson()
    //let giftListVC = GiftListVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        tableView.register(peopleCell.self, forCellReuseIdentifier: cellId)
        
        setUpAddPerson()
        setUpEditPerson()
        arrayTesting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    //adds buttons to navBar
    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAdd))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "People"
        
//        let backItem = UIBarButtonItem()
//        backItem.action = #selector(self.handleCancel)
////        backItem.title = "Cancel"
//        navigationItem.backBarButtonItem = backItem
    }
    
    //Setup AddPersonVC Bar Button
    func setUpAddPerson(){
        self.addPersonVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.handleSave))
        self.addPersonVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.handleCancel))
        self.addPersonVC.CVHidden = true
    }
    
    //Setup EditPersonVC Bar Button
    func setUpEditPerson() {
        self.editPersonVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(self.handleUpdate))
         self.editPersonVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.handleCancel))
    }
    
    //AddPersonVC Save button pressed
    @objc func handleSave() {
        let newPerson = People()
        
        if let name = self.addPersonVC.nameTextField.text {
            newPerson.fullName = name
        }
        //Cap first letter of Group
        if let group = self.addPersonVC.groupTextField.text {
            let capGroup = (group.prefix(1).uppercased() + group.lowercased().dropFirst())
            newPerson.groupSection = capGroup
        }
        if let budget = Double(self.addPersonVC.budgetTextField.text!) {
            newPerson.totalBudget = budget
        }
        if let note = self.addPersonVC.notesTextField.text {
            newPerson.note = note
        }
        if let image = self.addPersonVC.imgView.image {
            newPerson.imageView.image = image
        }
        
        DH.data.append(newPerson)
        DH.personIndex = DH.data.count - 1
        
        self.navigationController?.popViewController(animated: true)
        self.navigationItem.hidesBackButton = false
    }
    
    //EditPersonVC Edit button pressed
    @objc func handleUpdate() {
        
        if let name = self.editPersonVC.nameTextField.text {
            DH.data[DH.personIndex].fullName = name
        }
        //Cap first letter of Group
        if let group = self.editPersonVC.groupTextField.text {
            let capGroup = (group.prefix(1).uppercased() + group.lowercased().dropFirst())
            DH.data[DH.personIndex].groupSection = capGroup
        }
        //Removes the $ if present
        if var budgetSTR = self.editPersonVC.budgetTextField.text {
            if (budgetSTR.hasPrefix("$")) {
                budgetSTR.remove(at: budgetSTR.startIndex)
            }
            if let budget = Double(budgetSTR){
                DH.data[DH.personIndex].totalBudget = budget
            }
        }
        if let note = self.editPersonVC.notesTextField.text {
            DH.data[DH.personIndex].note = note
        }
        if let image = self.editPersonVC.imgView.image {
            DH.data[DH.personIndex].imageView.image = image
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
            //Add button is pressed
    @objc func handleAdd(){
        self.addPersonVC.clearFields()
        self.addPersonVC.titleString = "Add Person"
        self.navigationController?.pushViewController(self.addPersonVC, animated: true)
    }
    
    //Prompt user for conformation to cancel
    @objc func handleCancel(){
        //Insert prompt to insure the user wants to cancel
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you don't want to save?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    var sectionArray = [String]()
    var numSectionArray = [Int]()
    
    //Builds the Section Array
    func buildSectionsArray(){
        for person in DH.data {
            if (!isInSectionArray(group: person.groupSection)){
                sectionArray.append(person.groupSection)
                numSectionArray.append(1)
            } else {
                if let index = sectionArray.firstIndex(of: person.groupSection){
                    numSectionArray[index] += 1
                }
            }
        }
        
    }
    
    //Checks to see if There is a group not in the SectionArray
    func isInSectionArray(group: String) -> Bool {
        var value = false
            for test in sectionArray{
                if (test == group) {
                    value = true
                    
                }
            }
        return value
    }
    
    func sortList(array: [People]) -> [People]{
        #warning("Sort Array")
        var sortedArray = [People]()
        for group in sectionArray{
            for item in array{
                if (item.groupSection == group){
                    sortedArray.append(item)
                }
            }
        }
        return sortedArray
    }
    
    //Return String value of total gifts purchased for given index
    func totalGiftsPurch(index: Int) -> String {
        var totPurch = 0
        for gift in DH.data[index].giftIdeaList {
            if gift.purchased == true{
                totPurch += 1
            }
        }
        return String(totPurch)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        #warning("Testing")
        buildSectionsArray()
        //let test = sortList(array: DH.data)
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DH.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! peopleCell
        myCell.nameLabel.text = DH.data[indexPath.row].fullName
        myCell.profilePicture.image = DH.data[indexPath.row].imageView.image
        myCell.completionlabel.text = totalGiftsPurch(index: indexPath.row) + "/" + String(DH.data[indexPath.row].giftIdeaList.count)
        
        
        
        //Handle select Tap and Edit Tap
        let tapReconizer = MyTapGuesture(target: self, action: #selector(self.cellTap))
        tapReconizer.indexPath = indexPath
        myCell.addGestureRecognizer(tapReconizer)
        
        let longTapReconizer = MyLongPressGuesture(target: self, action: #selector(self.cellLongPress))
        longTapReconizer.indexPath = indexPath
        longTapReconizer.minimumPressDuration = 0.7
        myCell.addGestureRecognizer(longTapReconizer)
        
        return myCell
    }
    
    
    //Cell is tapped
    @objc func cellTap(Sender: MyLongPressGuesture) {
        DH.personIndex = Sender.indexPath.row
        self.navigationController?.pushViewController(GiftListVC(), animated: true)
    }
    
    //Cell is Long Pressed
    @objc func cellLongPress(Sender: MyLongPressGuesture) {
        if Sender.state == UIGestureRecognizer.State.began {
            
            let selectedPerson = DH.data[Sender.indexPath.row]
            DH.personIndex = Sender.indexPath.row
    
            self.editPersonVC.titleString = "Edit Person"
            self.editPersonVC.clearFields()
            self.editPersonVC.nameTextField.text = selectedPerson.fullName
            self.editPersonVC.imgView.image = selectedPerson.imageView.image
            self.editPersonVC.groupTextField.text = selectedPerson.groupSection
            self.editPersonVC.budgetTextField.text = selectedPerson.totalToString()
            self.editPersonVC.notesTextField.text = selectedPerson.note
            
            
            self.navigationController?.pushViewController(self.editPersonVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
//            if (DH.data.count > 1){
                let alert = UIAlertController(title: "Delete", message: "Are you sure you want to Delete?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                    //Clean up calls with this Constant
                    self.DH.data.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    if (self.DH.personIndex > 0){
                        self.DH.personIndex -= 1
                    } 
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
//            } else {
//                let alert = UIAlertController(title: "Error", message: "Can not delete last person in list!", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
        }
    }
 
    #warning("Used for Testing")
    func arrayTesting() {
        let newGift = GiftIdeas(ttl: "Gift 1", desc: "Test Desc blah blah blah blahb blah", prc: 10, lnk: " ")
        let newGift1 = GiftIdeas(ttl: "Gift 2", desc: "Test Desc blah blah blah blahb blah", prc: 20, lnk: " ")
        let newGift2 = GiftIdeas(ttl: "Gift 3", desc: "Test Desc blah blah blah blahb blah", prc: 30, lnk: " ")
        let newGift3 = GiftIdeas(ttl: "Gift 4", desc: "Test Desc blah blah blah blahb blah", prc: 40, lnk: " ")
        
        let newPerson = People(name: "Matthew Wells", total: 100, group: "Family", notes: "Each of the collection views has an Index that you use to traverse the collection. This is maybe one of the big causes of pain when getting to grips with String. You cannot randomly access an element in a string using a subscript (e.g. string[5]).")
        newPerson.giftIdeaList.append(newGift)
        newPerson.giftIdeaList.append(newGift1)
        newPerson.giftIdeaList.append(newGift2)
        newPerson.giftIdeaList.append(newGift3)
        
        DH.data.append(newPerson)
        DH.data[DH.personIndex].spentBudget = calcSpent()
        let newPerson1 = People(name: "Matthew Wells1", total: 110, group: "Co-Worker", notes: "Each of the collection views has an Index that you use to traverse the collection. This is maybe one of the big causes of pain when getting to grips with String. You cannot randomly access an element in a string using a subscript (e.g. string[5]).")
        
        let newGift10 = GiftIdeas(ttl: "Gift 1", desc: "Test Desc blah blah blah blahb blah", prc: 10, lnk: " ")
        let newGift11 = GiftIdeas(ttl: "Gift 2", desc: "Test Desc blah blah blah blahb blah", prc: 20, lnk: " ")
        let newGift21 = GiftIdeas(ttl: "Gift 3", desc: "Test Desc blah blah blah blahb blah", prc: 30, lnk: " ")
        let newGift31 = GiftIdeas(ttl: "Gift 4", desc: "Test Desc blah blah blah blahb blah", prc: 40, lnk: " ")
        
        newPerson1.giftIdeaList.append(newGift10)
        newPerson1.giftIdeaList.append(newGift11)
//        newPerson1.giftIdeaList.append(newGift21)
//        newPerson1.giftIdeaList.append(newGift31)
        
        DH.data.append(newPerson1)
        DH.data[DH.personIndex].spentBudget = calcSpent()
        let newPerson2 = People(name: "Matthew Wells2", total: 120, group: "Family", notes: "Each of the collection views has an Index that you use to traverse the collection. This is maybe one of the big causes of pain when getting to grips with String. You cannot randomly access an element in a string using a subscript (e.g. string[5]).")
        let newGift109 = GiftIdeas(ttl: "Gift 1", desc: "Test Desc blah blah blah blahb blah", prc: 10, lnk: " ")
        let newGift118 = GiftIdeas(ttl: "Gift 2", desc: "Test Desc blah blah blah blahb blah", prc: 20, lnk: " ")
        let newGift217 = GiftIdeas(ttl: "Gift 3", desc: "Test Desc blah blah blah blahb blah", prc: 30, lnk: " ")
        let newGift316 = GiftIdeas(ttl: "Gift 4", desc: "Test Desc blah blah blah blahb blah", prc: 40, lnk: " ")
        
        newPerson2.giftIdeaList.append(newGift109)
        newPerson2.giftIdeaList.append(newGift118)
        newPerson2.giftIdeaList.append(newGift217)
        //newPerson2.giftIdeaList.append(newGift316)
        DH.data.append(newPerson2)
        DH.data[DH.personIndex].spentBudget = calcSpent()
        let newPerson3 = People(name: "Matthew Wells3", total: 130, group: "Misc", notes: "Each of the collection views has an Index that you use to traverse the collection. This is maybe one of the big causes of pain when getting to grips with String. You cannot randomly access an element in a string using a subscript (e.g. string[5]).")
        DH.data.append(newPerson3)
        DH.data[DH.personIndex].spentBudget = calcSpent()
        
        
    }
    
    //Calculates the amount spent
    func calcSpent() -> Double{
        var sum = 0.0
        if (!DH.data[DH.personIndex].giftIdeaList.isEmpty){
            for item in DH.data[DH.personIndex].giftIdeaList {
                if (item.purchased == true){
                    sum += item.price
                }
            }
        }
        return sum
    }
    
}
