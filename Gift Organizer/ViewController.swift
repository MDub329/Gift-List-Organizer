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
    let emptyBox = "Checkmarkempty"
    let checkBox = "Checkmark"
    
    var checkImgNameArray = ["Checkmarkempty","Checkmarkempty","Checkmarkempty","Checkmarkempty","Checkmarkempty"]
    
    var peopleArray = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.register(GiftIdeaCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        peopleArray.append(People())
        let giftTest = GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "Test String", desc: "Test Desc", prc: 10.00, purch: false, lnk: "")
        peopleArray[0].giftIdeaList.append(giftTest)
        peopleArray[0].giftIdeaList.append(GiftIdeas(img: UIImage(named: "ATH-M50x")!, ttl: "Test String2", desc: "Test Desc2", prc: 20.00, purch: false, lnk: ""))
        peopleArray[0].totalBudget = 350
        
        calcSpent()
        
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

