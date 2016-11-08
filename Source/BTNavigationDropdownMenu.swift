//
//  BTConfiguration.swift
//  BTNavigationDropdownMenu
//
//  Created by Pham Ba Tho on 6/30/15.
//  Copyright (c) 2015 PHAM BA THO. All rights reserved.
//

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import SnapKit

// MARK: BTNavigationDropdownMenu
open class BTNavigationDropdownMenu: UIView {

    // The color of menu title. Default is darkGrayColor()
    open var menuTitleColor: UIColor! {
        get {
            return self.configuration.menuTitleColor
        }
        set(value) {
            self.configuration.menuTitleColor = value
        }
    }

    // The height of the cell. Default is 50
    open var cellHeight: NSNumber! {
        get {
            return NSNumber(value: Float(self.configuration.cellHeight))
        }
        set(value) {
            self.configuration.cellHeight = CGFloat(value)
        }
    }

    // The color of the cell background. Default is whiteColor()
    open var cellBackgroundColors: [UIColor]? {
        get {
            return self.configuration.cellBackgroundColors
        }
        set(color) {
            self.configuration.cellBackgroundColors = color
            self.tableView?.tableHeaderView?.backgroundColor = color?.first
        }
    }

    open var cellSeparatorColor: UIColor! {
        get {
            return self.configuration.cellSeparatorColor
        }
        set(value) {
            self.configuration.cellSeparatorColor = value
        }
    }

    // The color of the text inside cell. Default is darkGrayColor()
    open var cellTextLabelColor: UIColor! {
        get {
            return self.configuration.cellTextLabelColor
        }
        set(value) {
            self.configuration.cellTextLabelColor = value
        }
    }

    // The color of the text inside a selected cell. Default is darkGrayColor()
    open var selectedCellTextLabelColor: UIColor! {
        get {
            return self.configuration.selectedCellTextLabelColor
        }
        set(value) {
            self.configuration.selectedCellTextLabelColor = value
        }
    }

    // The font of the text inside cell. Default is HelveticaNeue-Bold, size 17
    open var cellTextLabelFont: UIFont! {
        get {
            return self.configuration.cellTextLabelFont
        }
        set(value) {
            self.configuration.cellTextLabelFont = value
        }
    }

    // The font of the navigation bar title. Default is HelveticaNeue-Bold, size 17
    open var navigationBarTitleFont: UIFont! {
        get {
            return self.configuration.navigationBarTitleFont
        }
        set(value) {
            self.configuration.navigationBarTitleFont = value
            self.menuTitle.font = self.configuration.navigationBarTitleFont
        }
    }

    // The alignment of the text inside cell. Default is .Left
    open var cellTextLabelAlignment: NSTextAlignment! {
        get {
            return self.configuration.cellTextLabelAlignment
        }
        set(value) {
            self.configuration.cellTextLabelAlignment = value
        }
    }

    // The color of the cell when the cell is selected. Default is lightGrayColor()
    open var cellSelectionColor: UIColor! {
        get {
            return self.configuration.cellSelectionColor
        }
        set(value) {
            self.configuration.cellSelectionColor = value
        }
    }

    // The checkmark icon of the cell
    open var checkMarkImage: UIImage! {
        get {
            return self.configuration.checkMarkImage
        }
        set(value) {
            self.configuration.checkMarkImage = value
        }
    }

    // The boolean value that decides if selected color of cell is visible when the menu is shown. Default is false
    open var shouldKeepSelectedCellColor: Bool! {
        get {
            return self.configuration.shouldKeepSelectedCellColor
        }
        set(value) {
            self.configuration.shouldKeepSelectedCellColor = value
        }
    }

    // The animation duration of showing/hiding menu. Default is 0.3
    open var animationDuration: TimeInterval! {
        get {
            return self.configuration.animationDuration
        }
        set(value) {
            self.configuration.animationDuration = value
        }
    }

//    // The arrow next to navigation title
//    public var arrowView: UIView! {
//        didSet {
//            configuration.arrowView = arrowView
//        }
//    }

    // The color of the mask layer. Default is blackColor()
    open var maskBackgroundColor: UIColor! {
        get {
            return self.configuration.maskBackgroundColor
        }
        set(value) {
            self.configuration.maskBackgroundColor = value
        }
    }

