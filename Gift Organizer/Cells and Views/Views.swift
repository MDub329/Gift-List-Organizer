//
//  Views.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/7/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

class AddPopupView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addView)
        addSubview(saveButton)
        
        saveButton.anchor(top: nil, leading: nil, bottom: addView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: 100, height: 100))
        saveButton.centerXAnchor.constraint(equalTo: addView.centerXAnchor).isActive = true
        

        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addView: UIView = {
        let view = UIView()
        //view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = .red
        
        return view
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .blue
        return btn
    }()
    
}
