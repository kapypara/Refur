//
//  AddTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 01/04/2023.
//

import UIKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemImage: UIImage? = nil //UIImage(systemName: "photo.fill.on.rectangle.fill")!
    
    var postButtonEnabled = true {
        didSet {
            tableView.reloadData()
        }
    }
    
    var fields: AddItems = AddItems()
    
    var extraCells: Int {
        fields.category == ItemCategory.Clothing ? 0 : 1
    }
    
    var clear = 1
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.isLoggedOut {
            unwindIfNotLoggedIn(segueIdentifier: "Home")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fields.controller = self
        
        //tableView.usesAutomaticRowHeights = true
    }
    
    // MARK: Add item function
    @IBAction func newItem() {
        // TODO: add safety meausrs
        
        postButtonEnabled = false
        
        guard
            let name = fields.name,
            let price = fields.price,
            let category = fields.category,
            let condition = fields.condition
        else {
            let alert = UIAlertController(
                title: "Missing Fields",
                message: "please fill all fields",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            
            self.present(alert, animated: true)
            
            self.postButtonEnabled = true
            return
        }
        
        let description = fields.description ?? ""
        let brand = fields.description ?? ""
        
        var item: Item
        
        switch category {
        case .Clothing:
            item = Item.Clothing(name: name, description: description, condition: condition, price: price, type: .TShirt, brnad: brand, size: .Medium)
            
        case .Book:
            item = Item.Book(name: name, description: description, condition: condition, price: price, type: .Hardcover)
            
        case .Other:
            item = Item.Other(name: name, description: description, condition: condition, price: price, type: .Other)
        }
        

        guard let image = itemImage else { return }
        
        Database.Storage.saveImage(image: image) { loadedString in

            guard
                let postUuid = loadedString
            else {
                
                let alert = UIAlertController(
                    title: "No Image",
                    message: "please input a Image",
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                
                self.present(alert, animated: true)
                
                self.postButtonEnabled = true
                return
            }
            
            let newPost = Post(item: item, images: [postUuid])
            
            Post.savePost(post: newPost)
            
            Database.Users.getUser(user: User.uid!) { loadedProfile in
                
                guard
                    var posts = loadedProfile?.posts
                else {
                    let alert = UIAlertController(
                        title: "Post Submation Failed",
                        message: "please retry again",
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                    
                    self.present(alert, animated: true)
                    
                    self.postButtonEnabled = true
                    return
                }
                
                posts.insert(newPost.postUuid, at: 0)
                
                Database.Users[User.uid! + "/Posts"].setValue(posts)
                
                
                let alert = UIAlertController(
                    title: "Post Submation succesed",
                    message: "your post is now viewable",
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                
                self.present(alert, animated: true)
                
                
                // clearing data
                self.postButtonEnabled = true
                
                self.fields = AddItems()
                self.fields.controller = self
                
                self.clear = 0
                self.tableView.reloadData()
                self.clear = 1
                self.tableView.reloadData()
                
            }
        }
        
        //print(item.name)
        
    }
    
    
    // MARK: tableView function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (7 - extraCells) * clear
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemHeadCell", for: indexPath) as! ItemHeadCell
            
            cell.setupCell(fields, image: itemImage ?? UIImage(systemName: "photo.fill.on.rectangle.fill")!)
            
            return cell
            
        case 1:
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PirceCell", for: indexPath) as! PirceCell
            
            cell.setupCell(fields)
            
            return cell
            
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropMenuCell", for: indexPath) as! DropMenuCell
            
            cell.setupCell(fields, type: .Category, selections: [ ItemCategory.Clothing.rawValue, ItemCategory.Book.rawValue, ItemCategory.Other.rawValue ])
            
            return cell
            
        default:
            break
        }
        
        
        let indexOffset = indexPath.row + extraCells
        
        switch indexOffset {
        case 3: // brand
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as! FieldCell
            
            cell.setupCell(fields)
            
            return cell
            
        case 4: // condition
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropMenuCell", for: indexPath) as! DropMenuCell
            
            cell.setupCell(fields, type: .Condition, selections: [ ItemCondition.BrandNew.rawValue, ItemCondition.AsGoodAsNew.rawValue, ItemCondition.Used.rawValue ])
            
            return cell
            
        case 5: //Description
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.setupCell(fields)
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            
            cell.setupCell(postButtonEnabled)
            
            return cell
        }
    }
    
    
    // MARK: Image Picker Button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        present(viewController, animated: true)
    }

    // MARK: Image Picker delegate and functionality
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            itemImage = image
            tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func unwindToAddPage(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
}