    // The opacity of the mask layer. Default is 0.3
    open var maskBackgroundOpacity: CGFloat! {
        get {
            return self.configuration.maskBackgroundOpacity
        }
        set(value) {
            self.configuration.maskBackgroundOpacity = value
        }
    }

    // The boolean value that decides if you want to change the title text when a cell is selected. Default is true
    open var shouldChangeTitleText: Bool! {
        get {
            return self.configuration.shouldChangeTitleText
        }
        set(value) {
            self.configuration.shouldChangeTitleText = value
        }
    }

    open var didSelectItemAtIndexHandler: ((_ selectedRows: [Int]) -> ())?
    open var didHideMenu: ((_ selectedRows: [Int]) -> ())?
    open var isShown: Bool!

    fileprivate weak var navigationController: UINavigationController?
    fileprivate var configuration = BTConfiguration()
    fileprivate var topSeparator: UIView!
    fileprivate var menuButton: UIButton!
    fileprivate var menuTitle: UILabel!
    fileprivate var backgroundView: UIView!
    fileprivate var tableView: BTTableView!
    fileprivate var items: [AnyObject]!
    fileprivate var menuWrapper: UIView!
    fileprivate var arrowView: UIImageView!
    fileprivate var selectedRows: [Int] = []
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(navigationController: UINavigationController? = nil, containerView: UIView = UIApplication.shared.keyWindow!, title: String, items: [AnyObject], arrowImage: UIImage) {
        // Key window
        guard let window = UIApplication.shared.keyWindow else {
            super.init(frame: CGRect.zero)
            return
        }

        // Navigation controller
        if let navigationController = navigationController {
            self.navigationController = navigationController
        } else {
            self.navigationController = window.rootViewController?.topMostViewController?.navigationController
        }

        // Get titleSize


        // Set frame
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.navigationController!.navigationBar.frame.width,
                           height: self.navigationController!.navigationBar.frame.height)

        super.init(frame:frame)

        self.isShown = false
        self.items = items

