//
//  CheckoutTableViewController.swift
//  Refur
//
//  Created by iOSdev on 16/04/2023.
//

import UIKit

class CheckoutTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  
    
    
    
    var checkoutItems : [Post] = [] {
        didSet {
            checkoutCollection.reloadData()
        }
    }
    
    
    
    @IBOutlet var addressLbl: UILabel!
    
    
    @IBOutlet var totalItemsLbl: UILabel!
    
    
    @IBOutlet var addressField: UITextField!
    
    
    @IBOutlet var addressBtnClicked: UIButton!
    
    
    
    @IBOutlet var creditChosen: UIButton!
    
    
    @IBOutlet var benefitChosen: UIButton!
    
    
    
    
    @IBOutlet var applePayChosen: UIButton!
    
    
    @IBOutlet var completeBtn: UIButton!
    
    
    @IBOutlet var checkoutCollection: UICollectionView!
    
    
    @IBAction func debitBtnPressed(_ sender: UIButton) {
        
        creditChosen.isSelected.toggle()
        if benefitChosen.isSelected {
            benefitChosen.isSelected.toggle()
        }
        if applePayChosen.isSelected {
            applePayChosen.isSelected.toggle()
        }
    }
    
    
    @IBAction func benefitBtnPressed(_ sender: UIButton) {
        
        benefitChosen.isSelected.toggle()
        if creditChosen.isSelected {
            creditChosen.isSelected.toggle()
        }
        if applePayChosen.isSelected {
            applePayChosen.isSelected.toggle()
        }
        
    }
    
    
    @IBAction func appleBtnPressed(_ sender: UIButton) {
        
        applePayChosen.isSelected.toggle()
        if creditChosen.isSelected {
            creditChosen.isSelected.toggle()
        }
        if benefitChosen.isSelected {
            benefitChosen.isSelected.toggle()
        }
        
        
    }
    
    

    @IBAction func AddressClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Address input", message: "Enter your address", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].text = self.addressLbl!.text
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default) {
            UIAlertAction in self.addressBtnClicked.setTitle(alert.textFields![0].text, for: .normal)
        })
        
        
        
        self.present(alert, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkoutItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "checkoutCell", for: indexPath) as!
        CheckoutCollectionViewCell
        
        cell.setupCell(post: checkoutItems[indexPath.row])
        
        
        return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutCollection.delegate = self
        checkoutCollection.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source



    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
