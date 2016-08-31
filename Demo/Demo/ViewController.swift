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
        let arrowImage = UIImageView(image: UIImage(named: "Chevron")!)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: arrowImage)
        let items = ["Teams", "Companies"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)

        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items)
        menuView.cellHeight = 50

        menuView.arrowView = arrowImage
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didHideMenu = { (selectedRows: [Int]) -> () in
            self.menuView.updateItems(items)
        }
        menuView.didSelectItemAtIndexHandler = {(selectedRows: [Int]) -> () in
            if selectedRows.count == 1 {
                if selectedRows[0] == 0 {
                    self.menuView.updateItems([ "Team A", "Team B"])
                } else {
                    self.menuView.updateItems([ "Acme Company", "Big company"])
                }
            } else {
                print(selectedRows)
                self.menuView.setMenuTitle("Selected")
                self.menuView.hide()
            }
        }
        
        self.navigationItem.titleView = menuView
    }
}