        // Init button as navigation title
        self.menuButton = UIButton(frame: CGRect(x: 0,y: 0,width: frame.size.width,height: frame.size.height))
        self.menuButton.addTarget(self, action: #selector(BTNavigationDropdownMenu.menuButtonTapped(_:)), for: UIControlEvents.touchUpInside)

        self.addSubview(self.menuButton)

        self.menuTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.menuButton.frame.width, height: self.menuButton.frame.height))
        self.menuTitle.text = title
        self.menuTitle.textColor = self.menuTitleColor
        self.menuTitle.font = self.configuration.navigationBarTitleFont
        self.menuTitle.textAlignment = .center
        self.arrowView = UIImageView(image: arrowImage)
        self.menuButton.addSubview(menuTitle)
        self.menuButton.addSubview(arrowView)
        self.menuTitle.snp.makeConstraints{ (make) in
            make.top.equalTo(menuButton)
            make.left.greaterThanOrEqualTo(10)
            make.bottom.equalTo(menuButton)
            make.center.equalTo(menuButton.snp.center)
        }
        self.arrowView.snp.makeConstraints{ (make) in
            make.width.equalTo(arrowImage.size.width)
            make.height.equalTo(arrowImage.size.height)
            make.centerY.equalTo(menuButton.snp.centerY)
            make.left.equalTo(menuTitle.snp.right).offset(10)
            make.right.lessThanOrEqualTo(-10)
        }
        menuTitle.sizeToFit()


        let menuWrapperBounds = window.bounds

        // Set up DropdownMenu
        self.menuWrapper = UIView(frame: CGRect(x: menuWrapperBounds.origin.x, y: 0, width: menuWrapperBounds.width, height: menuWrapperBounds.height))
        self.menuWrapper.clipsToBounds = true
        self.menuWrapper.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]

        // Init background view (under table view)
        self.backgroundView = UIView(frame: menuWrapperBounds)
        self.backgroundView.backgroundColor = self.configuration.maskBackgroundColor
        self.backgroundView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]

        let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BTNavigationDropdownMenu.hideMenu));
        self.backgroundView.addGestureRecognizer(backgroundTapRecognizer)

        // Init properties
        self.setupDefaultConfiguration()

        // Init table view
        let navBarHeight = self.navigationController?.navigationBar.bounds.size.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        self.tableView = BTTableView(frame: CGRect(x: menuWrapperBounds.origin.x, y: menuWrapperBounds.origin.y + 0.5, width: menuWrapperBounds.width, height: menuWrapperBounds.height + 300 - navBarHeight - statusBarHeight), items: items, title: title, configuration: self.configuration)

        self.tableView.selectRowAtIndexPathHandler = { [weak self] (indexPath: Int) -> () in
            guard let weakSelf = self else {
                return
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
                weakSelf.navigationController?.navigationBar.barTintColor = weakSelf.configuration.cellBackgroundColor(atRow: indexPath)
                }, completion: nil)
            if weakSelf.shouldChangeTitleText! {
                weakSelf.setMenuTitle("\(weakSelf.tableView.items[indexPath])")
            }
            weakSelf.selectedRows.append(indexPath)
            weakSelf.didSelectItemAtIndexHandler?(weakSelf.selectedRows)
            weakSelf.layoutSubviews()
        }

        // Add background view & table view to container view
        self.menuWrapper.addSubview(self.backgroundView)
        self.menuWrapper.addSubview(self.tableView)

        // Add Line on top
        self.topSeparator = UIView(frame: CGRect(x: 0, y: 0, width: menuWrapperBounds.size.width, height: 1))
        self.topSeparator.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.menuWrapper.addSubview(self.topSeparator)

        // Add Menu View to container view
        containerView.addSubview(self.menuWrapper)

        // By default, hide menu view
        self.menuWrapper.isHidden = true
    }

    override open func layoutSubviews() {
        //        self.menuTitle.sizeToFit()
        //        self.menuTitle.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.menuTitle.textColor = self.configuration.menuTitleColor
        self.menuWrapper.frame.origin.y = self.navigationController!.navigationBar.frame.maxY
        self.tableView.reloadData()
    }

    open func show() {
        if self.isShown == false {
            self.showMenu()
        }
    }

    open func hide() {
        if self.isShown == true {
            self.hideMenu()
        }
    }

    open func toggle() {
        if(self.isShown == true) {
            self.hideMenu();
        } else {
            self.showMenu();
        }
    }

    open func updateItems(_ items: [AnyObject]) {
        if !items.isEmpty {
            tableView.selectedIndexPath = nil
            tableView.items = items
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: false)
            }

            UIView.transition(with: tableView, duration: 0.4, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
        }
    }

    func setupDefaultConfiguration() {
        self.menuTitleColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
        self.cellBackgroundColors = [self.navigationController?.navigationBar.barTintColor ?? UIColor.white]
        self.cellSeparatorColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
        self.cellTextLabelColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
    }

    func showMenu() {
        self.menuWrapper.frame.origin.y = self.navigationController!.navigationBar.frame.maxY

        self.isShown = true

        // Table view header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 300))
        headerView.backgroundColor = self.configuration.cellBackgroundColors?.first
        self.tableView.tableHeaderView = headerView

        self.topSeparator.backgroundColor = UIColor.white

        // Rotate arrow
        self.rotateArrow()

        // Visible menu view
        self.menuWrapper.isHidden = false

        // Change background alpha
        self.backgroundView.alpha = 0

        // Animation
        self.tableView.frame.origin.y = -CGFloat(self.items.count) * self.configuration.cellHeight - 300

        // Reload data to dismiss highlight color of selected cell
        self.tableView.reloadData()

        self.menuWrapper.superview?.bringSubview(toFront: self.menuWrapper)

        UIView.animate(
            withDuration: self.configuration.animationDuration * 1.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.tableView.frame.origin.y = CGFloat(-300)
                self.backgroundView.alpha = self.configuration.maskBackgroundOpacity
            }, completion: nil
        )
    }

    func hideMenu() {


        // Rotate arrow
        self.rotateArrow()

        self.isShown = false

        // Change background alpha
        self.backgroundView.alpha = self.configuration.maskBackgroundOpacity

        UIView.animate(
            withDuration: self.configuration.animationDuration * 1.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.tableView.frame.origin.y = CGFloat(-200)
            }, completion: nil
        )

        // Animation
        UIView.animate(
            withDuration: self.configuration.animationDuration,
            delay: 0,
            options: UIViewAnimationOptions(),
            animations: {
                self.tableView.frame.origin.y = -CGFloat(self.items.count) * self.configuration.cellHeight - 300
                self.backgroundView.alpha = 0
            }, completion: { _ in
                if self.isShown == false && self.tableView.frame.origin.y == -CGFloat(self.items.count) * self.configuration.cellHeight - 300 {
                    self.menuWrapper.isHidden = true
                }
                self.didHideMenu?(self.selectedRows)
                self.selectedRows = []
        })
    }

    func rotateArrow() {
        if let arrowView = self.arrowView {
            UIView.animate(withDuration: self.configuration.animationDuration, animations: { () -> () in
                let rotate = arrowView.transform.rotated(by: 180 * CGFloat(M_PI/180))
                arrowView.transform = rotate
            })
        }
    }

    open func setMenuTitle(_ title: String) {
        self.menuTitle.text = title
        layoutSubviews()
    }

    func menuButtonTapped(_ sender: UIButton) {
        self.isShown == true ? hideMenu() : showMenu()
    }
}

