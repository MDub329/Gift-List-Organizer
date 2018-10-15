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
    
    let personIndex = 0
    
    var checkImgNameArray = ["Checkmarkempty","Checkmarkempty"]
    
    var peopleArray = [People]()
    let addPopUpView = AddPopupView()
    let editPopUpView = AddPopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.register(GiftIdeaCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(FooterCell.self, forHeaderFooterViewReuseIdentifier: footerId)
        
        setUpNavBar()
        //arrayTesting()
        peopleArray.append(People())
        calcSpent()
        //self.tableView.isEditing = true
        #warning("For Testing")
        peopleArray[0].totalBudget = 100
        
    }

    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(HomeController.handleAdd))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(HomeController.handleMore))
    }
    
    
    @objc func handleAdd(){
        //add button is pressed
        
        if let window = UIApplication.shared.keyWindow {
            self.addPopUpView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(addPopUpView, animated: true, completion: nil)
            
            self.addPopUpView.view.frame = window.frame
            self.addPopUpView.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.addPopUpView.saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSave)))
            self.addPopUpView.addImgButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImgAdd)))
            //ImagePicker shows below addPopUpView
            self.addPopUpView.view.alpha = 1
            self.addPopUpView.addView.centerXAnchor.constraint(equalTo: self.addPopUpView.view.centerXAnchor).isActive = true
            self.addPopUpView.addView.centerYAnchor.constraint(equalTo:self.addPopUpView.view.centerYAnchor).isActive = true
            self.addPopUpView.addView.heightAnchor.constraint(equalToConstant: window.frame.width/1.1).isActive = true
            self.addPopUpView.addView.widthAnchor.constraint(equalToConstant: window.frame.width/1.2).isActive = true
            self.addPopUpView.saveButton.anchor(top: nil, leading: nil, bottom: self.addPopUpView.addView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.addPopUpView.addView.frame.width/2, height: 50))
            self.addPopUpView.titleTextField.select(self) //Sets the cursor to titleTextfield
            
            self.addPopUpView.titleTextField.text = ""
            self.addPopUpView.descTextField.text = ""
            self.addPopUpView.priceTextField.text = ""
            self.addPopUpView.urlTextfield.text = ""
            self.addPopUpView.imgView.image = nil
            

//            UIView.animate(withDuration: 0.5) {
//                self.addPopUpView.view.alpha = 1
//            }
        }
    }
    
    @objc func handleImgAdd() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.addPopUpView.present(image, animated: true, completion: nil)
        
    }
    
    @objc func handleImgEdit() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.editPopUpView.present(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let theinfo:NSDictionary = info as NSDictionary
        let img:UIImage = theinfo.object(forKey: UIImagePickerController.InfoKey.originalImage) as! UIImage
        self.addPopUpView.imgView.image = img
        self.addPopUpView.dismiss(animated: true, completion: nil)
    
    }
    
    
    
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
        
        peopleArray[personIndex].giftIdeaList.append(newGift)
        checkImgNameArray.append(emptyBox)
        
