//
//  People.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/5/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class People {
    
    var giftIdeaList = [GiftIdeas]()
    var totalBudget = 0.0
    var spentBudget = 0.0
    var groupSection = ""
    var fullName = ""
    var note = ""
    var imageView = UIImageView()
    
    
    init() {
        //giftIdeaList.append(GiftIdeas())
    }
    
    init(name: String, total: Double, image: UIImageView, group: String) {
        fullName = name
        totalBudget = total
        imageView = image
        groupSection = group
    }
    
    init(name: String, total: Double, image: UIImageView, group: String, notes: String) {
        fullName = name
        totalBudget = total
        imageView = image
        groupSection = group
        note = notes
    }
    
    init(name: String, total: Double, group: String, notes: String) {
        fullName = name
        totalBudget = total
        groupSection = group
        note = notes
    }
    
    init(name: String, total: Double, group: String) {
        fullName = name
        totalBudget = total
        groupSection = group
    }
    
    
    func calcRemainingBudgetString() -> String{
        let calc = totalBudget - spentBudget
        let strFormated = String(format: "%.2f", calc)
        return "$\(strFormated)"
    }
    
    func totalToString() -> String{
        let strFormated = String(format: "%.2f", totalBudget)
        return "$\(strFormated)"
    }
    
    func spentToString() -> String{
        let strFormated = String(format: "%.2f", spentBudget)
        return "$\(strFormated)"
    }
    
    func countToString() -> String{
        let countStr = String(self.giftIdeaList.count)
        return countStr
    }
}