// MARK: BTConfiguration
class BTConfiguration {
    var menuTitleColor: UIColor?
    var cellHeight: CGFloat!
    var cellBackgroundColors: [UIColor]?
    var cellSeparatorColor: UIColor?
    var cellTextLabelColor: UIColor?
    var selectedCellTextLabelColor: UIColor?
    var cellTextLabelFont: UIFont!
    var navigationBarTitleFont: UIFont!
    var cellTextLabelAlignment: NSTextAlignment!
    var cellSelectionColor: UIColor?
    var checkMarkImage: UIImage!
    var shouldKeepSelectedCellColor: Bool!
    var arrowTintColor: UIColor?
    var arrowView: UIView? = nil
    var animationDuration: TimeInterval!
    var maskBackgroundColor: UIColor!
    var maskBackgroundOpacity: CGFloat!
    var shouldChangeTitleText: Bool!

    init() {
        self.defaultValue()
    }

    func cellBackgroundColor(atRow row: Int) -> UIColor? {
        guard let cellBackgroundColors = cellBackgroundColors else { return nil }
        return cellBackgroundColors[row % cellBackgroundColors.count]
    }

    func defaultValue() {
        // Path for image
        let bundle = Bundle(for: BTConfiguration.self)
        let url = bundle.url(forResource: "BTNavigationDropdownMenu", withExtension: "bundle")
        let imageBundle = Bundle(url: url!)
        let checkMarkImagePath = imageBundle?.path(forResource: "checkmark_icon", ofType: "png")

        // Default values
        self.menuTitleColor = UIColor.darkGray
        self.cellHeight = 50
        self.cellBackgroundColors = [UIColor.white]
        self.arrowTintColor = UIColor.white
        self.cellSeparatorColor = UIColor.darkGray
        self.cellTextLabelColor = UIColor.darkGray
        self.selectedCellTextLabelColor = UIColor.darkGray
        self.cellTextLabelFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
        self.navigationBarTitleFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
        self.cellTextLabelAlignment = NSTextAlignment.left
        self.cellSelectionColor = UIColor.lightGray
        self.checkMarkImage = UIImage(contentsOfFile: checkMarkImagePath!)
        self.shouldKeepSelectedCellColor = false
        self.animationDuration = 0.5
        self.maskBackgroundColor = UIColor.black
        self.maskBackgroundOpacity = 0.3
        self.shouldChangeTitleText = true
    }
}

