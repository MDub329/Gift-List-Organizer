//
//  ViewController.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/5/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"
    let emptyBox = "Checkmarkempty"
    let checkBox = "Checkmark"
    
    var checkImgNameArray = ["Checkmarkempty","Checkmarkempty","Checkmarkempty","Checkmarkempty","Checkmarkempty"]
    
    var peopleArray = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.register(GiftIdeaCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(FooterCell.self, forHeaderFooterViewReuseIdentifier: footerId)
        
        
        setUpNavBar()
        arrayTesting()
        calcSpent()
        
    }

    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(HomeController.handleAdd))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(HomeController.handleMore))
    }
    
    let addPopUpView = AddPopupView()
    
    @objc func handleAdd(){
        //add button is pressed
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(addPopUpView)
            addPopUpView.frame = window.frame
            addPopUpView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            addPopUpView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSave)))
            addPopUpView.alpha = 0
            addPopUpView.addView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            addPopUpView.addView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            addPopUpView.addView.heightAnchor.constraint(equalToConstant: window.frame.width/1.5).isActive = true
            addPopUpView.addView.widthAnchor.constraint(equalToConstant: window.frame.width/1.2).isActive = true
            addPopUpView.saveButton.anchor(top: nil, leading: nil, bottom: addPopUpView.addView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: addPopUpView.addView.frame.width/2, height: 50))
            addPopUpView.saveButton.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true

            

            UIView.animate(withDuration: 0.5) {
                self.addPopUpView.alpha = 1
            }
        }
    }
    
    @objc func handleSave(){
        UIView.animate(withDuration: 0.5) {
            self.addPopUpView.alpha = 0
        }
    }
    
    @objc func handleMore(){
        //Top left button is pressed
    }
    
    func arrayTesting() {
        peopleArray.append(People())
        let testString = "This is a place holder description text.  This is where a dscription of the item will be."
        let giftTest = GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "ATH-M50x", desc: testString, prc: 10.00, purch: false, lnk: "")
        peopleArray[0].giftIdeaList.append(giftTest)
        peopleArray[0].giftIdeaList.append(GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "Test String2", desc: "Test Desc2", prc: 20.00, purch: false, lnk: ""))
        peopleArray[0].totalBudget = 350
    }
    
    func calcSpent() {
        var sum = 0.0
        for item in peopleArray[0].giftIdeaList {
            if (item.purchased == true){
                sum += item.price
            }
        }
        peopleArray[0].spentBudget = sum
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GiftIdeaCell
        myCell.checkBoxLabel.image = UIImage(named: checkImgNameArray[indexPath.row])
        myCell.priceLabel.text = peopleArray[0].giftIdeaList[indexPath.row].priceString()
        myCell.titleLabel.text = peopleArray[0].giftIdeaList[indexPath.row].title
        myCell.descLabel.text = peopleArray[0].giftIdeaList[indexPath.row].description
        
        
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderCell
        myHeader.backgroundView = UIView(frame: myHeader.bounds)
        myHeader.backgroundView?.backgroundColor = .white
        myHeader.totalBudgetLabel.text = peopleArray[0].totalToString()
        myHeader.remainingLabel.text = peopleArray[0].calcRemainingBudgetString()
        
        return myHeader
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as! FooterCell
        myFooter.totalGiftsLabel.text = String(peopleArray[0].giftIdeaList.count)
        myFooter.totalSpentLabel.text = peopleArray[0].spentToString()
        return myFooter
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray[section].giftIdeaList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (checkImgNameArray[indexPath.row] == emptyBox) {
            checkImgNameArray[indexPath.row] = checkBox
            peopleArray[0].giftIdeaList[indexPath.row].purchased = true
        } else {
            checkImgNameArray[indexPath.row] = emptyBox
            peopleArray[0].giftIdeaList[indexPath.row].purchased = false
        }
        calcSpent()
        tableView.reloadData()
    }
}

