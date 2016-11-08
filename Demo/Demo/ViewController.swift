//
//  ViewController.swift
//  BTNavigationDropdownMenu
//
//  Created by Pham Ba Tho on 6/8/15.
//  Copyright (c) 2015 PHAM BA THO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectedCellLabel: UILabel!
    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Teams", "Companies"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController,
                                            containerView: self.navigationController!.view,
                                            title: "Dropdown Menu",
                                            items: items as [AnyObject],
                                            arrowImage: UIImage(named: "Chevron")!)
        menuView.cellHeight = 50

//        menuView.arrowView = arrowImage
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didHideMenu = { (selectedRows: [Int]) -> () in
            self.menuView.updateItems(items as [AnyObject])
        }
        menuView.didSelectItemAtIndexHandler = {(selectedRows: [Int]) -> () in
            if selectedRows.count == 1 {
                let items: [String]
                if selectedRows[0] == 0 {
                    items = ["Team A", "Team B"]
                } else {
                    items = ["Acme Company", "Big company", "Jennings, Herrera and Ortiz Jennings, Herrera and Ortiz"]
                }
                self.menuView.updateItems(items as [AnyObject])
            } else {
                print(selectedRows)
                self.menuView.setMenuTitle("Selected")
                self.menuView.hide()
            }
        }
        
        self.navigationItem.titleView = menuView
    }
}