// MARK: Table View
class BTTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    // Public properties
    var configuration: BTConfiguration!
    var selectRowAtIndexPathHandler: ((_ indexPath: Int) -> ())?

    // Private properties
    fileprivate var items: [AnyObject]!
    fileprivate var selectedIndexPath: Int?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, items: [AnyObject], title: String, configuration: BTConfiguration) {
        super.init(frame: frame, style: UITableViewStyle.plain)

        self.items = items
        self.selectedIndexPath = (items as! [String]).index(of: title)
        self.configuration = configuration

        // Setup table view
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clear
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        //        self.separatorEffect = UIBlurEffect(style: .Light)
        self.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event), hitView.isKind(of: BTTableCellContentView.self) {
            return hitView
        }
        return nil;
    }

    // Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.configuration.cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BTTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell", configuration: self.configuration)
        cell.textLabel?.text = self.items[indexPath.row] as? String
        cell.contentView.backgroundColor = configuration.cellBackgroundColor(atRow: indexPath.row)
        cell.textLabel?.textColor = self.configuration.cellTextLabelColor
        cell.checkmarkIcon.isHidden = (indexPath.row == selectedIndexPath) ? false : true
        return cell
    }

    // Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath.row
        self.selectRowAtIndexPathHandler!(indexPath.row)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? BTTableViewCell
        cell?.checkmarkIcon.isHidden = true
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.configuration.shouldKeepSelectedCellColor == true {
            cell.backgroundColor = self.configuration.cellBackgroundColor(atRow: indexPath.row)
            cell.contentView.backgroundColor = (indexPath.row == selectedIndexPath) ? self.configuration.cellSelectionColor : self.configuration.cellBackgroundColor(atRow: indexPath.row)
        }
    }
}

// MARK: Table view cell
class BTTableViewCell: UITableViewCell {
    let checkmarkIconWidth: CGFloat = 50
    let horizontalMargin: CGFloat = 20

    var checkmarkIcon: UIImageView!
    var cellContentFrame: CGRect!
    var configuration: BTConfiguration!

    init(style: UITableViewCellStyle, reuseIdentifier: String?, configuration: BTConfiguration) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.configuration = configuration

        // Setup cell
        cellContentFrame = CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.width)!, height: self.configuration.cellHeight)
        self.contentView.backgroundColor = self.configuration.cellBackgroundColor(atRow: 0)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.textLabel!.textColor = self.configuration.cellTextLabelColor
        self.textLabel!.font = self.configuration.cellTextLabelFont
        self.textLabel!.textAlignment = self.configuration.cellTextLabelAlignment
        self.textLabel?.snp.removeConstraints()
        self.textLabel?.snp.makeConstraints{ (make) in
            make.left.equalTo(contentView).offset(horizontalMargin)
            make.right.equalTo(contentView).offset(-horizontalMargin)
            make.top.equalTo(contentView).offset(-2)
            make.bottom.equalTo(contentView).offset(-2)
        }

        // Checkmark icon
        if self.textLabel!.textAlignment == .center {
            self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
        } else if self.textLabel!.textAlignment == .left {
            self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
        } else {
            self.checkmarkIcon = UIImageView(frame: CGRect(x: horizontalMargin, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
        }
        self.checkmarkIcon.isHidden = true
        self.checkmarkIcon.image = self.configuration.checkMarkImage
        self.checkmarkIcon.contentMode = UIViewContentMode.scaleAspectFill
        self.contentView.addSubview(self.checkmarkIcon)

        // Separator for cell
        let separator = BTTableCellContentView(frame: cellContentFrame)
        if let cellSeparatorColor = self.configuration.cellSeparatorColor {
            separator.separatorColor = cellSeparatorColor
        }
        self.contentView.addSubview(separator)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.bounds = cellContentFrame
        self.contentView.frame = self.bounds
    }
}

// Content view of table view cell
class BTTableCellContentView: UIView {
    var separatorColor: UIColor = UIColor.black

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    func initialize() {
        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Set separator color of dropdown menu based on barStyle
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(1 * UIScreen.main.scale)
        context.move(to: CGPoint(x: 0, y: self.bounds.size.height))
        context.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
        context.strokePath()
    }
}

extension UIViewController {
    // Get ViewController in top present level
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while (target?.presentedViewController != nil) {
            target = target?.presentedViewController
        }
        return target
    }

    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController.topVisibleViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return selectedViewController.topVisibleViewController
            }
        }
        return self
    }
    
    // Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    var topMostViewController: UIViewController? {
        return self.topPresentedViewController?.topVisibleViewController
    }
}
