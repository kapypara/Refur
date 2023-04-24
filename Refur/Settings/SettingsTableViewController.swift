//
//  SettingsTableViewController.swift
//  Refur
//
//  Created by Yousif Isa Shamtoot on 20/04/2023.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var selectedType: TextType?

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: // orders
            
            performSegue(withIdentifier: "toOrders", sender: self)
            break
            
        case 1: // privacy policy
            selectedType = .Privacy
            performSegue(withIdentifier: "toTextPage", sender: self)
            
        case 2: // help & feedback
            selectedType = .Help
            performSegue(withIdentifier: "toTextPage", sender: self)
            
        case 3: // about us
            selectedType = .About
            performSegue(withIdentifier: "toTextPage", sender: self)
            
        default: // log out
            prompatLogout()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func prompatLogout() {
        let alert = UIAlertController(title: "Sign-Out", message: "Are you sure you want to Sign out?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
            User.signOut() { wasSuccessful in
                if wasSuccessful {
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                }
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTextPage" {
            
            let view = segue.destination as? TextPageViewController
            view?.textType = selectedType
        }
    }

}
