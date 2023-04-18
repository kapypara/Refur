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
                Cart.cart[i].selection = allSelected
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    
    func updateView() {
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
        
        cell.setupCell(cartItemIndex: indexPath.item)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            Cart.removeFromCart(itemIdex: indexPath.row)
            tableView.reloadData()
            
            if Cart.cart.isEmpty {
                updateView()
            }
        }
    }
    
    // MARK: - Navigation
    
}
