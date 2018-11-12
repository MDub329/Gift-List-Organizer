//
//  Cells.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/6/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

//Header Cell Class
class HeaderCell: UITableViewHeaderFooterView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Allows header to be updated
    func updateHeader(budgetTotal: String, budgetLeft: String) {
        self.totalBudgetLabel.text = budgetTotal
        self.remainingLabel.text = budgetLeft
    }
    
    let profilePicture: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
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
    
    let groupLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = lbl.font.withSize(14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //lbl.textAlignment = .center
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
        self.addSubview(groupLabel)
        
        profilePicture.clipsToBounds = true
        profilePicture.layer.masksToBounds = false
        
        profilePicture.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        profilePicture.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        nameLabel.anchor(top: nil, leading: self.profilePicture.trailingAnchor, bottom: nil, trailing: self.totalBudgetLabel.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        budgetTitleLabel.anchor(top: self.remainingTitleLabel.topAnchor, leading: nil, bottom: self.remainingTitleLabel.bottomAnchor, trailing: self.remainingTitleLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
        totalBudgetLabel.anchor(top: self.remainingLabel.topAnchor, leading: nil, bottom: self.remainingLabel.bottomAnchor, trailing: nil)
        totalBudgetLabel.centerXAnchor.constraint(equalTo: self.budgetTitleLabel.centerXAnchor).isActive = true
        
        remainingLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        remainingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        remainingTitleLabel.anchor(top: nil, leading: nil, bottom: remainingLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        remainingTitleLabel.centerXAnchor.constraint(equalTo: self.remainingLabel.centerXAnchor).isActive = true
        
        groupLabel.anchor(top: self.nameLabel.bottomAnchor, leading: self.nameLabel.leadingAnchor, bottom: self.bottomAnchor, trailing: self.nameLabel.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        
    }
    
}

//Footer Cell Class
class FooterCell: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(totalGiftsLabel)
        addSubview(totalGiftTitleLabel)
        addSubview(totalSpentLabel)
        addSubview(totalSpentTitleLabel)
        
        totalGiftsLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: nil ,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        totalGiftsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        totalGiftTitleLabel.centerYAnchor.constraint(equalTo: self.totalGiftsLabel.centerYAnchor).isActive = true
        totalGiftTitleLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.totalGiftsLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 5))
        
        totalSpentLabel.anchor(top: self.topAnchor, leading: self.totalSpentTitleLabel.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 0, right: 5))
        totalSpentTitleLabel.anchor(top: self.totalSpentLabel.topAnchor, leading: self.totalGiftsLabel.trailingAnchor, bottom: self.totalSpentLabel.bottomAnchor, trailing: self.totalSpentLabel.leadingAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFooter(totalSpent: String, totalCount: String) {
        totalSpentLabel.text = totalSpent
        totalGiftsLabel.text = totalCount
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
    
    let totalSpentTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total Spent:"
        lbl.font = lbl.font.withSize(14)
        lbl.backgroundColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
}


//Gift Cell Class
class GiftIdeaCell: UITableViewCell {
    
    var imgSize = 50
    
    let itemPicture: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.layer.borderWidth = 1.0
        img.layer.borderColor = #colorLiteral(red: 0.9759812116, green: 1, blue: 0.983512733, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.translatesAutoresizingMaskIntoConstraints = false
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
    
    let linkButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Link", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        //btn.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(itemPicture)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        self.addSubview(priceLabel)
        self.addSubview(checkBoxLabel)
        self.addSubview(linkButton)
        
        itemPicture.layer.masksToBounds = false
        itemPicture.clipsToBounds = true
        
        itemPicture.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: imgSize, height: imgSize))
        titleLabel.anchor(top: self.itemPicture.topAnchor, leading: self.itemPicture.trailingAnchor, bottom: nil, trailing: self.priceLabel.leadingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 55))
        descLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.titleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 0, bottom: 0, right: 0), size: .init(width: 225, height: 35))
        priceLabel.anchor(top: self.titleLabel.topAnchor, leading: nil, bottom: self.titleLabel.bottomAnchor, trailing: self.checkBoxLabel.leadingAnchor, padding: .init(top: 0, left: 45, bottom: 0, right: 0), size: .init(width: 75, height: 20))
        checkBoxLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 25, height: 25))
        checkBoxLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.selectionStyle = .none
        
        linkButton.anchor(top: self.titleLabel.topAnchor, leading: self.titleLabel.trailingAnchor, bottom: self.titleLabel.bottomAnchor, trailing: self.priceLabel.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 10))
        
    }
    
    let emptyBox = "Checkmarkempty"
    let checkBox = "Checkmark"
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class peopleCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profilePicture)
        self.addSubview(nameLabel)
        self.addSubview(completionlabel)
        
        profilePicture.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profilePicture.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        
        nameLabel.anchor(top: self.profilePicture.topAnchor, leading: self.profilePicture.trailingAnchor, bottom: self.profilePicture.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        completionlabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 5))

    }
    
    let profilePicture: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Matthew Wells"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let completionlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "completionlabel"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//CollectionView Cell
class giftCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViewsUsingAutoLayout(imageView, nameLabel, priceLabel, checkBoxLabel)
        setUpConstraints()
        
        setUpCellStyle()
    }
    
    
    func setUpCellStyle() {
        self.layer.cornerRadius = 10
        
        
    }
    
    func setUpConstraints(){
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        nameLabel.anchor(top: self.imageView.topAnchor, leading: self.imageView.trailingAnchor, bottom: self.imageView.bottomAnchor, trailing: self.priceLabel.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        priceLabel.anchor(top: self.nameLabel.topAnchor, leading: self.nameLabel.trailingAnchor, bottom: self.nameLabel.bottomAnchor, trailing: self.checkBoxLabel.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 15))
        
        checkBoxLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 25, height: 25))
        checkBoxLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    let imageView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
        img.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test Item"
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let priceLbl = UILabel()
        priceLbl.text = "$20.00"
        priceLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return priceLbl
    }()
    
    let checkBoxLabel: UIImageView = {
        let checkBLbl = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        checkBLbl.image = UIImage(named: "Checkmarkempty")
        return checkBLbl
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

