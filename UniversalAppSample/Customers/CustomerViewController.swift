//
//  CustomerViewController.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 4/14/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController {
    
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    var customerProfileViewController: CustomerProfileViewController?
     var customerInfoViewController: CustomerInfoViewController?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightTableView.constant = tableView.contentSize.height
    }
}

extension CustomerViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        let lable = UILabel(frame: view.frame)
        view.addEdgeConstrained(subview: lable, insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        switch section {
        case 0: lable.text = "Customer Profiles"
        case 1: lable.text = "Customer Contact Information"
        default: break
        }
        view.backgroundColor = .red
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        tableCell.layoutIfNeeded()

        return tableCell
    }
    
    func addViewControllertoCell(tableCell: UITableViewCell, _ viewController: ViewControllers, storyBoard: Storyboards)  {
        tableCell.layoutIfNeeded()
            guard let message = UIStoryboard(name: storyBoard.rawValue, bundle: nil).instantiateInitialViewController() else {
                return
            }
        
        switch viewController {
        case .customerInfo:
            customerInfoViewController = message as? CustomerInfoViewController
        case .customerProfile:
            customerProfileViewController = message as? CustomerProfileViewController
        }
            
            addChild(message)
            tableCell.contentView.addEdgeConstrained(subview: message.view)
            message.didMove(toParent: self)
           message.view.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell
        switch indexPath.section {
        case 0:
            if customerProfileViewController == nil {
                addViewControllertoCell(tableCell: tableCell, ViewControllers.customerProfile, storyBoard: Storyboards.CustomerProfile)
            }
        case 1:
            if customerInfoViewController == nil {
                addViewControllertoCell(tableCell: tableCell, ViewControllers.customerInfo, storyBoard: Storyboards.ContactInfo)
            }
        default: break
        }

    }
    
}

extension UIView {
    func layoutSuperViews() {
        var view: UIView? = self
        while view != nil {
            view?.layoutIfNeeded()
            view = view?.superview ?? nil
        }
        
        while view != nil {
            view?.setNeedsLayout()
            view = view?.superview ?? nil
        }
    }
}
