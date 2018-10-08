//
//  Cells.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/6/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profilePicture: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Matthew Wells"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let remainingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$20.00"
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .blue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let budgetTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total Budget"
        lbl.font = lbl.font.withSize(14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .red
        return lbl
    }()
    
    let remainingTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Budget Left"
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .blue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let totalBudgetLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$20.00"
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
 
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(profilePicture)
        self.addSubview(nameLabel)
        self.addSubview(remainingLabel)
        self.addSubview(totalBudgetLabel)
        self.addSubview(remainingTitleLabel)
        self.addSubview(budgetTitleLabel)
        
        profilePicture.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        profilePicture.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        nameLabel.anchor(top: nil, leading: self.profilePicture.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 50))
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        budgetTitleLabel.anchor(top: nil, leading: nil, bottom: totalBudgetLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        budgetTitleLabel.centerXAnchor.constraint(equalTo: self.totalBudgetLabel.centerXAnchor).isActive = true
        
        totalBudgetLabel.anchor(top: nil, leading: self.nameLabel.trailingAnchor, bottom: nil, trailing: self.budgetTitleLabel.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        totalBudgetLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        remainingLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        remainingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        remainingTitleLabel.anchor(top: nil, leading: nil, bottom: remainingLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        remainingTitleLabel.centerXAnchor.constraint(equalTo: self.remainingLabel.centerXAnchor).isActive = true
    }
    
}

class FooterCell: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(totalGiftsLabel)
        addSubview(totalGiftTitleLabel)
        addSubview(totalSpentLabel)
        
        totalGiftsLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        totalGiftsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        totalGiftTitleLabel.centerYAnchor.constraint(equalTo: self.totalGiftsLabel.centerYAnchor).isActive = true
        totalGiftTitleLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.totalGiftsLabel.leadingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 10))
        
        totalSpentLabel.anchor(top: self.topAnchor, leading: self.totalGiftsLabel.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,padding: .init(top: 5, left: 60, bottom: 5, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let totalSpentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .blue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let totalGiftsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let totalGiftTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total Gifts:"
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .blue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
}

class GiftIdeaCell: UITableViewCell {
    
    var imgSize = 50
    
    let itemPicture: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "ATH-M50x")
        //img.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return img
    }()
    
    let titleLabel: UILabel = {
        let titleLbl = UILabel()
        titleLbl.text = "Test Title"
        titleLbl.font = titleLbl.font.withSize(18)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        //titleLbl.backgroundColor = .blue
        return titleLbl
    }()
    
    let descLabel: UILabel = {
        let descLbl = UILabel()
        descLbl.text = "This is a place holder description text.  This is where a dscription of the item will be."
        descLbl.numberOfLines = 3
        descLbl.translatesAutoresizingMaskIntoConstraints = false
        descLbl.font = descLbl.font.withSize(14)
        return descLbl
    }()
    
    let priceLabel: UILabel = {
        let priceLbl = UILabel()
        priceLbl.text = "$20.00"
        //priceLbl.font = priceLbl.font.withSize(12)
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        //priceLbl.backgroundColor = .red
        return priceLbl
    }()
    
    let checkBoxLabel: UIImageView = {
        let checkBLbl = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        checkBLbl.image = UIImage(named: "Checkmarkempty")
        checkBLbl.translatesAutoresizingMaskIntoConstraints = false
        //checkBLbl.backgroundColor = .red
        return checkBLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(itemPicture)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        self.addSubview(priceLabel)
        self.addSubview(checkBoxLabel)
        
        itemPicture.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: imgSize, height: imgSize))
        titleLabel.anchor(top: self.itemPicture.topAnchor, leading: self.itemPicture.trailingAnchor, bottom: nil, trailing: self.priceLabel.leadingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 15))
        descLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.titleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 0, bottom: 0, right: 0), size: .init(width: 225, height: 35))
        priceLabel.anchor(top: self.titleLabel.topAnchor, leading: nil, bottom: nil, trailing: self.checkBoxLabel.leadingAnchor, padding: .init(top: 0, left: 45, bottom: 0, right: 0), size: .init(width: 75, height: 20))
        checkBoxLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 25, height: 25))
        checkBoxLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
