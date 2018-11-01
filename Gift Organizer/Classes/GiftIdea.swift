//
//  GiftIdea.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/6/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class GiftIdeas {
    
    var imageView = UIImageView()
    var title = ""
    var description = ""
    var price = 0.0
    var purchased = false
    var link = ""
    var purchImage = "Checkmarkempty"
    
    init(img: UIImage, ttl: String, desc: String, prc: Double, purch: Bool, lnk: String, purchString: String) {
        imageView.image = img
        title = ttl
        description = desc
        price = prc
        purchased = purch
        link = lnk
    }
    
    init() {
        
    }
    
    func priceString() -> String {
        let strFormated = String(format: "%.2f", price)
        return "$\(strFormated)"
    }
}
