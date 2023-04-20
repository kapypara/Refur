//
//  CheckoutTableViewController.swift
//  Refur
//
//  Created by iOSdev on 16/04/2023.
//

import UIKit




class CheckoutTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
 
  
    // MARK: Outlets
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var totalItemsLbl: UILabel!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var addressBtnClicked: UIButton!
    
    @IBOutlet var creditChosen: UIButton!
    @IBOutlet var benefitChosen: UIButton!
    @IBOutlet var applePayChosen: UIButton!
    
    @IBOutlet var completeBtn: UIButton!
    
    @IBOutlet var checkoutCollection: UICollectionView!
    
    // MARK: Vars
    
    var checkoutItems: [CartItem] = []
   

    @IBAction func PaymentButtonPressed(_ sender: UIButton) {
        switch sender {
        case creditChosen:
            creditChosen.isSelected = true
            benefitChosen.isSelected = false
            applePayChosen.isSelected = false
            
        case benefitChosen:
            creditChosen.isSelected = false
            benefitChosen.isSelected = true
            applePayChosen.isSelected = false
            
        case applePayChosen:
            creditChosen.isSelected = false
            benefitChosen.isSelected = false
            applePayChosen.isSelected = true
            
        default:
            print("[CheckoutTableViewController.PaymentButtonPressed]: unkown button pressed")
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
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutCollection.delegate = self
        checkoutCollection.dataSource = self
        totalItemsLbl.text = "Total items: " + String(checkoutItems.count) 
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: collection View functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        checkoutItems = Cart.cart.filter { return $0.selection }
        
        return checkoutItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "checkoutCell", for: indexPath) as!
        CheckoutCollectionViewCell
        
        
        cell.setupCell(post: checkoutItems[indexPath.item].item)
        
        
        return cell
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
