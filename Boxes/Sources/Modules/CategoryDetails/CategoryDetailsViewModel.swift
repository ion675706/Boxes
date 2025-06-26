import Foundation
import RealmSwift

final class CategoryDetailsViewModel: ObservableObject {
    @Published var items: [ItemDomainModel] = []
    let category: CategoryDomainModel

    init(category: CategoryDomainModel) {
        self.category = category
        self.items = Array(category.items)
    }
    
} 
