//
//  AddPopupView.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/7/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import UIKit

class AddPopupView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(addView)
        self.addView.addSubview(saveButton)
        self.addView.addSubview(cancelButton)
        self.addView.addSubview(titleLabel)
        self.addView.addSubview(descLabel)
        self.addView.addSubview(priceLabel)
        self.addView.addSubview(urlLabel)
        self.addView.addSubview(titleTextField)
        self.addView.addSubview(descTextField)
        self.addView.addSubview(priceTextField)
        self.addView.addSubview(urlTextfield)
        self.addView.addSubview(addImgButton)
        self.addView.addSubview(imgView)
        self.hideKeyboardWhenTappedAround()
        
        setUpConstraints()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    
    func setUpConstraints() {
        saveButton.anchor(top: self.imgView.bottomAnchor, leading: self.addView.leadingAnchor, bottom: self.addView.bottomAnchor, trailing: self.cancelButton.leadingAnchor, padding: .init(top: 5, left: 65, bottom: 5, right: 10))
        
        cancelButton.anchor(top: self.imgView.bottomAnchor, leading: self.saveButton.trailingAnchor, bottom: self.addView.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 65))
        //saveButton.centerXAnchor.constraint(equalTo: addView.centerXAnchor).isActive = true
        
        titleLabel.anchor(top: self.addView.topAnchor, leading: self.addView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 25, bottom: 0, right: 0), size: .init(width: 50, height: 30))
        titleTextField.anchor(top: self.titleLabel.topAnchor, leading: self.titleLabel.trailingAnchor, bottom: self.titleLabel.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 35))
        
        descLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.titleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 30))
        descTextField.anchor(top: self.descLabel.topAnchor, leading: self.titleTextField.leadingAnchor, bottom: self.descLabel.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 35))
        
        priceLabel.anchor(top: self.descLabel.bottomAnchor, leading: self.titleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 30))
        priceTextField.anchor(top: self.priceLabel.topAnchor, leading: self.titleTextField.leadingAnchor, bottom: self.priceLabel.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 35))
        
        urlLabel.anchor(top: self.priceLabel.bottomAnchor, leading: self.titleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 30))
        urlTextfield.anchor(top: self.urlLabel.topAnchor, leading: self.titleTextField.leadingAnchor, bottom: self.urlLabel.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 35))
        
        addImgButton.anchor(top: self.urlLabel.bottomAnchor, leading: self.urlLabel.leadingAnchor, bottom: self.saveButton.topAnchor, trailing: nil,padding: .init(top: 50, left: 0, bottom: 50, right: 0), size: .init(width: 100, height: 30))
        imgView.anchor(top: self.urlLabel.bottomAnchor, leading: self.addImgButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 20, right: 20), size: .init(width: 100, height: 100))
        
        addView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
    let addView: UIView = {
        let view = UIView()
        //view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        
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
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.blue, for: .normal)
        //btn.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        btn.clipsToBounds = true
        return btn
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Desc:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Price:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let urlLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Link:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Image:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let titleTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.placeholder = "Enter Name of Gift"
        field.textAlignment = .center
        field.autocapitalizationType = .none
        return field
    }()
    
    let descTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.placeholder = "Enter Gift Description"
        field.textAlignment = .center
        field.autocapitalizationType = .none
        return field
    }()
    
    let priceTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = UIKeyboardType.decimalPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.placeholder = "0.00"
        field.textAlignment = .center
        field.autocapitalizationType = .none
        return field
    }()
    
    let urlTextfield: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.placeholder = "Enter Link to Gift"
        field.textAlignment = .center
        field.autocapitalizationType = .none
        return field
    }()
    
    let addImgButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add Image", for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        return btn
    }()
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let theinfo:NSDictionary = info as NSDictionary
        let img:UIImage = theinfo.object(forKey: UIImagePickerController.InfoKey.originalImage) as! UIImage
        
        
        self.imgView.image = img
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/2
            }
        }
    }

}
