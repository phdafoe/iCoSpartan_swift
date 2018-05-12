//
//  ListaEntrenamientosTableViewController.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 7/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class ListaEntrenamientosTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = UIScreen.main.bounds.width - 50.0
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    
    

}
