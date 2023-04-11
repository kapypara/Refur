//
//  CartViewController.swift
//  Refur
//
//  Created by iOSdev on 11/04/2023.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
    

    var allSelected = false
    var items = [Item.Clothing(name: "", description: "", condition: .BrandNew, price: 1.2, type: .Shoes, brnad: " ", size: .XL)]
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    @IBAction func selectAllPressed(_ sender: Any) {
        allSelected = true
        cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
            
            // Configure the cell...
            let item = items[indexPath.row]
            cell.itemNameLbl.text = item.name
            cell.usernameLbl.text = "@JohnDoe"
            cell.priceLabel.text = "BD" + String(item.price)
            if allSelected {
                cell.isChosen.isSelected = true
            }
            return cell
        
    }
    
    
    // MARK: - Navigation

}
