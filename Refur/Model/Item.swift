
enum ItemCondition {
    case BrandNew, AsGoodAsNew, GoodCondition, Decent
}

enum ItemCategory {
    case clothing, books, other
}

enum ItemType {
    case tShirt, Pants, shoes, hats
    
    case paperback, hardcover
    
    case other, anitque
}

enum itemSize {
    case medium, small, large, XL
}

class Item {

    var name: String
    var description: String
    
    var condition: ItemCondition
    var price: Double
    
    var category: ItemCategory
    var type: ItemType
    var size: itemSize
    
    init(name: String, description: String,
         condition: ItemCondition, price: Double,
         category: ItemCategory, type: ItemType, size:itemSize) {
        
        self.name = name
        self.description = description
        
        self.condition = condition
        self.price = price
        
        self.category = category
        self.type = type
        self.size = size
        
    }
}

//let myItem = item()

