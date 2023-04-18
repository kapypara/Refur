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
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    

    var allSelected: Bool = false {
        didSet {
            for i in 0 ..< Cart.cart.count {
                Cart.cart[i].selected = allSelected
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emptyCartMessage.isHidden = Cart.cart.isEmpty ? false : true
        checkoutButton.isHidden = Cart.cart.isEmpty ? true : false
        
        if Cart.cart.isEmpty {
            emptyCartMessage.isHidden = false
            checkoutButton.isHidden = true
            self.navigationItem.leftBarButtonItem = nil
        } else {
            emptyCartMessage.isHidden = true
            checkoutButton.isHidden = false
            updateSelectionButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    
    func updateSelectionButton() {
        
        let newTitle = allSelected ? "Deselect All" : "Select All"
        let barButton = UIBarButtonItem(title: newTitle,
                                        style: .plain,
                                        target: self,
                                        action: #selector(selectAllButton))
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func selectAllButton() {
            allSelected.toggle()
            cartTableView.reloadData()
            updateSelectionButton()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCheckout" {
            guard let viewController = segue.destination as? CheckoutTableViewController else {return}
            
            for i in 0 ..< Cart.cart.count {
                if Cart.cart[i].selected {
                    viewController.checkoutItems[i] = Cart.cart[i].cartItem
                }
            }
            
        }
    }
    
    // MARK: - Navigation
    
}
