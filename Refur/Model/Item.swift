
enum ItemCondition {
    case BrandNew, AsGoodAsNew, GoodCondition, /* Decent */ Used
}

enum ItemCategory {
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
    
    // MARK: Clothing init
    static func Clothing(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: ClothingType, size: ClothingSize) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Clothing, type: type, size: size)
    }

    static func Clothing(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: ClothingType, size: Double) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Clothing, type: type, size: size)
    }

    // MARK: Shoe init
    static func Shoes(name: String, description: String,
            condition: ItemCondition, price: Double,
            ShoeSize: Double) -> Item {

        return Clothing(name: name, description: description,
                condition: condition, price: price,
                type: ClothingType.Shoes, size: ShoeSize)
    }


    // MARK: Book init
    static func Book(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: BookType) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Book, type: type, size: nil)
    }


    // MARK: Other init
    static func Other(name: String, description: String,
            condition: ItemCondition, price: Double,
            type: OtherTYpe) -> Item {

        return Item(name: name, description: description,
                condition: condition, price: price,
                category: ItemCategory.Other, type: type, size: nil)
    }



    private init(name: String, description: String,
         condition: ItemCondition, price: Double,
         category: ItemCategory, type: Any, size: Any?) {
        
        self.name = name
        self.description = description
        
        self.price = price
        self.condition = condition
        
        self.category = category

        self.type = type
        self.size = size
    }
}


// MARK: category specific enum

enum ClothingType {
    case TShirt, Pants, Shoes, Hat
}

enum BookType {
    case Paperback, Hardcover
}
    
enum OtherTYpe {
    case Other, Anitque
}

enum ClothingSize {
    case Medium, Small, Large

    case XXS, XS, XL, XXL
}

