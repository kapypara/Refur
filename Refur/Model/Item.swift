
enum ItemCondition: String {
    case BrandNew, AsGoodAsNew, GoodCondition, /* Decent */ Used
}

enum ItemCategory: String {
    case Clothing, Book, Other
}


class Item {

    var name: String
    var description: String
    
    var price: Double
    var condition: ItemCondition
    
    let category: ItemCategory

    // the type and size will be set depending on the category
    let type: Any?
    let size: Any?
    var brand: String? = nil
    
    // MARK: Clothing init
    static func Clothing(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: ClothingType, brnad: String, size: ClothingSize) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Clothing, brand: brnad, type: type, size: size)
    }

    static func Clothing(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: ClothingType, brnad: String, size: Double) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Clothing, brand: brnad, type: type, size: size)
    }

    // MARK: Shoe init
    static func Shoes(name: String, description: String,
            condition: ItemCondition, price: Double,
            brand: String, ShoeSize: Double) -> Item {

        return Clothing(name: name, description: description,
                condition: condition, price: price,
                type: ClothingType.Shoes, brnad: brand, size: ShoeSize)
    }


    // MARK: Book init
    static func Book(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: BookType) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Book, brand: "", type: type, size: nil)
    }


    // MARK: Other init
    static func Other(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: OtherType) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Other, brand: "", type: type, size: nil)
    }



    private init(name: String, description: String,
         condition: ItemCondition, price: Double,
        category: ItemCategory, brand: String?, type: Any, size: Any?) {
        
        self.name = name
        self.description = description
        
        self.price = price
        self.condition = condition
        
        self.category = category

        self.type = type
        self.size = size
        
        self.brand = brand
    }
    
    
    static func loadItem(dictionary: [String: Any]) -> Item? {
        
        // making sure common item field are present
        guard
            let categoryString = dictionary["Category"] as? String,
            let category = ItemCategory(rawValue: categoryString),
            
            let conditionString = dictionary["Condition"] as? String,
            let condition = ItemCondition(rawValue: conditionString),
            
            let price = dictionary["Price"] as? Double,
            let name = dictionary["Name"] as? String,
            let description = dictionary["Description"] as? String
        else {
            print("[Item.loadItem] early parsing error, dumping dict", dictionary)
            return nil
        }
        
        switch category {
        case .Clothing:
            guard
                let sizeString = dictionary["Size"] as? String,
                let size = ClothingSize(rawValue: sizeString),
                
                let typeString = dictionary["Type"] as? String,
                let type = ClothingType(rawValue: typeString),
                
                let brand = dictionary["Brand"] as? String
                    
            else {
                print("[Item.loadItem] error parsing Clothing item, dumping dict", dictionary)
                return nil
            }
            
            return Item(name: name, description: description, condition: condition, price: price, category: category, brand: brand, type: type, size: size)
            
        case .Book:
            guard
                let typeString = dictionary["Type"] as? String,
                let type = BookType(rawValue: typeString)
                    
            else {
                print("[Item.loadItem] error parsing Clothing item, dumping dict", dictionary)
                return nil
            }
            
            return Item(name: name, description: description, condition: condition, price: price, category: category, brand: nil, type: type, size: nil)
            
        case .Other:
            guard
                let typeString = dictionary["Type"] as? String,
                let type = OtherType(rawValue: typeString)
                    
            else {
                print("[Item.loadItem] error parsing Clothing item, dumping dict", dictionary)
                return nil
            }
            
            return Item(name: name, description: description, condition: condition, price: price, category: category, brand: nil, type: type, size: nil)
            
        }
        
    }
}


// MARK: category specific enum

enum ClothingType: String {
    case TShirt, Pants, Shoes, Hat
}

enum BookType: String {
    case Paperback, Hardcover
}
    
enum OtherType: String {
    case Other, Anitque
}

enum ClothingSize: String {
    case Medium, Small, Large

    case XXS, XS, XL, XXL
}

