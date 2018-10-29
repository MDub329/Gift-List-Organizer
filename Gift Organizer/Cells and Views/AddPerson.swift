//
//  AddPerson.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/26/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class AddPerson: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let DH = DataHandler.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(addView)
        self.addView.addSubview(imgView)
        self.addView.addSubview(nameTextField)
        self.addView.addSubview(nameLabel)
        self.addView.addSubview(groupTextField)
        self.addView.addSubview(groupLabel)
        self.addView.addSubview(budgetLabel)
        self.addView.addSubview(budgetTextField)
        self.addView.addSubview(notesLabel)
        self.addView.addSubview(notesTextField)
        self.addView.addSubview(progressBar)
        self.addView.addSubview(barLabel)
        self.addView.addSubview(imgButton)
       // self.addView.addSubview(giftCollectionView)
        self.hideKeyboardWhenTappedAround()
        
        let tapReconizer = UITapGestureRecognizer(target: self, action: #selector(self.handleImgViewTap))
        self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(tapReconizer)
        
        self.imgButton.addTarget(self, action: #selector(self.handleImgBtnTap), for: .touchUpInside)
        
        setUpConstraints()
        miscSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setProgressBarValue()
    }
    
    func setProgressBarValue(){
        let spent = DH.data[DH.personIndex].spentBudget
        let value = spent/DH.data[DH.personIndex].totalBudget
        self.progressBar.progress = Float(value)
    }
    
    func clearFields(){
        self.nameTextField.text = ""
        self.groupTextField.text = ""
        self.notesTextField.text = ""
        self.budgetTextField.text = ""
        self.imgView.image = nil
    }
    
    //Image View is tapped
    @objc func handleImgViewTap(Sender: UITapGestureRecognizer) {
        //Make image bigger to inspect
        let imageView = Sender.view as! UIImageView
        let fullScreenImageView = UIImageView(image: imageView.image)
        fullScreenImageView.frame = UIScreen.main.bounds
        fullScreenImageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)
        fullScreenImageView.contentMode = .scaleAspectFit
        fullScreenImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleFullScreenDismiss(Sender:)))
        fullScreenImageView.addGestureRecognizer(tap)
        
        #warning("Animate Image")
        
        
        self.view.addSubview(fullScreenImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    //Dismiss imageView when tapped
    @objc func handleFullScreenDismiss(Sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        Sender.view?.removeFromSuperview()
    }
    
    //User Chooses camera or library
    @objc func handleImgBtnTap() {
        let image = UIImagePickerController()
        image.delegate = self
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            image.sourceType = UIImagePickerController.SourceType.camera
            self.present(image, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(image, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //Set Constraints
    func setUpConstraints() {
        self.addView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        
        imgView.anchor(top: self.addView.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        
        nameLabel.anchor(top: self.imgView.topAnchor, leading: self.nameTextField.leadingAnchor, bottom: nil, trailing: self.addView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        nameTextField.anchor(top: self.nameLabel.bottomAnchor, leading: self.imgView.trailingAnchor, bottom: nil, trailing: self.addView.trailingAnchor, padding: .init(top: 5, left: 25, bottom: 0, right: 25), size: .init(width: 0, height: 25))
        
        groupLabel.anchor(top: self.nameTextField.bottomAnchor, leading: self.nameTextField.leadingAnchor, bottom: nil, trailing: self.addView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        groupTextField.anchor(top: self.groupLabel.bottomAnchor, leading: self.nameTextField.leadingAnchor, bottom: nil, trailing: self.addView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 25), size: .init(width: 0, height: 25))
        
        budgetLabel.anchor(top: self.imgButton.bottomAnchor, leading: self.imgButton.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        budgetTextField.anchor(top: self.budgetLabel.bottomAnchor, leading: self.budgetLabel.leadingAnchor, bottom: nil, trailing: self.budgetLabel.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: -20), size: .init(width: 80, height: 25))
        
        notesLabel.anchor(top: self.budgetTextField.bottomAnchor, leading: self.budgetTextField.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        notesTextField.anchor(top: self.notesLabel.bottomAnchor, leading: self.notesLabel.leadingAnchor, bottom: nil, trailing: self.addView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 25), size: .init(width: 0, height: 25))
        
        progressBar.anchor(top: self.budgetTextField.topAnchor, leading: self.imgView.trailingAnchor, bottom: self.budgetTextField.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 25))
        barLabel.anchor(top: self.budgetLabel.topAnchor, leading: self.progressBar.leadingAnchor, bottom: self.budgetLabel.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        imgButton.anchor(top: self.imgView.bottomAnchor, leading: self.imgView.leadingAnchor, bottom: self.budgetLabel.topAnchor, trailing: self.imgView.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        //giftCollectionView.anchor(top: self.notesLabel.bottomAnchor, leading: self.addView.leadingAnchor, bottom: self.addView.bottomAnchor, trailing: self.addView.trailingAnchor, padding: .init(top: 10, left: 15, bottom: 15, right: 15))
    }
    
    //View and Keyboard Obvserver
    func miscSetup() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    //Views Created
    let addView: UIView = {
        let view = UIView()
        //view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.placeholder = "Enter Name"
        field.textAlignment = .center
        field.autocapitalizationType = .none
        return field
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Name"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let groupTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.placeholder = "Enter Group"
        field.textAlignment = .center
        field.autocapitalizationType = .none
        return field
    }()
    
    let groupLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Group"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let budgetTextField: UITextField = {
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
    
    let budgetLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Budget"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        img.layer.cornerRadius = img.frame.size.height/2
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        return img
    }()
    
    let notesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Notes"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let notesTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = UIKeyboardType.decimalPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 2
        field.layer.cornerRadius = 5
        field.autocapitalizationType = .none
        return field
    }()
    
    let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.layer.cornerRadius = 10
        bar.layer.borderWidth = 2
        bar.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        bar.clipsToBounds = true
        bar.progressViewStyle = .bar
        bar.layer.masksToBounds = false
        
        return bar
    }()
    
    let barLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Progress Bar"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        return btn
    }()
    
//    let giftCollectionView: UICollectionView = {
//        let cv = UICollectionView()
//        cv.collectionViewLayout = UICollectionViewFlowLayout()
//        cv.backgroundColor = .blue
//        return cv
//    }()
    
    
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
