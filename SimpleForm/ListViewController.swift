//
//  ListViewController.swift
//  SimpleForm
//
//  Created by Akanksha pakhale on 25/10/21.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //setting number of row in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
   //Setting data in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        switch indexPath.row {
        case 1:
            cell.textLabel!.text = "Father name: \(data!["father"] ?? "")"
        case 2:
            cell.textLabel!.text = "Email: \(data!["email"] ?? "")"
        case 3:
            cell.textLabel!.text = "Address: \( data!["address"] ?? "")"
        case 4:
            cell.textLabel!.text = "Mobile No: \( data!["number"] ?? "")"
        case 5:
            cell.textLabel!.text = "Password : \( data!["pwd"] ?? "")"
        default:
            cell.textLabel!.text = "Name: \( data!["name"] ?? "")"
        }
        
        return cell
    }
    //oullet for table view
    @IBOutlet weak var tableView: UITableView!
    //user data
    var data:[String:String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        data = UserDefaults.standard.value(forKey: "userData") as? [String:String]
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationItem.hidesBackButton = true
    }

}
