//
//  PeopleVC.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/25/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class PeopleVC: UITableViewController {
    
    let DH = DataHandler.standard
    var passedPeopleArray = [People]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        tableView.register(peopleCell.self, forCellReuseIdentifier: cellId)
    }
    

    //adds buttons to navBar
    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAdd))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.handleMore))
    }
    
    @objc func handleAdd(){
        //Add button is pressed
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        #warning("Testing")
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! peopleCell
        //myCell.nameLabel.text = "Matthew Wells"
        myCell.nameLabel.text = DH.data[indexPath.row].fullName
        return myCell
    }
    
    
}
