//
//  CartViewController.swift
//  Refur
//
//  Created by iOSdev on 11/04/2023.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyCartMessage: UILabel!

    @IBOutlet weak var selectAllButton: UIBarButtonItem!
    
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emptyCartMessage.isHidden = Cart.cart.isEmpty ? false : true
        checkoutButton.isHidden = Cart.cart.isEmpty ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    
    @objc func updateSelectionButton() {
        allSelected.toggle()
        cartTableView.reloadData()
        
        let newTitle = allSelected ? "Deselect All" : "Select All"
        let barButton = UIBarButtonItem(title: newTitle,
                                        style: .plain,
                                        target: self,
                                        action: #selector(updateSelectionButton))
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    var allSelected: Bool = false {
        didSet {
            for i in 0 ..< Cart.cart.count {
                Cart.cart[i].selected = allSelected
            }
            
            //updateSelectionButton()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Cart.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        
        cell.setupCell(post: Cart.cart[indexPath.row].cartItem, selection: Cart.cart[indexPath.row].selected)
        
        return cell
        
    }
    
    @IBAction func selectAllPressed(_ sender: Any) {
        //allSelected.toggle()
        //cartTableView.reloadData()
        updateSelectionButton()
    }
    
    
    // MARK: - Navigation
    
}