//        UIView.animate(withDuration: 0.5) {
//            self.addPopUpView.view.alpha = 0
//        }
        //let index = IndexPath(row: peopleArray[personIndex].giftIdeaList.count-1, section: 0)
        //tableView.insertRows(at: [index], with: .automatic)
        tableView.reloadSections([0], with: .automatic)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleUpdate(Sender: MyLongPressGuesture){
        
        
        tableView.reloadSections([0], with: .automatic)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleMore(){
        //Top left button is pressed
    }
    
    @objc func cellTap(Sender: MyLongPressGuesture) {
        if (checkImgNameArray[Sender.indexPath.row] == emptyBox) {
            checkImgNameArray[Sender.indexPath.row] = checkBox
            peopleArray[personIndex].giftIdeaList[Sender.indexPath.row].purchased = true
        } else {
            checkImgNameArray[Sender.indexPath.row] = emptyBox
            peopleArray[personIndex].giftIdeaList[Sender.indexPath.row].purchased = false
        }
        calcSpent()
        tableView.reloadData()
    }

    @objc func cellLongPress(Sender: MyLongPressGuesture) {
        if Sender.state == UIGestureRecognizer.State.began {
            if let window = UIApplication.shared.keyWindow {
                self.editPopUpView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.present(self.editPopUpView, animated: true, completion: nil)
                
                self.editPopUpView.view.frame = window.frame
                self.editPopUpView.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
                let tapReconizer = MyTapGuesture(target: self, action: #selector(self.handleUpdate(Sender:)))
                tapReconizer.indexPath = Sender.indexPath
                self.editPopUpView.saveButton.addGestureRecognizer(tapReconizer)
                
                self.editPopUpView.addImgButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImgEdit)))
                //ImagePicker shows below addPopUpView
                self.editPopUpView.view.alpha = 1
                self.editPopUpView.addView.centerXAnchor.constraint(equalTo: self.editPopUpView.view.centerXAnchor).isActive = true
                self.editPopUpView.addView.centerYAnchor.constraint(equalTo:self.editPopUpView.view.centerYAnchor).isActive = true
                self.editPopUpView.addView.heightAnchor.constraint(equalToConstant: window.frame.width/1.1).isActive = true
                self.editPopUpView.addView.widthAnchor.constraint(equalToConstant: window.frame.width/1.2).isActive = true
                self.editPopUpView.saveButton.anchor(top: nil, leading: nil, bottom: self.editPopUpView.addView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.editPopUpView.addView.frame.width/2, height: 50))
                self.editPopUpView.titleTextField.select(self) //Sets the cursor to titleTextfield
                
                let index = Sender.indexPath.row
                
                self.editPopUpView.titleTextField.text = peopleArray[personIndex].giftIdeaList[index].title
                self.editPopUpView.descTextField.text = peopleArray[personIndex].giftIdeaList[index].description
                self.editPopUpView.priceTextField.text = peopleArray[personIndex].giftIdeaList[index].priceString()
                self.editPopUpView.urlTextfield.text = peopleArray[personIndex].giftIdeaList[index].link
                self.editPopUpView.imgView.image = peopleArray[personIndex].giftIdeaList[index].imageView.image
            }
        }
    }
    
    func arrayTesting() {
        peopleArray.append(People())
        let testString = "This is a place holder description text.  This is where a dscription of the item will be."
        let giftTest = GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "ATH-M50x", desc: testString, prc: 10.00, purch: false, lnk: "")
        peopleArray[personIndex].giftIdeaList.append(giftTest)
        peopleArray[personIndex].giftIdeaList.append(GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "Test String2", desc: "Test Desc2", prc: 20.00, purch: false, lnk: ""))
        peopleArray[personIndex].totalBudget = 350
    }
    
    func calcSpent() {
        var sum = 0.0
        if (!peopleArray[personIndex].giftIdeaList.isEmpty){
            for item in peopleArray[personIndex].giftIdeaList {
                if (item.purchased == true){
                    sum += item.price
                }
            }
        }
        peopleArray[personIndex].spentBudget = sum
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GiftIdeaCell
        myCell.checkBoxLabel.image = UIImage(named: checkImgNameArray[indexPath.row])
        myCell.priceLabel.text = peopleArray[personIndex].giftIdeaList[indexPath.row].priceString()
        myCell.titleLabel.text = peopleArray[personIndex].giftIdeaList[indexPath.row].title
        myCell.descLabel.text = peopleArray[personIndex].giftIdeaList[indexPath.row].description
        myCell.itemPicture.image = peopleArray[personIndex].giftIdeaList[indexPath.row].imageView.image
        //sends index to allow for both a long tap and normal tap
        let tapReconizer = MyTapGuesture(target: self, action: #selector(self.cellTap))
        tapReconizer.indexPath = indexPath
        myCell.addGestureRecognizer(tapReconizer)
        let longTapReconizer = MyLongPressGuesture(target: self, action: #selector(self.cellLongPress))
        longTapReconizer.indexPath = indexPath
        longTapReconizer.minimumPressDuration = 0.7
        myCell.addGestureRecognizer(longTapReconizer)
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderCell
        myHeader.backgroundView = UIView(frame: myHeader.bounds)
        myHeader.backgroundView?.backgroundColor = .white
        myHeader.totalBudgetLabel.text = peopleArray[personIndex].totalToString()
        myHeader.remainingLabel.text = peopleArray[personIndex].calcRemainingBudgetString()
        myHeader.profilePicture.image = peopleArray[personIndex].imageView.image
        
        return myHeader
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as! FooterCell
        myFooter.totalGiftsLabel.text = String(peopleArray[personIndex].giftIdeaList.count)
        myFooter.totalSpentLabel.text = peopleArray[personIndex].spentToString()
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
        return peopleArray[section].giftIdeaList.count
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if (checkImgNameArray[indexPath.row] == emptyBox) {
//            checkImgNameArray[indexPath.row] = checkBox
//            peopleArray[personIndex].giftIdeaList[indexPath.row].purchased = true
//        } else {
//            checkImgNameArray[indexPath.row] = emptyBox
//            peopleArray[personIndex].giftIdeaList[indexPath.row].purchased = false
//        }
//        calcSpent()
//        tableView.reloadData()
//    }
//
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

