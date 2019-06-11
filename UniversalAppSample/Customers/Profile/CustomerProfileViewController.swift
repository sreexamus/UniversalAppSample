//
//  CustomerProfileViewController.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/9/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

class CustomerProfileViewController: UIViewController {
   let vm = CustomerProfileViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    var profile: CustomerData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.fetchCustomerProfileData(customerId: 232) { [weak self] result in
            switch result {
            case .success(let model):
                self?.profile = model
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Profile Error", message: error?.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("super.viewWillAppear(animated)...")
    }
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            heightTableView.constant = tableView.contentSize.height
            view.layoutIfNeeded()
        }
}

extension CustomerProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath ..... \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let profile = profile else {
            return UITableViewCell()
        }
        print("indexPath.row]  \(indexPath.row)")
        switch indexPath.row {
        case 0:
            print("profile.profiles[indexPath.section].firstName.")
            print(profile.profiles[indexPath.section].firstName)
            cell.textLabel?.text = profile.profiles[indexPath.section].firstName
        case 1:
              print("profile.profiles[indexPath.section].lastName...")
              print(profile.profiles[indexPath.section].lastName)
            cell.textLabel?.text = profile.profiles[indexPath.section].lastName
        case 2:
            cell.textLabel?.text = String(profile.profiles[indexPath.section].age)
        case 3:
            cell.textLabel?.text = String(profile.profiles[indexPath.section].id)
        case 4:
            cell.textLabel?.text = String(profile.profiles[indexPath.section].badgeNo)
        case 5:
            cell.textLabel?.text = profile.profiles[indexPath.section].city
        case 6:
            cell.textLabel?.text = profile.profiles[indexPath.section].country
        case 7:
            cell.textLabel?.text = profile.profiles[indexPath.section].bloodGroup.rawValue
        default: break
        }
        
        return cell
    }
    
}
