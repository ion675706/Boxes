import Foundation
import RealmSwift
import Combine

final class AllItemsViewModel: ObservableObject {
    @ObservedResults(ItemDomainModel.self) var items
    @ObservedResults(ContainerDomainModel.self) var containers
    
    func addItem(
        name: String,
        descriptionText: String = "",
        photo: Data? = nil,
        creationTime: Date = Date(),
        room: String = "",
        container: ContainerDomainModel? = nil,
        category: CategoryDomainModel? = nil
    ) {
        let item = ItemDomainModel(
            name: name,
            descriptionText: descriptionText,
            photo: photo,
            creationTime: creationTime,
            room: room,
            container: container,
            category: category
        )
        
        if let realm = container?.realm {
            try? realm.write {
                containers.first(where: { $0.id == container?.id })?.items.append(item)
            }
        }
        
    }
    
    func deleteItem(_ item: ItemDomainModel) {
        
        guard let realm = try? Realm(),
              let object = realm.object(ofType: ItemDomainModel.self, forPrimaryKey: item.id) else { return }
        try? realm.write {
            realm.delete(object)
        }
    }
} 
