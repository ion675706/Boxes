import Foundation
import RealmSwift
import Combine

final class CategoryViewModel: ObservableObject {
    @ObservedResults(CategoryDomainModel.self) var categories
    
    var realmCancelable: AnyCancellable?
    
    init() {
        realmCancelable = categories.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    
    func addCategory(title: String, color: String = "") {
        let category = CategoryDomainModel(title: title, color: color)
        $categories.append(category)
    }
    
    
    func deleteCategory(_ category: CategoryDomainModel) {
        guard let realm = category.realm else { return }
        try? realm.write {
            realm.delete(category)
        }
    }
} 
