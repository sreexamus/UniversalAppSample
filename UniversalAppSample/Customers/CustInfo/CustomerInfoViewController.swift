//
//  CustomerInfoViewController.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/9/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

class CustomerInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    let viewModel = CustomerInfoViewModel()
    var info: CustomerContactInfoData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCustomerContactInfo { [weak self] result in
            switch result {
            case .success(let custInfo):
                print("custInfo....")
                print(custInfo)
                self?.info = custInfo
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Info Error", message: error?.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightTableView.constant = tableView.contentSize.height
        view.layoutIfNeeded()
    }
}

extension CustomerInfoViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("indexPath ..... \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let info = info else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = info.info[indexPath.section].firstName
        case 1:
            cell.textLabel?.text = info.info[indexPath.section].address
        case 2:
            cell.textLabel?.text = String(info.info[indexPath.section].apartmentNo)
        case 3:
            cell.textLabel?.text = String(info.info[indexPath.section].email)
        case 4:
            cell.textLabel?.text = String(info.info[indexPath.section].linkedin)
        case 5:
            cell.textLabel?.text = info.info[indexPath.section].phoneNumber
        case 6:
            cell.textLabel?.text = info.info[indexPath.section].employer
        default: break
        }
        return cell
    }
}
