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
    
    init() {
        //giftIdeaList.append(GiftIdeas())
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
}
