//
//  NavController.swift
//  Gift Organizer
//
//  Created by Matthew Wells on 10/25/18.
//  Copyright © 2018 Matthew Wells. All rights reserved.
//

import Foundation
import UIKit

class NavVC: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.present(HomeController(), animated: true, completion: nil)
    }
}
