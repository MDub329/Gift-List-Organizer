//
//  ViewController.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/5/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

class HomeController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let cellId = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"
    let emptyBox = "Checkmarkempty"
    let checkBox = "Checkmark"
    let DH = DataHandler.standard
    
    //let DH.personIndex = 0
    

    let addPopUpView = AddPopupView()
    let editPopUpView = AddPopupView()
    let peopleVC = PeopleVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.register(GiftIdeaCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(FooterCell.self, forHeaderFooterViewReuseIdentifier: footerId)
        
        setUpNavBar()
        //arrayTesting()
        let newPerson = People(name: "Matthew Wells", total: 100, group: "Family")
        DH.data.append(newPerson)
        DH.data[DH.personIndex].spentBudget = calcSpent()
        #warning("For Testing")
        //peopleArray[0].totalBudget = 100
        
        
        
    }

    //adds buttons to navBar
    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.handleMore))
        
        //NavBar back text
        let backItem = UIBarButtonItem()
        backItem.title = "Gifts"
        navigationItem.backBarButtonItem = backItem
    }
    
    //add button is pressed
    @objc func handleAdd(){
        
        if let window = UIApplication.shared.keyWindow {
            self.addPopUpView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(addPopUpView, animated: true, completion: nil)
            
            self.addPopUpView.view.frame = window.frame
            self.addPopUpView.saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSave)))
            self.addPopUpView.addImgButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImgAdd)))
            self.addPopUpView.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
            self.addPopUpView.addView.heightAnchor.constraint(equalToConstant: window.frame.width/1.1).isActive = true
            self.addPopUpView.addView.widthAnchor.constraint(equalToConstant: window.frame.width/1.2).isActive = true
            
            self.addPopUpView.titleTextField.select(self) //Sets the cursor to titleTextfield
            
            self.addPopUpView.titleTextField.text = ""
            self.addPopUpView.descTextField.text = ""
            self.addPopUpView.priceTextField.text = ""
            self.addPopUpView.urlTextfield.text = ""
            self.addPopUpView.imgView.image = nil
        }
    }
    
    //handles the addImage button press
    @objc func handleImgAdd() {
        actionSheet(sourceView: self.addPopUpView)
    }
    
    //handles the editImage button press
    @objc func handleImgEdit() {
        actionSheet(sourceView: self.editPopUpView)
    }
    
    //User Chooses camera or library
    func actionSheet(sourceView: AddPopupView) {
        let image = UIImagePickerController()
        image.delegate = sourceView
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            image.sourceType = UIImagePickerController.SourceType.camera
            sourceView.present(image, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            sourceView.present(image, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sourceView.present(actionSheet, animated: true, completion: nil)
    }
    
    //handles Save Button press
    @objc func handleSave(){
        let newGift = GiftIdeas()
        if let name = addPopUpView.titleTextField.text {
            newGift.title = name
        }
        if let desc = addPopUpView.descTextField.text {
            newGift.description = desc
        }
        if let price = Double(addPopUpView.priceTextField.text!) {
            newGift.price = price
        }
        if let link = addPopUpView.urlTextfield.text {
            newGift.link = link
        }
        if let img = self.addPopUpView.imgView.image {
            newGift.imageView.image = img
        }
        newGift.purchImage = emptyBox
        
        DH.data[DH.personIndex].giftIdeaList.append(newGift)
        //checkImgNameArray.append(emptyBox)
        tableView.reloadSections([0], with: .automatic)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //handles Edit Button press
    @objc func handleUpdate(Sender: MyLongPressGuesture){
        let index = Sender.indexPath.row
        if let name = editPopUpView.titleTextField.text {
            DH.data[DH.personIndex].giftIdeaList[index].title = name
        }
        if let desc = editPopUpView.descTextField.text {
            DH.data[DH.personIndex].giftIdeaList[index].description = desc
        }
        if var price = editPopUpView.priceTextField.text {
            if (price.prefix(1) == "$") { //removes the $ from the start of price string
                price.remove(at: price.startIndex)
            }
            if let priceDbl = Double(price){
                DH.data[DH.personIndex].giftIdeaList[index].price = priceDbl
            }
        }
        if let link = editPopUpView.urlTextfield.text {
            DH.data[DH.personIndex].giftIdeaList[index].link = link
        }
        if let img = self.editPopUpView.imgView.image {
            DH.data[DH.personIndex].giftIdeaList[index].imageView.image = img
        }
        
        tableView.reloadSections([0], with: .automatic)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //Handles Cancel Button
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Top left button is pressed Pushes VC with navController
    @objc func handleMore(){
        self.peopleVC.passedPeopleArray = DH.data
        self.navigationController?.pushViewController(peopleVC, animated: true)
    }
    
    //Cell is tapped
    @objc func cellTap(Sender: MyLongPressGuesture) {
        let dataLoc =  self.DH.data[self.DH.personIndex].giftIdeaList[Sender.indexPath.row]
        if (dataLoc.purchImage == emptyBox) {
            dataLoc.purchImage = checkBox
            dataLoc.purchased = true
        } else {
            dataLoc.purchImage = emptyBox
            dataLoc.purchased = false
        }
        DH.data[DH.personIndex].spentBudget = calcSpent()
        tableView.reloadData()
    }

    //Cell is Long Pressed
    @objc func cellLongPress(Sender: MyLongPressGuesture) {
        if Sender.state == UIGestureRecognizer.State.began {
            if let window = UIApplication.shared.keyWindow {
                self.editPopUpView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.present(self.editPopUpView, animated: true, completion: nil)
                self.editPopUpView.addImgButton.setTitle("Edit Image", for: .normal)
                self.editPopUpView.view.frame = window.frame
                //self.editPopUpView.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
                let tapReconizer = MyTapGuesture(target: self, action: #selector(self.handleUpdate(Sender:)))
                tapReconizer.indexPath = Sender.indexPath
                self.editPopUpView.saveButton.addGestureRecognizer(tapReconizer)
                
                self.editPopUpView.addImgButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImgEdit)))
                self.editPopUpView.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
                
                self.editPopUpView.addView.heightAnchor.constraint(equalToConstant: window.frame.width/1.1).isActive = true
                self.editPopUpView.addView.widthAnchor.constraint(equalToConstant: window.frame.width/1.2).isActive = true
              
                self.editPopUpView.titleTextField.select(self) //Sets the cursor to titleTextfield
                
                let index = Sender.indexPath.row
                
                self.editPopUpView.titleTextField.text = DH.data[DH.personIndex].giftIdeaList[index].title
                self.editPopUpView.descTextField.text = DH.data[DH.personIndex].giftIdeaList[index].description
                self.editPopUpView.priceTextField.text = DH.data[DH.personIndex].giftIdeaList[index].priceString()
                self.editPopUpView.urlTextfield.text = DH.data[DH.personIndex].giftIdeaList[index].link
                self.editPopUpView.imgView.image = DH.data[DH.personIndex].giftIdeaList[index].imageView.image
            }
        }
    }
    
    @objc func handleLinkTap(Sender: MyTapGuesture) {
        let linkStr = DH.data[DH.personIndex].giftIdeaList[Sender.indexPath.row].link
        if (linkStr.hasPrefix("https://") || linkStr.hasPrefix("http://")){
            guard let url = URL(string: linkStr) else {
                //display something for a Failed URL
                wrongURL()
                
                return
            }
            UIApplication.shared.open(url)
        } else {
            wrongURL()
        }
        
    }
    
    //If link button is tapped in cell and url is invalid, This func is called
    func wrongURL() {
        let alert = UIAlertController(title: "Incorrect URL Format", message: "Make sure the URL is in the corect format.  EX: https://www.google.com", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    #warning("Used for Testing")
    func arrayTesting() {
        DH.data.append(People())
        let testString = "This is a place holder description text.  This is where a dscription of the item will be."
        let giftTest = GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "ATH-M50x", desc: testString, prc: 10.00, purch: false, lnk: "", purchString: emptyBox)
        DH.data[DH.personIndex].giftIdeaList.append(giftTest)
        DH.data[DH.personIndex].giftIdeaList.append(GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "Test String2", desc: "Test Desc2", prc: 20.00, purch: false, lnk: "", purchString: emptyBox))
        DH.data[DH.personIndex].totalBudget = 350
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GiftIdeaCell
        myCell.checkBoxLabel.image = UIImage(named: DH.data[DH.personIndex].giftIdeaList[indexPath.row].purchImage)
        myCell.priceLabel.text = DH.data[DH.personIndex].giftIdeaList[indexPath.row].priceString()
        myCell.titleLabel.text = DH.data[DH.personIndex].giftIdeaList[indexPath.row].title
        myCell.descLabel.text = DH.data[DH.personIndex].giftIdeaList[indexPath.row].description
        myCell.itemPicture.image = DH.data[DH.personIndex].giftIdeaList[indexPath.row].imageView.image
        
        //sends index to allow for both a long tap and normal tap
        let tapReconizer = MyTapGuesture(target: self, action: #selector(self.cellTap))
        tapReconizer.indexPath = indexPath
        myCell.addGestureRecognizer(tapReconizer)
        
        let longTapReconizer = MyLongPressGuesture(target: self, action: #selector(self.cellLongPress))
        longTapReconizer.indexPath = indexPath
        longTapReconizer.minimumPressDuration = 0.7
        myCell.addGestureRecognizer(longTapReconizer)
        
        let linkTapReconizer = MyTapGuesture(target: self, action: #selector(self.handleLinkTap))
        linkTapReconizer.indexPath = indexPath
        myCell.linkButton.addGestureRecognizer(linkTapReconizer)
        return myCell
    }
    
    var myHeader = HeaderCell()
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        myHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderCell
        myHeader.backgroundView = UIView(frame: myHeader.bounds)
        myHeader.backgroundView?.backgroundColor = .white
        myHeader.totalBudgetLabel.text = DH.data[DH.personIndex].totalToString()
        myHeader.remainingLabel.text = DH.data[DH.personIndex].calcRemainingBudgetString()
        myHeader.profilePicture.image = DH.data[DH.personIndex].imageView.image
        myHeader.groupLabel.text = DH.data[DH.personIndex].groupSection
        return myHeader
    }
    
    var myFooter = FooterCell()
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        myFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as! FooterCell
        myFooter.totalGiftsLabel.text = String(DH.data[DH.personIndex].giftIdeaList.count)
        myFooter.totalSpentLabel.text = DH.data[DH.personIndex].spentToString()
        return myFooter
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var intReturn = 0
        if (DH.data.isEmpty == false) {
            intReturn = DH.data[section].giftIdeaList.count
        }
        return intReturn
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to Delete?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in

                //Clean up calls with this Constant
                let dataLoc =  self.DH.data[self.DH.personIndex]
                
                dataLoc.giftIdeaList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                dataLoc.spentBudget = self.calcSpent()
                
                //Update Header
                self.myHeader.updateHeader(budgetTotal: dataLoc.totalToString(), budgetLeft: dataLoc.calcRemainingBudgetString())
                
                //Update Footer
                self.myFooter.updateFooter(totalSpent: dataLoc.spentToString(), totalCount: dataLoc.countToString())
                
    
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
}

class DataHandler{
    static let standard = DataHandler()
    var data = [People]()
    var personIndex = 0
}

